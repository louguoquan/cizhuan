//
//  CTStuckAssistantViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTStuckAssistantViewController.h"
#import "CTStuckAssistantCell.h"
#import "CTStuckAssistantHeadView.h"

@implementation CTStuckAssistantViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"铺贴助手";
    
    CTStuckAssistantHeadView *head = [[CTStuckAssistantHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    self.tableView.tableHeaderView = head;
    
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTStuckAssistantCell class] forCellReuseIdentifier:@"CTStuckAssistantCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTStuckAssistantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTStuckAssistantCell"];
    return cell;
}

@end
