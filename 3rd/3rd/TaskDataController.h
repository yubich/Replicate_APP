//
//  TaskDataController.h
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTask;

@interface TaskDataController : UITableViewController


@property (nonatomic, copy) NSMutableArray *masterTaskList;
- (NSInteger) countOfList;
- (NewTask *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addNewTask:(NewTask *)task;
- (void) deleteRows:(NSIndexPath *)indexPath;


@end
