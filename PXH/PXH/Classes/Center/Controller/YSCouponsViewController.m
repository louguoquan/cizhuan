//
//  YSCouponsViewController.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponsViewController.h"
#import "SDEmptyView.h"
#import "YSCouponsTableViewCell.h"

#import "YSPagingListService.h"
#import "YSLifecircleService.h"

@interface YSCouponsViewController ()

@property (nonatomic, strong) YSPagingListService   *pagingService;

@property (nonatomic, strong) SDEmptyView *emptyView;

@end

@implementation YSCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"优惠券";
    
    [self setup];
    
    [self fetchCouponsListWithLoadMore:NO];
}

- (void)setup {
    
    _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSLifecircleService class] action:@selector(fetchCouponsList:page:completion:)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    
    
    self.tableView.rowHeight = 80.f;
    [self.tableView registerClass:[YSCouponsTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchCouponsListWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchCouponsListWithLoadMore:YES];
    }];
}

- (void)fetchCouponsListWithLoadMore:(BOOL)loadMore {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @(1);
    if (_totalPrice > 0) {
        parameters[@"status"] = @(1);
        parameters[@"amount"] = @(_totalPrice);
    }
    
    [_pagingService loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
        
        if (_pagingService.dataSource.count == 0) {
            self.tableView.hidden = YES;
            self.emptyView = [[SDEmptyView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 124)];
            self.emptyView.imageName = @"empty";
            self.emptyView.text = @"暂无可用优惠券";
            [self.view addSubview:_emptyView];
        } else {
            self.tableView.hidden = NO;
            [_emptyView removeFromSuperview];
            [self.tableView reloadData];
        }

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_pagingService.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSCouponsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.coupons = _pagingService.dataSource[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block) {
        self.block(_pagingService.dataSource[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
