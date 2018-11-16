//
//  CTProductSelectSubViewContrroller.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductSelectSubViewContrroller.h"
#import "CTProductCell.h"
#import "CTProductDetailViewController.h"

@interface CTProductSelectSubViewContrroller ()

@end


@implementation CTProductSelectSubViewContrroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTProductCell class] forCellReuseIdentifier:@"CTProductCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTProductCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTProductDetailViewController *vc = [[CTProductDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
