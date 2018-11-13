//
//  JYDisRecordController.m
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYRecordController.h"

#import "JYExchangeCell.h"
#import "JYRechargeCell.h"
#import "JYC2CRecordListCell.h"

#import "JYEmptyView.h"

#import "JYAssetsService.h"

@interface JYRecordController ()
{
    NSInteger       page;
}

@property (nonatomic, strong) JYEmptyView   *emptyView;

@property (nonatomic, strong) NSArray       *recordArr;

@end

static NSString *const JYExchangeCellID = @"JYExchangeCell_ID";
static NSString *const JYRechargeCellID = @"JYRechargeCell_ID";
static NSString *const JYC2CRecordListCellID = @"JYC2CRecordListCell_ID";

@implementation JYRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpTableView];
    
    page = 1;
    [self fetchProductList:NO];
}

- (void)setUpNav
{
    NSString *navTitle = (self.type == RecordType_coin) ? @"提币记录":@"充币记录";
    navTitle = (self.type == RecordType_Withdraw) ? @"充值提现记录":navTitle;
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = navTitle;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpTableView {
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 90.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.type == RecordType_coin) {
        [self.tableView registerClass:[JYExchangeCell class] forCellReuseIdentifier:JYExchangeCellID];
    }
    else if (self.type == RecordType_Recharge) {
        [self.tableView registerClass:[JYRechargeCell class] forCellReuseIdentifier:JYRechargeCellID];
    }
    else {
        [self.tableView registerClass:[JYC2CRecordListCell class] forCellReuseIdentifier:JYC2CRecordListCellID];
    }
    
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_header beginRefreshing];
        [weakSelf fetchProductList:NO];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self.tableView.mj_footer beginRefreshing];
        [weakSelf fetchProductList:YES];
    }];
}

-(void)back
{
    if (self.type==RecordType_coin && self.isPopRootVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:JYRecordVCPopRootVC object:self];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)fetchProductList:(BOOL)loadMore {
    WS(weakSelf)
    if (self.type == RecordType_Recharge) {//充币
        [JYAssetsService currencyRecordWithCoinId:self.coinId page:page completion:^(id result, id error) {
            [weakSelf reloadwithData:(NSArray *)result loadMore:loadMore];
        }];
    }
    else if(self.type == RecordType_coin) {//提币
        [JYAssetsService coinExchangeRecordWithCoinId:self.coinId page:page completion:^(id result, id error) {
            [weakSelf reloadwithData:(NSArray *)result loadMore:loadMore];
        }];
    }
    else {//充值提现记录
        [JYAssetsService withdrawRecordWithPage:page completion:^(id result, id error) {
            [weakSelf reloadwithData:(NSArray *)result loadMore:loadMore];
        }];
    }
}

- (void)reloadwithData:(NSArray *)array loadMore:(BOOL)loadMore
{
    if (loadMore) {
        if (!array.count) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.recordArr];
        [muArr addObjectsFromArray:array];
        self.recordArr = [muArr mutableCopy];
    }else{
        self.recordArr = [array mutableCopy];
    }
    
    self.emptyView.hidden = (self.recordArr.count)?YES:NO;
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self.tableView reloadData];
}


#pragma mark - < UITableViewDelegate >

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.recordArr.count;;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (self.type == RecordType_coin) {
        JYExchangeCell *earningCell = [tableView dequeueReusableCellWithIdentifier:JYExchangeCellID];
        JYExchangeModel *model = (JYExchangeModel *)self.recordArr[indexPath.row];
        model.coinCode = self.coinCode;
        earningCell.model = model;
        cell = earningCell;
    }
    else if (self.type == RecordType_Recharge) {
        JYRechargeCell *rechargeCell = [tableView dequeueReusableCellWithIdentifier:JYRechargeCellID];
        JYRechargeModel *model = (JYRechargeModel *)self.recordArr[indexPath.row];
        model.coinCode = self.coinCode;
        rechargeCell.model = model;
        cell = rechargeCell;
    }
    else {
        JYC2CRecordListCell *withdrawCell = [tableView dequeueReusableCellWithIdentifier:JYC2CRecordListCellID];
        JYC2CRecordListModel *model = (JYC2CRecordListModel *)self.recordArr[indexPath.row];
        withdrawCell.model = model;
        cell = withdrawCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}


-(void)setType:(RecordType)type
{
    _type = type;
}

-(void)setCoinId:(NSString *)coinId
{
    _coinId = coinId;
}

-(void)setCoinCode:(NSString *)coinCode
{
    _coinCode = coinCode;
}

-(void)setIsPopRootVC:(BOOL)isPopRootVC
{
    _isPopRootVC = isPopRootVC;
}

- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
        [self.view addSubview:self.emptyView];
        
        [_emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];
    }
    [self.tableView insertSubview:_emptyView atIndex:1];
    
    return _emptyView;
}

@end
