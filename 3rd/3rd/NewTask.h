//
//  NewTask.h
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTask : UITableViewController
@property (nonatomic,copy)NSString *name;
-(id)initWithName:(NSString *)name;

@end
