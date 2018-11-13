//
//  YSOrderTableViewController.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderTableViewController.h"
#import "YSOrderDetailViewController.h"
#import "YSCommentPublishViewController.h"
#import "YSRefundsApplyViewController.h"
#import "YSRefundsDetailViewController.h"
#import "YSSalesReturnViewController.h"
#import "YSWebViewController.h"
#import "YSPayViewController.h"
#import "YSDeliverViewController.h"

#import "YSOrderProductTableViewCell.h"
#import "YSOrderSectionHeaderView.h"
#import "YSOrderSectionFooterView.h"

#import "YSPagingListService.h"
#import "YSOrderService.h"

@interface YSOrderTableViewController ()

@property (nonatomic, strong) YSPagingListService   *pagingService;

@end

@implementation YSOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pageIndex == 6) {
        self.navigationItem.title = @"退货售后";
    }
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchOrderListWithLoadMore:NO];
}


- (void)setup {
    
    _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSOrderService class] action:@selector(fetchOrderList:page:completion:)];
    
    self.tableView.rowHeight = 110.f;
    [self.tableView registerClass:[YSOrderProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[YSOrderSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.tableView registerClass:[YSOrderSectionFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchOrderListWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchOrderListWithLoadMore:YES];
    }];
}

- (void)fetchOrderListWithLoadMore:(BOOL)loadMore {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (self.pageIndex != 0) {
        if (self.pageIndex == 4) {
            parameters[@"status"] = @(11);
        }else if (self.pageIndex == 5) {
            parameters[@"status"] = @(3);
        }else if (self.pageIndex == 6) {
            parameters[@"status"] = @(5);
        }else {
            parameters[@"status"] = @(self.pageIndex - 1);
        }
    }
    [_pagingService loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - router Event

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSString *type = userInfo[@"type"];
        YSOrder *order = userInfo[@"model"];
        if ([type isEqualToString:@"立即付款"]) {
            YSPayViewController *vc = [YSPayViewController new];
            vc.totalPrice = order.amountFee;
            vc.orderId = order.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:@"取消订单"]) {
            
            [self cancelWith:order];
//            [self updateStatus:order url:kCancelOrder_URL parameters:nil];
        }else if ([type isEqualToString:@"申请退款"]) {
            YSRefundsApplyViewController *vc = [YSRefundsApplyViewController new];
            vc.order = order;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:@"确认收货"]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请问确认收货吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self updateStatus:order url:kConfirmReceipt_URL parameters:nil];

            }];
            [alert addAction:cancel];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else if ([type isEqualToString:@"查看物流"]) {
            if (order.sendMethod == 3) {
                YSWebViewController *webvc = [YSWebViewController new];
                webvc.urlString = [NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@", order.expressCode, order.expressNo];
                [self.navigationController pushViewController:webvc animated:YES];
            } else {
                //自提和品行专送页面
                YSDeliverViewController *deliver = [YSDeliverViewController new];
                deliver.order = order;
                [self.navigationController pushViewController:deliver animated:YES];
            }
            
        }else if ([type isEqualToString:@"评价"]) {
            YSCommentPublishViewController *vc = [YSCommentPublishViewController new];
            vc.order = order;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:@"退款详情"]) {
            YSRefundsDetailViewController *vc = [YSRefundsDetailViewController new];
            vc.order = order;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:@"申请退货"]) {
            YSSalesReturnViewController *vc = [YSSalesReturnViewController new];
            vc.order = order;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([type isEqualToString:@"删除订单"]) {
            [self updateStatus:order url:kDeleteOrder_URL parameters:nil];
        }
    }
}

- (void)updateStatus:(YSOrder *)order url:(NSString *)url parameters:(NSDictionary *)parameters {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"orderId"] = order.orderId;
    param[@"memberId"] = USER_ID;
    [MBProgressHUD showLoadingText:@"正在操作" toContainer:nil];
    [YSOrderService updateOrderStatus:url parameters:param completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"操作成功" toContainer:nil];
        [self fetchOrderListWithLoadMore:NO];
    }];
    
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _pagingService.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YSOrder *order = _pagingService.dataSource[section];
    return order.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    YSOrder *order = _pagingService.dataSource[indexPath.section];
    cell.orderProduct = order.items[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YSOrderSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    YSOrder *order = _pagingService.dataSource[section];
    [headerView setOrderNo:order.orderNo status:order.status];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YSOrderSectionFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    YSOrder *order = _pagingService.dataSource[section];
    view.order = order;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 95.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSOrderDetailViewController *vc = [YSOrderDetailViewController new];
    vc.order = _pagingService.dataSource[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelWith:(YSOrder *)order
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认取消订单吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confim = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateStatus:order url:kCancelOrder_URL parameters:nil];
    }];
    [alert addAction:cancel];
    [alert addAction:confim];
    [self presentViewController:alert animated:YES completion:nil];
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
