//
//  _rdDetailViewController.h
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _rdDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
