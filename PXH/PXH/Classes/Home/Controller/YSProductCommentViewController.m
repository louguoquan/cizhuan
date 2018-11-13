//
//  YSAllCommentViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductCommentViewController.h"
#import "YSLifecircleService.h"
#import "YSCommentTableViewCell.h"

#import "YSProductService.h"
#import "YSPagingListService.h"

@interface YSProductCommentViewController ()

@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YSProductCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"产品评论";
    
    self.dataSource = [NSMutableArray array];
    [self setup];
    [self fetchCommentList];
//    [self fetchCommentListWithLoadMore:NO];
}

- (void)setup {
//    _service = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchProductCommentList:page:completion:)];
    
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
//    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf fetchCommentListWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf fetchCommentListWithLoadMore:YES];
    }];
}

#pragma mark - 获取电子券列表
- (void)fetchCommentList
{
//    [YSLifecircleService fetchGetCouponComment:_productId completion:^(id result, id error) {
//        [_dataSource addObjectsFromArray:result];
//        [self.tableView reloadData];
//    }];
    NSString *url = _type == 1 ? kProductCommentList_URL : KGetCouponComment_URL;
    NSDictionary *parameters = _type == 1 ? @{@"productId": _productId} : @{@"couponId" : _productId};
    [YSLifecircleService fetchGetCouponCommentURL:url parameters:parameters completion:^(id result, id error) {
        
        [_dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        
    }];
}

- (void)fetchCommentListWithLoadMore:(BOOL)loadMore {
    [_service loadDataWithParameters:@{@"productId":_productId} isLoadMore:loadMore completion:^(id result, id error) {
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.comment = _dataSource[indexPath.row];
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
