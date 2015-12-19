//
//  ViewController.m
//  MyTableView
//
//  Created by Anh Tuan on 11/30/15.
//  Copyright (c) 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "ViewController.h"
#import "ChecklistItem.h"
#import "AddTableViewController.h"
#import "DescriptionsTableViewController.h"
@interface ViewController ()<AddTableViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *listItems;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.listItems = [[NSMutableArray alloc] init];
//    ChecklistItem *item = [[ChecklistItem alloc] init];
//    [item setTitle:@"item 1"];
//    [self.listItems addObject:item];
//    [self.listItems addObject:item];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.listItems objectAtIndex:[indexPath row]] title];
    NSDate *date = [[self.listItems objectAtIndex:[indexPath row]] dueDate];
    NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
    [formatDate setDateFormat:@"MMM dd, yyyy"];
    cell.detailTextLabel.text = [formatDate stringFromDate:date];
    
    return cell;
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listItems removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    [self saveData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addItem"]) {
        NSLog(@"Add item");
        UINavigationController *navigation = segue.destinationViewController;
        AddTableViewController *controller = (AddTableViewController *)[navigation topViewController];
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"editItem"]) {
        NSLog(@"Edit item");
        UINavigationController *navigation = segue.destinationViewController;
        AddTableViewController *controller = (AddTableViewController *)[navigation topViewController];
        controller.title = @"Edit item";
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.editItem = [self.listItems objectAtIndex:indexPath.row];
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showDescription"]) {
        NSLog(@"show description");
        DescriptionsTableViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.transferItem = [self.listItems objectAtIndex:indexPath.row];
    }
}

#pragma mark - Delegate: Add item

- (void)addItem:(ChecklistItem *)item {
    [self.listItems addObject:item];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.listItems count]-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    [self saveData];
}

#pragma mark - Delegate: Edit item

- (void)editItem:(ChecklistItem *)item {
    NSInteger index = [self.listItems indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self saveData];
}

#pragma mark - Saving data

- (NSString *)dataPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", path);
    return path;
}

- (void)saveData {
    NSString *filePath = [[self dataPath] stringByAppendingPathComponent:@"data.plist"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.listItems forKey:@"listItems"];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"%@", filePath);
}

- (void)loadData {
    NSString *filePath = [[self dataPath] stringByAppendingPathComponent:@"data.plist"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.listItems = [unarchiver decodeObjectForKey:@"listItems"];
    [unarchiver finishDecoding];
}
@end
