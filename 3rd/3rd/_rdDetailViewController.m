//
//  _rdDetailViewController.m
//  3rd
//
//  Created by BINGCHEN YU on 1/30/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "_rdDetailViewController.h"

@interface _rdDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AddTask;
- (void)configureView;
@end

@implementation _rdDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textShouldReturn:(UITextField *) AddTask{
    if (AddTask == self.AddTask) {
        [AddTask resignFirstResponder];
    }
    return YES;
}
@end
