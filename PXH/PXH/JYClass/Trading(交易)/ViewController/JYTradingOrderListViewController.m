//
//  JYTradingOrderListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/27.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingOrderListViewController.h"

//
#import "YSProductDetailViewController.h"
#import "JYTradingNowOrderCell.h"
#import "YSPagingListService.h"
#import "YSProductService.h"
//

#import "JYTradingService.h"
#import "JYTradingOldDealCell.h"
#import "JYTradingOldEntrustCell.h"

#import "JYEmptyView.h"




@interface JYTradingOrderListViewController ()

@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic, strong) UIView   *headView;
@property (nonatomic, strong) UILabel   *leftLabel;
@property (nonatomic, strong) UILabel   *centerLabel;
@property (nonatomic, strong) UILabel   *rightLabel;
@property (nonatomic,strong)JYEmptyView *emptyView;

@end

@implementation JYTradingOrderListViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    
    if ([JYAccountModel sharedAccount].token.length == 0) {
        
        self.emptyView.showString = @"";
        self.emptyView.loginBtn.hidden = NO;
        self.emptyView.iconImageView.hidden = YES;
        [self.view addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];
        self.emptyView.hidden = NO;
        self.tableView.hidden = YES;
        self.headView.hidden = YES;
    }else{
        
        
        if (self.index.integerValue == 2) {
            
            _service = [[YSPagingListService alloc] initWithTargetClass:[JYTradingService class] action:@selector(MatchTrademyListWithBuyCoinID:page:completion:)];
            
        }else if(self.index.integerValue == 3){
            _service = [[YSPagingListService alloc] initWithTargetClass:[JYTradingService class] action:@selector(matchTradeMyHistoryList:page:completion:)];
            
        }else if (self.index.integerValue == 4){
            _service = [[YSPagingListService alloc] initWithTargetClass:[JYTradingService class] action:@selector(matchTradeMyAllHistoryList:page:completion:)];
        }

        self.emptyView.showString = @"暂无数据";
        self.emptyView.loginBtn.hidden = YES;
        self.emptyView.iconImageView.hidden = NO;
        [self fetchProductList:NO];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData:) name:@"TradingOrderListRefreshData" object:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    

    
    if (self.index.integerValue == 2) {
        
        self.leftLabel.text = @"委价/均价";
        self.centerLabel.text = @"委量/成交";
        self.rightLabel.text = @"操作";
        
        
        
    }else if(self.index.integerValue == 3){
        
        self.leftLabel.text = @"成交均价";
        self.centerLabel.text = @"成交数量";
        self.rightLabel.text = @"成交额/手续费";
        
        
    }else if (self.index.integerValue == 4){
        
        self.leftLabel.text = @"委价/均价";
        self.centerLabel.text = @"委量/成交";
        self.rightLabel.text = @"成交额";
        
    }
    

}

- (void)refreshData:(NSNotification *)noti{
    
    [self fetchProductList:NO];
    
}

- (void)setupTableView {
    
    
    
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.view addSubview:self.headView];
    [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    self.headView.hidden = YES;
    
    [self.headView addSubview:self.leftLabel];
    [self.headView addSubview:self.centerLabel];
    [self.headView addSubview:self.rightLabel];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).offset(20);
        make.centerY.equalTo(self.headView);
        make.height.equalTo(self.headView);
    }];
    
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headView);
        make.centerY.equalTo(self.headView);
        make.height.equalTo(self.headView);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView).offset(-20);
        make.centerY.equalTo(self.headView);
        make.height.equalTo(self.headView);
    }];
    
    
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tableView.estimatedRowHeight = 110.f;
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.tableView registerClass:[JYTradingNowOrderCell class] forCellReuseIdentifier:@"JYTradingNowOrderCell"];
    [self.tableView registerClass:[JYTradingOldDealCell class] forCellReuseIdentifier:@"JYTradingOldDealCell"];
    [self.tableView registerClass:[JYTradingOldEntrustCell class] forCellReuseIdentifier:@"JYTradingOldEntrustCell"];
    
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
    
    
     NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.index.integerValue == 2) {
        
       
        param[@"coinType"] = [JYDefaultDataModel sharedDefaultData].coinBaseID;
        param[@"tradeCoin"] = [JYDefaultDataModel sharedDefaultData].coinPayID;
        
        
    }else if(self.index.integerValue == 3){
        
        
        param[@"coinType"] = [JYDefaultDataModel sharedDefaultData].coinBaseID;
        param[@"tradeCoin"] =  [JYDefaultDataModel sharedDefaultData].coinPayID;
        param[@"isDeal"] = @"1";
        
        
    }else if (self.index.integerValue == 4){
        
        param[@"coinType"] = [JYDefaultDataModel sharedDefaultData].coinBaseID;
        param[@"tradeCoin"] =  [JYDefaultDataModel sharedDefaultData].coinPayID;
    }

    [_service loadDataWithParameters:param isLoadMore:loadMore completion:^(id result, id error) {
        
        if (_service.dataSource.count == 0) {
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view);
                make.left.right.bottom.equalTo(self.view);
            }];
            [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.view);
                make.height.mas_equalTo(0);
            }];
            self.headView.hidden = YES;
            self.emptyView.hidden = NO;
            [self.view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.tableView);
            }];
        }else{
            
            self.headView.hidden = NO;
            self.emptyView.hidden = YES;
            self.tableView.hidden = NO;
            
            [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.view);
                make.height.mas_equalTo(30);
            }];
            [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headView.mas_bottom);
                make.left.right.bottom.equalTo(self.view);
            }];
            
        }
        
        
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _service.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.index.integerValue == 2) {
        
        JYTradingNowOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYTradingNowOrderCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    cell.product = _service.dataSource[indexPath.row];
        
        JYTradingOrderModel *model;
        if (_service.dataSource.count) {
            model = _service.dataSource[indexPath.section];
            cell.model = model;
        }
        
        cell.MatchCancel = ^{
            
            [JYTradingService matchTradeCancelWithMatchId:model.ID completion:^(id result, id error) {
                [MBProgressHUD showText:@"撤销订单成功" toContainer:self.view];
                [self fetchProductList:NO];
            }];
            
        };
        return cell;
    }else if(self.index.integerValue == 3){
        
        JYTradingOldDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYTradingOldDealCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JYTradingOrderModel *model;
        if (_service.dataSource.count) {
            model = _service.dataSource[indexPath.section];
            cell.model = model;
        }
        return cell;
    }else {
        
        JYTradingOldEntrustCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYTradingOldEntrustCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JYTradingOrderModel *model;
        if (_service.dataSource.count) {
            model = _service.dataSource[indexPath.section];
            cell.model = model;
        }
        return cell;
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [UIView new];
        _headView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    }
    return _headView;
}

- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont systemFontOfSize:13];
        _leftLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _leftLabel;
}

- (UILabel *)centerLabel
{
    if (!_centerLabel) {
        _centerLabel = [UILabel new];
        _centerLabel.font = [UIFont systemFontOfSize:13];
        _centerLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _centerLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _rightLabel;
}

- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
    }
    return _emptyView;
}


@end
