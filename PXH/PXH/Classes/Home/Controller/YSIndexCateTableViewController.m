//
//  YSIndexCateTableViewController.m
//  PXH
//
//  Created by yu on 2017/8/1.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSIndexCateTableViewController.h"
#import "YSCateProductPageViewController.h"
#import "YSProductDetailViewController.h"
#import "YSOrderService.h"
#import "YSProductTableViewCell.h"
#import "YSCateHeaderView.h"

#import "YSPagingListService.h"
#import "YSProductService.h"
#import "YSCateService.h"

@interface YSIndexCateTableViewController ()

@property (nonatomic, strong) YSCateHeaderView  *headerView;

@property (nonatomic, strong) YSPagingListService   *pagingService;

@property (nonatomic, copy)   NSArray   *cateArray;

@end

@implementation YSIndexCateTableViewController

- (YSPagingListService *)pagingService {
    if (!_pagingService) {
        _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchProductList:page:completion:)];
    }
    return _pagingService;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self fetchProductListWithLoadMore:NO];
    [self fetchCategoryList];
}

- (void)setupTableView {
    
    self.tableView.rowHeight = 144.f;
    
    WS(weakSelf);
    _headerView = [[YSCateHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _headerView.block = ^(NSInteger tag) {
        YSCateProductPageViewController *vc = [YSCateProductPageViewController new];
        vc.dataSource = weakSelf.cateArray;
        vc.title = weakSelf.cate.name;
        vc.pageIndex = tag == 7 ? 0 : tag;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = _headerView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:NO];
        [weakSelf fetchCategoryList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:YES];
    }];
}

- (void)fetchProductListWithLoadMore:(BOOL)loadMore {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:1];
    parameters[@"pcatId"] = _cate.ID;
    [self.pagingService loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
        
        NSArray *array = (NSArray *)result;
        if (array.count == 0) {
            self.tableView.mj_footer = nil;
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)fetchCategoryList {

    if (!_cate.ID) {
        return;
    }
    [YSCateService fetchChildCate:_cate.ID completion:^(id result, id error) {
        _cateArray = result;
        
        _headerView.cateArray = _cateArray;
        self.tableView.tableHeaderView = _headerView;
    }];
}



#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pagingService.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cells = @"cells";
    YSProductTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[YSProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
    }
    cell.product = self.pagingService.dataSource[indexPath.row];
    cell.addShopCart = ^(NSString *ID) {
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            [self addShopCarts:ID];
        } else {
            [self judgeLoginActionWith:1];
        }
    };
    return cell;
}

- (void)addShopCarts:(NSString *)ID
{
    [YSOrderService addProductToShoppingCart:ID standardId:nil number:1 completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    YSProduct *product = self.pagingService.dataSource[indexPath.row];
    vc.productId = product.productId;
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
