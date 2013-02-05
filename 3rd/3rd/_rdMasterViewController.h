//
//  _rdMasterViewController.h
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskDataController;

@interface _rdMasterViewController : UITableViewController
@property (strong, nonatomic) TaskDataController *dataController;
- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancle:(UIStoryboardSegue *)segue;
@end
