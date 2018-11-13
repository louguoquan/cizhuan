//
//  YSMerchantsViewController.m
//  PXH
//
//  Created by yu on 2017/8/24.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantsViewController.h"
#import "YSMerchantsDetailViewController.h"

#import "YSLifeCircleTableViewCell.h"

#import "YSPagingListService.h"
#import "YSLifecircleService.h"

@interface YSMerchantsViewController ()

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSMerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = _cate.name;
    
    [self setup];
    [self fetchMerchantsList:NO];
}

- (void)setup {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSLifecircleService class] action:@selector(fetchMerchantsList:page:completion:)];
    
    self.tableView.rowHeight = 140.f;
    [self.tableView registerClass:[YSLifeCircleTableViewCell class] forCellReuseIdentifier:@"cell"];

    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchMerchantsList:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchMerchantsList:YES];
    }];
}

- (void)fetchMerchantsList:(BOOL)loadMore {
    [_service loadDataWithParameters:@{@"lifeCatId" : _cate.id} isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSLifeCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.merchants = _service.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSMerchantsDetailViewController *vc = [YSMerchantsDetailViewController new];
    vc.merchants = _service.dataSource[indexPath.row];
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
