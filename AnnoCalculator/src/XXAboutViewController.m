//
//  XXAboutViewController.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/23/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXAboutViewController.h"

@interface XXAboutViewController ()

@end

@implementation XXAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipRight:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
