//
//  XXCalculatorViewController.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/22/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXCalculatorViewController.h"
#import "XXDataManager.h"
#import "XXNumberPadExtension.h"
#import "XXCalculateResultViewController.h"

@interface XXCalculatorViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *houseFlagView;

@end

@implementation XXCalculatorViewController {
    NSMutableArray *users;
    XXDataManager *dataManager;
    
    NSMutableDictionary *viewlist;
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
    
    dataManager = [XXDataManager instance];
    users = [dataManager getUsers];
    viewlist = [[NSMutableDictionary alloc] init];
    
    [XXNumberPadExtension loadExtension];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSDictionary *user = [users objectAtIndex:indexPath.row];
    NSNumber *uid = [user objectForKey:@"id"];
    NSString *uname = [user objectForKey:@"name"];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"u%@.png", uid]]];
    [cell.textLabel setText:uname];
    UITextField *tv = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, 200, 30)];
    [tv setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [tv setKeyboardType:UIKeyboardTypeNumberPad];
    [tv setClearButtonMode:UITextFieldViewModeAlways];
    [tv setText:[NSString stringWithFormat:@"%@", [user objectForKey:@"count"]]];
    [cell.contentView addSubview:tv];
    [viewlist setObject:tv forKey:uid];
    return cell;
}

- (IBAction)swichHouseFlag:(id)sender {
    if (self.houseFlagView.isOn) {
        for (NSNumber *key in viewlist.keyEnumerator) {
            UITextField *tv = [viewlist objectForKey:key];
            if (tv.text && ![tv.text isEqualToString:@""]) {
                int tcount = [tv.text intValue];
                int capability = 0;
                for (NSDictionary *user in users) {
                    if ([[user objectForKey:@"id"] intValue] == [key intValue]) {
                        capability = [[user objectForKey:@"capability"] intValue];
                        break;
                    }
                }
                if (tcount % capability == 0) {
                    tcount = tcount / capability;
                } else {
                    tcount = tcount/capability+1;
                }
                [tv setText:[NSString stringWithFormat:@"%d", tcount]];
            }
        }
    } else {
        for (NSNumber *key in viewlist.keyEnumerator) {
            UITextField *tv = [viewlist objectForKey:key];
            if (tv.text && ![tv.text isEqualToString:@""]) {
                int tcount = [tv.text intValue];
                int capability = 0;
                for (NSDictionary *user in users) {
                    if ([[user objectForKey:@"id"] intValue] == [key intValue]) {
                        capability = [[user objectForKey:@"capability"] intValue];
                        break;
                    }
                }
                tcount = tcount * capability;
                [tv setText:[NSString stringWithFormat:@"%d", tcount]];
            }
        }
    }
}

- (IBAction)calculate:(id)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    for (NSNumber *key in viewlist.keyEnumerator) {
        UITextField *tv = [viewlist objectForKey:key];
        [param setObject:[NSNumber numberWithInt:[tv.text intValue]] forKey:key];
    }
    [dataManager saveUsers:param houseFlag:self.houseFlagView.isOn];
    
    
    XXCalculateResultViewController *result = [[XXCalculateResultViewController alloc] init];
    [result setTitle:@"Result"];
    [self.navigationController pushViewController:result animated:YES];
}

- (IBAction)swipeLeft:(id)sender {
    [self calculate:nil];
}

- (IBAction)swipeRight:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tap:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
