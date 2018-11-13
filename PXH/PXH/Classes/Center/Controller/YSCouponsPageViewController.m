//
//  YSCouponsPageViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponsPageViewController.h"

#import "YSCouponsViewController.h"
#import "YSTicketViewController.h"

@interface YSCouponsPageViewController ()

@end

@implementation YSCouponsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的卡券";
    [self renderUI];
}

#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    return index == 0 ? [YSCouponsViewController class] : [YSTicketViewController class];
}

- (NSArray *)titlesForPageViewController {
    return @[@"优惠券", @"电子券"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
