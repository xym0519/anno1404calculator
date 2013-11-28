//
//  XXCalculateResultViewController.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/23/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXCalculateResultViewController.h"
#import "XXDataManager.h"

@interface XXCalculateResultViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultView;

@end

@implementation XXCalculateResultViewController {
    XXDataManager *dataManager;
    NSArray *data;
}

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
    
    dataManager = [XXDataManager instance];
    data = [dataManager getResult];
    [self.resultView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSDictionary *dataitem = [data objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i%@.png",[dataitem objectForKey:@"id"]]]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@    %.2f",[dataitem objectForKey:@"name"], [[dataitem objectForKey:@"tcount"] floatValue]]];
    return cell;
}

- (IBAction)swipeRight:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
