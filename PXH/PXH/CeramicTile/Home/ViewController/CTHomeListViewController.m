//
//  CTHomeListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/12.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTHomeListViewController.h"
#import "CTTuiJianTableViewCell.h"
@interface CTHomeListViewController ()

@end

@implementation CTHomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTTuiJianTableViewCell class] forCellReuseIdentifier:@"CTTuiJianTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTTuiJianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTTuiJianTableViewCell"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
