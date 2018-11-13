//
//  YSServiceStationPickerViewController.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSServiceStationPickerViewController.h"

#import "YSServiceStationCell.h"
#import "YSButton.h"

#import "YSOrderService.h"
#import "YSPagingListService.h"

@interface YSServiceStationPickerViewController ()

@property (nonatomic, strong) YSButton  *checkButton;

@property (nonatomic, strong) YSPagingListService   *service;

//@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation YSServiceStationPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择配送点";
    [self setup];
    
    [self fetchServiceStationWithLoadMore:NO];
}

- (void)setup {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSOrderService class] action:@selector(fetchServiceStationList:page:completion:)];
    
    self.emptyDesc = @"该地址暂未入驻配送点\n系统默认发货方式为快递";
    self.emptyImage = [UIImage imageNamed:@"service_express"];
    self.verticalOffset = -20;
    
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSServiceStationCell class] forCellReuseIdentifier:@"cell"];
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchServiceStationWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchServiceStationWithLoadMore:YES];
    }];

    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-50);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:2 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView);
        make.right.offset(-10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(135);
    }];
    
    //服务点自提
    _checkButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    [_checkButton setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"check-pressed"] forState:UIControlStateSelected];
//    [_checkButton setImage:[UIImage imageNamed:@"checked-no"] forState:UIControlStateDisabled];
    _checkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_checkButton setTitle:@"配送点自提" forState:UIControlStateNormal];
    _checkButton.space = 10;
    [_checkButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        sender.selected = !sender.selected;
    }];
//    [_checkButton addTarget:self action:@selector(checkButton:) forControlEvents:UIControlEventTouchUpInside];
    [_checkButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    _checkButton.enabled = NO;
    [bottomView addSubview:_checkButton];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.offset(0);
    }];
}

- (void)confirm {
    if (_service.dataSource.count > 0) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (!indexPath) {
            [MBProgressHUD showInfoMessage:@"请选择配送点" toContainer:nil];
            return;
        }

        YSServiceStation *station = _service.dataSource[indexPath.row];
        station.takeTheir = _checkButton.selected;
        
        if (self.block) {
            self.block(station);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if (self.block) {
            self.block(nil);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)fetchServiceStationWithLoadMore:(BOOL)loadMore {
    
    [_service loadDataWithParameters:@{@"addressId" : _addressId} isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        _checkButton.enabled = _service.dataSource.count > 0 ? YES : NO;

    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSServiceStationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    YSServiceStation *station = _service.dataSource[indexPath.row];
    station.shortestDistance = indexPath.row == 0 ? YES : NO;
    cell.station = _service.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark 

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
