//
//  YSBillViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBillViewController.h"

#import "YSBillTableViewCell.h"

#import "YSPagingListService.h"

@interface YSBillViewController ()

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"账单";
    
    [self setupTableView];
    
    [self fetchAmountDetailWithLoadMore:NO];
}

- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSAccountService class] action:@selector(fetchAmountDetail:page:completion:)];
    
    [self.tableView registerClass:[YSBillTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchAmountDetailWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchAmountDetailWithLoadMore:YES];
    }];
}

- (void)fetchAmountDetailWithLoadMore:(BOOL)loadMore {
    [_service loadDataWithParameters:@{@"type" : @(1)} isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _service.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.detail = _service.dataSource[indexPath.row];
    return cell;
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
