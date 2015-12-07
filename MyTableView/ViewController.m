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

@interface ViewController ()<AddTableViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *listItems;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.listItems = [[NSMutableArray alloc] init];
    ChecklistItem *item = [[ChecklistItem alloc] init];
    [item setTitle:@"item 1"];
    [self.listItems addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    }
}

#pragma mark - Delegate: Add item

- (void)addItem:(ChecklistItem *)item {
    [self.listItems addObject:item];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.listItems count]-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

#pragma mark - Delegate: Edit item

- (void)editItem:(ChecklistItem *)item {
    NSInteger index = [self.listItems indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    
}

@end
