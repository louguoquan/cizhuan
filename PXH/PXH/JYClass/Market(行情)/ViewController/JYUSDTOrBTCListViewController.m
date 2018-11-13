
//  JYUSDTOrBTCListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYUSDTOrBTCListViewController.h"
#import "LrdOutputView.h"

//
#import "YSProductDetailViewController.h"
#import "JYMarketBaseCell.h"
#import "YSPagingListService.h"
#import "YSProductService.h"
//

#import "JYEmptyView.h"

#import "JYMarketService.h"




@interface JYUSDTOrBTCListViewController ()


@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic, strong) NSString   *sort;
@property (nonatomic, strong) NSString   *sortType;

@property (nonatomic,strong)JYEmptyView *emptyView;

@property (nonatomic,strong) NSTimer *timer;



@end

@implementation JYUSDTOrBTCListViewController


- (void)viewWillAppear:(BOOL)animated
{
    if (self.index.integerValue == 0) {
        
        
        if ([JYAccountModel sharedAccount].token.length==0) {
            
            self.emptyView.showString = @"";
            self.emptyView.loginBtn.hidden = NO;
            self.emptyView.iconImageView.hidden = YES;
            [self.view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.tableView);
            }];
            self.emptyView.hidden = NO;
            self.tableView.hidden = YES;
            //关闭定时器
            if (self.timer) {
                //开启定时器
                [self.timer setFireDate:[NSDate distantFuture]];
            }
            
            
        }else{
            //自选
            [self fetchProductList:NO];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryBuyOrSellList) userInfo:nil repeats:YES];
            
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
            
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData:) name:@"editChangeRefreshData" object:nil];
            if (self.timer) {
                //开启定时器
                [self.timer setFireDate:[NSDate distantPast]];
            }
        }
    }else if(self.index.integerValue == 1){
        //USDT
        [self fetchProductList:NO];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryBuyOrSellList) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
        if (self.timer) {
            //开启定时器
            [self.timer setFireDate:[NSDate distantPast]];
        }
        
    }else if (self.index.integerValue == 2){
        //BTC
        [self fetchProductList:NO];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryBuyOrSellList) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
        if (self.timer) {
            //开启定时器
            [self.timer setFireDate:[NSDate distantPast]];
        }
        
    }
    
    


    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    [self setupTableView];
    
    
    //首页筛选模型传送
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectStatusChange:) name:@"SelectStatusChange" object:nil];
    
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopTimer:) name:@"StopTimer1" object:nil];

    
    
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    if (self.timer) {
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        
    }
    
}

- (void)stopTimer:(NSNotification *)noti{
    
    if (self.timer) {
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        
    }
}

- (void)queryBuyOrSellList{
    
    [self fetchProductList:NO];
}



- (void)refreshData:(NSNotification *)noti{
    
    
    [self fetchProductList:NO];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SelectStatusChange" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"editChangeRefreshData" object:nil];
    
    
    if (self.timer) {
        // 停止定时器
        [self.timer invalidate];
        self.timer = nil;
    }
    
}


- (void)SelectStatusChange:(NSNotification *)noti{
    
    NSLog(@"%@",noti.userInfo);
    LrdCellModel *model = noti.userInfo[@"model"];
    
    //根据筛选条件
    if ([model.title isEqualToString:@"按价格排序"]) {
        self.sort  = @"price";
    }else if ([model.title isEqualToString:@"按成交量排序"]){
        self.sort  = @"total_sales";
    }else if ([model.title isEqualToString:@"按涨幅排序"]){
        self.sort  = @"last_gains";
    }
    
    
    if ([model.imageName isEqualToString:@"arror_nomal"]) {
        self.sort  = @"";
    }else if ([model.imageName isEqualToString:@"arror_green"]){
        self.sortType  = @"ASC";
    }else if ([model.imageName isEqualToString:@"arror_red"]){
        self.sortType  = @"DESC";
    }
    
    if ([model.index isEqualToString:self.index]) {
        [self fetchProductList:NO];
    }
    
}



- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[JYMarketService class] action:@selector(fetchCoinList:page:completion:)];
    
    self.tableView.estimatedRowHeight = 110.f;
    
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.tableView registerClass:[JYMarketBaseCell class] forCellReuseIdentifier:@"JYMarketBaseCell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductList:NO];
    }];
    
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        [weakSelf fetchProductList:YES];
    //    }];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)fetchProductList:(BOOL)loadMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.sort.length>0) {
        
        param[@"sort"] = self.sort;
        param[@"sortType"] = self.sortType;
    }
    
    if (self.index.integerValue == 0) {
        //自选模式
        param[@"currencyType"] = @"2";
        param[@"token"] = [NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token];
    }else if(self.index.integerValue == 1){
        //USDT
        param[@"currencyType"] = @"0";
    }else if (self.index.integerValue == 2){
        //BTC
        param[@"currencyType"] = @"1";
    }
    
    
    [_service loadDataWithParameters:param isLoadMore:loadMore completion:^(id result, id error) {
        
        
     
        
        if (_service.dataSource.count == 0) {
            self.tableView.hidden = YES;
            self.emptyView.showString = @"暂无数据";
            self.emptyView.loginBtn.hidden = YES;
            self.emptyView.iconImageView.hidden = NO;
            [self.view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.tableView);
            }];
        }else{
            self.emptyView.hidden = YES;
            self.tableView.hidden = NO;
            
            
            if (self.index.integerValue == 1) {
                if ([JYDefaultDataModel sharedDefaultData].coinBaseName.length==0) {
                    JYMarketModel *model1 = [_service.dataSource firstObject];
                    JYDefaultDataModel *model = [[JYDefaultDataModel alloc]init];
                    model.coinBaseID = model1.ID;
                    model.coinBaseName = model1.code;
                    model.coinPayName = model1.type.integerValue == 0? @"USDT":@"BTC";
                    model.coinPayID = model1.type.integerValue == 0? @"0":@"1";
                    model.status = model1.status;
                    model.isHomeCome = @"NO";
                    model.tradeStatus = model1.tradeStatus;
                    [JYDefaultDataModel saveDefaultData:model];
                }
            }
            
            
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
    
    
    
    
    JYMarketBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYMarketBaseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    JYMarketModel *model;
    
    if (_service.dataSource.count) {
        model =  _service.dataSource[indexPath.section];
        if (self.index.integerValue == 0) {
            //自选cell类型
            cell.type = @"2";
            
        }else{
            //手动添加交易对类型
            if (self.index.integerValue == 1) {
                //USDT
                model.type = @"0";
            }else{
                //BTC
                model.type = @"1";
            }
            //非自选cell类型
            cell.type = @"1";
        }
        cell.product = model;
    }
    
    
    return cell;
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
    
    
    
    if ( [[JYDefaultDataModel sharedDefaultData].isHomeCome isEqualToString:@"YES"]) {
        
        
        JYMarketModel *model1 = _service.dataSource[indexPath.section];
        JYDefaultDataModel *model = [[JYDefaultDataModel alloc]init];;
        
        if (self.index.integerValue == 0) {
            //自选cell类型
            model.coinBaseID = model1.coinId;
        }else{
            //手动添加交易对类型
            model.coinBaseID = model1.ID;
        }
        
        model.coinBaseName = model1.code;
        model.coinPayName = model1.type.integerValue == 0? @"USDT":@"BTC";
        model.coinPayID = model1.type.integerValue == 0? @"0":@"1";
        model.status = model1.status;
        model.isHomeCome = @"NO";
        model.tradeStatus = model1.tradeStatus;
        [JYDefaultDataModel saveDefaultData:model];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postHomeData" object:self userInfo:@{@"model":model}];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TradingOrderListRefreshData" object:self userInfo:@{}];
        
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
    
    self.tabBarController.selectedIndex=1;
    
    JYMarketModel *model1 = _service.dataSource[indexPath.section];
    JYDefaultDataModel *model = [[JYDefaultDataModel alloc]init];;
    
    if (self.index.integerValue == 0) {
        //自选cell类型
        model.coinBaseID = model1.coinId;
    }else{
        //手动添加交易对类型
        model.coinBaseID = model1.ID;
    }
    
    model.coinBaseName = model1.code;
    model.coinPayName = model1.type.integerValue == 0? @"USDT":@"BTC";
    model.coinPayID = model1.type.integerValue == 0? @"0":@"1";
    model.status = model1.status;
    model.isHomeCome = @"NO";
    model.tradeStatus = model1.tradeStatus;
    [JYDefaultDataModel saveDefaultData:model];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postHomeData" object:self userInfo:@{@"model":model}];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TradingOrderListRefreshData" object:self userInfo:@{}];
        
    }
}

- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
    }
    return _emptyView;
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
