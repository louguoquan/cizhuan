//
//  YSProductCollectionViewController.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductCollectionViewController.h"
#import "YSProductDetailViewController.h"

#import "YSProductCollectionTableViewCell.h"

#import "YSPagingListService.h"
#import "YSProductService.h"

@interface YSProductCollectionViewController ()

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSProductCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    [self setupTableView];
    
    [self fetchProductList:NO];
}

- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchCollectProductList:page:completion:)];
    
    self.tableView.rowHeight = 110.f;
    [self.tableView registerClass:[YSProductCollectionTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductList:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductList:YES];
    }];

    self.tableView.tableFooterView = [UIView new];
}

- (void)fetchProductList:(BOOL)loadMore {
    
    [_service loadDataWithParameters:nil isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - router Event 

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        YSProduct *product = userInfo[kButtonDidClickRouterEvent];
        [YSProductService collectionProduct:product.productId completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
            
            [self.service.dataSource removeObject:product];
            [self.tableView reloadData];
        }];
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSProductCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.product = _service.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSProduct *product = _service.dataSource[indexPath.row];
    if (product.status.integerValue == 0) {
        YSProductDetailViewController *vc = [YSProductDetailViewController new];
        
        vc.productId = product.productId;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [MBProgressHUD showErrorMessage:@"商品已下架" toContainer:self.view];
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
