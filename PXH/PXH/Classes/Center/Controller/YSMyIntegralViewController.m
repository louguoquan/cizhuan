//
//  YSMyIntegralViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMyIntegralViewController.h"
#import "YSWebViewController.h"
#import "YSIntegralRulesViewController.h"

#import "YSBillTableViewCell.h"

#import "YSPagingListService.h"

@interface YSMyIntegralViewController ()

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSMyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的积分";
    
    [self setup];
    
    [self fetchAmountDetailWithLoadMore:NO];
}

- (void)setup {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSAccountService class] action:@selector(fetchAmountDetail:page:completion:)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"integral_rule"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(checkRules)];
    self.navigationItem.rightBarButtonItem = item;

    [self.tableView registerClass:[YSBillTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 240.0 / 750.0 + 35)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"integral_bg"]];
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(kScreenWidth * 240.0 / 750.0);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:40];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%zd", [YSAccount sharedAccount].score];
    [imageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-20);
    }];

    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"剩余积分";
    [imageView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(20);
    }];

    UILabel *label2 = [UILabel new];
    label2.text = @"积分明细:";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = HEX_COLOR(@"#333333");
    [headerView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.left.offset(10);
        make.height.mas_equalTo(35);
    }];
    
    self.tableView.tableHeaderView = headerView;
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchAmountDetailWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchAmountDetailWithLoadMore:YES];
    }];

}

- (void)checkRules {
    YSIntegralRulesViewController *vc = [YSIntegralRulesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fetchAmountDetailWithLoadMore:(BOOL)loadMore {
    [_service loadDataWithParameters:@{@"type" : @(2)} isLoadMore:loadMore completion:^(id result, id error) {
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
