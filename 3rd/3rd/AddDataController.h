//
//  AddDataController.h
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTask;

@interface AddDataController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskInput;
@property (strong, nonatomic) NewTask *task;

@end
