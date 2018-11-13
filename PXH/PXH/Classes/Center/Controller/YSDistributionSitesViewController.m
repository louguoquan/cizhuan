//
//  YSDistributionSitesViewController.m
//  PXH
//
//  Created by yu on 2017/8/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDistributionSitesViewController.h"

#import "YSDistributionSitesCell.h"

//#import "YSLocationService.h"
#import "YSPagingListService.h"
#import "YSOrderService.h"

@interface YSDistributionSitesViewController ()

//@property (nonatomic, strong) CLLocation    *location;

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSDistributionSitesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"配送点";
    
    [self setupTableView];
    
    WS(weakSelf);
//    [[YSLocationService sharedService] getLocation:^(CLLocation *location, id error) {
//        weakSelf.location = location;
//        
//        [weakSelf fetchServiceStationWithLoadMore:NO];
//    }];
}

- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSOrderService class] action:@selector(fetchServiceStationList:page:completion:)];
    
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSDistributionSitesCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchServiceStationWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchServiceStationWithLoadMore:YES];
    }];
}

- (void)fetchServiceStationWithLoadMore:(BOOL)loadMore {
    
    if (!_service) {
        [MBProgressHUD showInfoMessage:@"获取位置失败" toContainer:nil];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        return;
    }
    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"lng"] = @(_location.coordinate.longitude);
//    parameters[@"lat"] = @(_location.coordinate.latitude);
//    [_service loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    }];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _service.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSDistributionSitesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.station = _service.dataSource[indexPath.row];
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
