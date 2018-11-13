//
//  YSTicketViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTicketViewController.h"
#import "YSCouponCommentViewController.h"

#import "YSOwnTicketTableViewCell.h"
#import "SDEmptyView.h"
#import "YSPagingListService.h"
#import "YSLifecircleService.h"

@interface YSTicketViewController ()

@property (nonatomic, strong) YSPagingListService   *pagingService;
@property (nonatomic, assign) NSInteger selectSection;

@property (nonatomic, strong) SDEmptyView *emptyView;

@end

@implementation YSTicketViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"使用电子券" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电子券";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(useCoupon:) name:@"使用电子券" object:nil];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchCouponsListWithLoadMore:NO];
}

- (void)setup {
    
    _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSLifecircleService class] action:@selector(fetchCouponsList:page:completion:)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 78.f;
    [self.tableView registerClass:[YSOwnTicketTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    parameters[@"type"] = @(2);
    [_pagingService loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
        
        if (_pagingService.dataSource.count == 0) {
            self.tableView.hidden = YES;
            self.emptyView = [[SDEmptyView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 124)];
            self.emptyView.imageName = @"empty";
            self.emptyView.text = @"暂无可用电子券";
            [self.view addSubview:_emptyView];
        } else {
            self.tableView.hidden = NO;
            [_emptyView removeFromSuperview];
            [self.tableView reloadData];
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - router Event

//- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
//    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
//        YSCoupons *coupon = userInfo[@"model"];
//
//        YSCouponCommentViewController *vc = [YSCouponCommentViewController new];
//        vc.coupon = coupon;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_pagingService.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSOwnTicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.coupons = _pagingService.dataSource[indexPath.section];
    cell.section = indexPath.section;
    cell.buttonAction = ^(NSDictionary *dic) {
        YSCoupons *coupons = dic[@"coupons"];
        _selectSection = [dic[@"section"] integerValue];
        if (coupons.status == 0) {
            [self judgeLoginActionWith:7];
        } else {
            YSCouponCommentViewController *vc = [YSCouponCommentViewController new];
            vc.coupon = coupons;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block) {
        self.block(_pagingService.dataSource[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 使用电子券
- (void)useCoupon:(NSNotification *)noti
{
    YSCoupons *coupons = _pagingService.dataSource[_selectSection];
    [YSLifecircleService fetchUseCoupon:coupons.ID completion:^(id result, id error) {
        [MBProgressHUD showText:@"使用成功" toContainer:nil];
        [self.tableView.mj_header beginRefreshing];
    }];
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
