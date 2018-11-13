//
//  YSOrderPageViewController.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderPageViewController.h"
#import "YSOrderTableViewController.h"

@implementation YSOrderPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    
    [self renderUI];
    
    [self setSelectedIndex:self.pageIndex animated:YES];
}

#pragma mark - delegate

- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    return [YSOrderTableViewController class];
}

- (NSArray *)titlesForPageViewController {
    return @[@"全部", @"待付款", @"待发货", @"待收货", @"待提货", @"待评价"];
}


@end
