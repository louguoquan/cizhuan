//
//  CTAskFloorPriceViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTAskFloorPriceViewController.h"
#import "CTAskFloorPriceHead.h"
#import "CTAskOtherFactoryCell.h"

@implementation CTAskFloorPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"询底价";
    
    CTAskFloorPriceHead *head = [[CTAskFloorPriceHead alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 380)];
    self.tableView.tableHeaderView = head;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTAskOtherFactoryCell class] forCellReuseIdentifier:@"CTAskOtherFactoryCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTAskOtherFactoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTAskOtherFactoryCell"];
    return cell;
}

@end
