//
//  CTBrandRankingListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTBrandRankingListViewController.h"
#import "CTBrandRankCell.h"

@interface CTBrandRankingListViewController ()

@end

@implementation CTBrandRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTBrandRankCell class] forCellReuseIdentifier:@"CTBrandRankCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTBrandRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTBrandRankCell"];
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
