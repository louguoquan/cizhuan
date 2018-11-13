//
//  YSSeckillViewController.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSeckillViewController.h"
#import "YSProductDetailViewController.h"

#import "YSSeckillViewCell.h"

#import "YSProductService.h"
#import "YSPagingListService.h"

@interface YSSeckillViewController ()

@property (nonatomic, strong) YSPagingListService   *pagingService;

@end

@implementation YSSeckillViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationItem.title = @"限量秒杀";
    self.navigationItem.title = @"限量抢购";
    
    [self setup];
    [self fetchProductListWithLoadMore:NO];
}

- (void)setup {
    _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchSeckillProductList:page:completion:)];
    
    self.tableView.rowHeight = 130.f;
    [self.tableView registerClass:[YSSeckillViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:YES];
    }];
}

- (void)fetchProductListWithLoadMore:(BOOL)loadMore {
    
    [_pagingService loadDataWithParameters:nil isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_pagingService.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSSeckillViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.product = _pagingService.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    YSSeckillProduct *seckillProduct = _pagingService.dataSource[indexPath.row];
    vc.productId = seckillProduct.productId;
    [self.navigationController pushViewController:vc animated:YES];
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
