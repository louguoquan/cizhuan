//
//  JYC2CRecordListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYC2CRecordListViewController.h"
#import "JYAssetsService.h"
#import "YSProductService.h"
#import "JYC2CRecordListCell.h"
#import "YSPagingListService.h"


@interface JYC2CRecordListViewController ()

@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic,strong)UILabel *navigationLabel;

@end

@implementation JYC2CRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.navigationItem.title = @"USDT";
    
    [self setupTableView];
    
    [self fetchProductList:NO];
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _navigationLabel;
    _navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    _navigationLabel.text = @"充值提现记录";
    
    
    
}

- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchCollectProductList:page:completion:)];
    
    self.tableView.estimatedRowHeight = 110.f;
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.tableView registerClass:[JYC2CRecordListCell class] forCellReuseIdentifier:@"JYC2CRecordListCell"];
    
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
//        YSProduct *product = userInfo[kButtonDidClickRouterEvent];
//        [YSProductService collectionProduct:product.productId completion:^(id result, id error) {
//            [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
//
//            [self.service.dataSource removeObject:product];
//            [self.tableView reloadData];
//        }];
    }
}

#pragma mark - tableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYC2CRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYC2CRecordListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.model = _service.dataSource[indexPath.row];
//    cell.model = @"1";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}



@end
