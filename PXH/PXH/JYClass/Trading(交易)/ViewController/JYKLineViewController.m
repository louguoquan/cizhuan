//
//  JYKLineViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYKLineViewController.h"
#import "Masonry.h"
#import "Y_StockChartView.h"
#import "Y_StockChartView.h"
#import "NetWorking.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"
#import "AppDelegate.h"

#import "JYKLineHeaderView.h"
#import "JYTradingService.h"




@interface JYKLineViewController ()<Y_StockChartViewDataSource>


@property (nonatomic, strong) Y_StockChartView *stockChartView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

@property (nonatomic, strong) JYKlineHeaderModel *kLineHeadModel;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;


@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL isZhibiao;

@property (nonatomic,strong)UILabel *navigationLabel;

@property (nonatomic,strong)JYKLineHeaderView *headerView;


@property (nonatomic,strong)UIButton *buyBtn;

@property (nonatomic,strong)UIButton *saleBtn;

@property (nonatomic,strong) NSTimer *timer;



@end

@implementation JYKLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _navigationLabel;
    _navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    _navigationLabel.text = [NSString stringWithFormat:@"%@/%@",[JYDefaultDataModel sharedDefaultData].coinBaseName,[JYDefaultDataModel sharedDefaultData].coinPayName];
    
    self.isZhibiao = NO;
    
    self.currentIndex = -1;
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
    
    
    self.headerView = [[JYKLineHeaderView alloc]init];
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    [self.view addSubview:self.buyBtn];
    [self.view addSubview:self.saleBtn];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-12);
        make.left.equalTo(self.view).offset(9);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo((kScreenWidth-30)/2.0);
    }];
    
    [self.saleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-12);
        make.right.equalTo(self.view).offset(-9);
        make.height.mas_equalTo(33);
        make.width.mas_equalTo((kScreenWidth-30)/2.0);
    }];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
//    
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhibiaoClick) name:@"zhibiaoClick" object:nil];
    
    
}

- (void)zhibiaoClick{
    
    
    self.isZhibiao = YES;
    [self reloadData];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
    
    
}

- (void)dealloc{
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


- (UIButton *)buyBtn{
    
    if (!_buyBtn) {
        _buyBtn = [UIButton new];
        _buyBtn.layer.cornerRadius = 3.0f;
        _buyBtn.layer.masksToBounds = YES;
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_buyBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
        _buyBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
        [_buyBtn setTitle:@"买入" forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(backTobuy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
    
}

- (UIButton *)saleBtn{
    
    if (!_saleBtn) {
        _saleBtn = [UIButton new];
        _saleBtn.layer.cornerRadius = 3.0f;
        _saleBtn.layer.masksToBounds = YES;
        _saleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_saleBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
        _saleBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        [_saleBtn setTitle:@"卖出" forState:UIControlStateNormal];
        [_saleBtn addTarget:self action:@selector(backToSale) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saleBtn;
}


- (void)backTobuy{
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backToBuyOrSale" object:nil userInfo:@{@"status":@"buy"}];
    
}


- (void)backToSale{
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backToBuyOrSale" object:nil userInfo:@{@"status":@"sale"}];
    
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}


-(id) stockDatasWithIndex:(NSInteger)index
{
    
    
    NSString *type;
    switch (index) {
        case 0:
        {
            //1min
            type = @"0";
            self.isZhibiao  = YES;
        }
            break;
        case 1:
        {
            //1min
            type = @"0";
            self.isZhibiao = NO;
        }
            break;
        case 2:
        {
            //1min
            type = @"0";
            self.isZhibiao = NO;
        }
            break;
        case 3:
        {
            //5min
            type = @"2";
            self.isZhibiao = NO;
        }
            break;
        case 4:
        {
            //15min
            type = @"3";
            self.isZhibiao = NO;
        }
            break;
        case 5:
        {
            //30min
            type = @"4";
            self.isZhibiao = NO;
        }
            break;
        case 6:
        {
            //1hour
            type = @"5";
            self.isZhibiao = NO;
        }
            break;
        case 7:
        {
            //1day
            type = @"10";
            self.isZhibiao = NO;
        }
            break;
        case 8:
        {
            //1week
            type = @"12";
            self.isZhibiao = NO;
        }
            break;
            
        default:
            break;
    }
    
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self reloadData];
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)reloadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = self.type;
    param[@"market"] = @"btc_usdt";
    param[@"size"] = @"1000";
    
    //        [JYTradingService matchTradeKLineInfoWithType:@"0" coinType:@"1" tradeCoinId:@"0" completion:^(id result, id error) {
    
    [JYTradingService matchTradeKLineInfoWithType:self.type coinType:[JYDefaultDataModel sharedDefaultData].coinBaseID tradeCoinId:[JYDefaultDataModel sharedDefaultData].coinPayID completion:^(id result, id error) {
        
        NSArray *array = result[@"result"];
        if (array.count>0 && [array isKindOfClass:[NSArray class]]) {
            [self.modelsDict removeAllObjects];
            Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:result[@"result"]];
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.type];
            //            NSLog(@"%@",groupModel);
            NSLog(@"self.modelsDict  = %ld",self.modelsDict.allValues.count);
            
            
            if (!self.isZhibiao) {
                [self.stockChartView reloadData];
            }
        }
        
    }];
    
    [JYTradingService matchklineHeadCoinType:[JYDefaultDataModel sharedDefaultData].coinBaseID tradeCoinId:[JYDefaultDataModel sharedDefaultData].coinPayID completion:^(id result, id error) {
        
        self.kLineHeadModel = result;
        self.headerView.model  = self.kLineHeadModel;
        
    }];
    
    
    
    
    
    
    
    //        [NetWorking requestWithApi:@"http://api.bitkk.com/data/v1/kline" param:param thenSuccess:^(NSDictionary *responseObject) {
    //
    //            NSArray *array = responseObject[@"data"];
    //            if (array.count>0) {
    //                [self.modelsDict removeAllObjects];
    //                Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
    //                self.groupModel = groupModel;
    //                [self.modelsDict setObject:groupModel forKey:self.type];
    //                //            NSLog(@"%@",groupModel);
    //                NSLog(@"self.modelsDict  = %ld",self.modelsDict.allValues.count);
    //                [self.stockChartView reloadData];
    //            }
    //        } fail:^{
    //
    //        }];
}
- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"15分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"60分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周线" type:Y_StockChartcenterViewTypeKline],
                                       
                                       ];
        _stockChartView.backgroundColor = [UIColor orangeColor];
        _stockChartView.dataSource = self;
        [self.view addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_X) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            } else {
                make.edges.equalTo(self.view);
            }
        }];
        
    }
    return _stockChartView;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotate
{
    return NO;
}


@end
