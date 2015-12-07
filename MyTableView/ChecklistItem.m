//
//  ChecklistItem.m
//  MyTableView
//
//  Created by Anh Tuan on 11/30/15.
//  Copyright (c) 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"";
        NSString *date = @"Jan 01, 2000";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MMM dd, yyyy";
        self.dueDate = [dateFormatter dateFromString:date];
        self.description = @"details...";
    }
    return self;
}

@end
