//
//  ChecklistItem.h
//  MyTableView
//
//  Created by Anh Tuan on 11/30/15.
//  Copyright (c) 2015 Nguyen Van Anh Tuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, strong) NSString *descriptionItem;

@end
