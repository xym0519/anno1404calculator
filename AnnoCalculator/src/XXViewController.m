//
//  XXViewController.m
//  AnnoCalculator
//
//  Created by Broche Xu on 8/18/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXViewController.h"
#import "XXDataManager.h"
#import "XXNumberPadExtension.h"
#import "XXCalculatorViewController.h"
#import "XXAboutViewController.h"

@interface XXViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menu;

@end

@implementation XXViewController {
    NSMutableArray *menuData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    menuData = [[NSMutableArray alloc] init];
    [menuData addObject:@"Calculator"];
    [menuData addObject:@"ProductionChain"];
    [menuData addObject:@"About"];
    
    XXCalculatorViewController *controller = [[XXCalculatorViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSString *item = [menuData objectAtIndex:indexPath.row];
    [cell.textLabel setText: item];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        XXCalculatorViewController *calculator = [[XXCalculatorViewController alloc] init];
        [calculator setTitle:@"Calculator"];
        [self.navigationController pushViewController:calculator animated:YES];
    } else if (indexPath.row == 1) {
        XXLog(@"222");
    } else if (indexPath.row == 2) {
        XXAboutViewController *controller = [[XXAboutViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
