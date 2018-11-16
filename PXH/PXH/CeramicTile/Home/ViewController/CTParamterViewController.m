//
//  CTParamterViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTParamterViewController.h"
#import "CTParamerHeadView.h"
#import "CTParamCell.h"
@interface CTParamterViewController ()

@end

@implementation CTParamterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CTParamerHeadView *head = [[CTParamerHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 380)];
    self.tableView.tableHeaderView = head;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CTParamCell class] forCellReuseIdentifier:@"CTParamCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTParamCell"];
    return cell;
}

@end
