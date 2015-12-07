//
//  AddTableViewController.h
//  MyTableView
//
//  Created by Anh Tuan on 11/30/15.
//  Copyright (c) 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistItem;

@protocol AddTableViewControllerDelegate <NSObject>

- (void)addItem:(ChecklistItem *)item;
- (void)editItem:(ChecklistItem *)item;

@end
@interface AddTableViewController : UITableViewController

@property (nonatomic, strong) ChecklistItem *editItem;
@property (nonatomic, strong) id <AddTableViewControllerDelegate> delegate;


@end
