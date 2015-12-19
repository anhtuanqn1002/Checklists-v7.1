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
        self.descriptionItem = @"details...";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"TITLE"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DUE_DATE"];
        self.descriptionItem = [aDecoder decodeObjectForKey:@"DESCRIPTION"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"TITLE"];
    [aCoder encodeObject:self.dueDate forKey:@"DUE_DATE"];
    [aCoder encodeObject:self.descriptionItem forKey:@"DESCRIPTION"];
}

@end
