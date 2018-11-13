//
//  JYBuyOrSaleViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBuyOrSaleViewController.h"
#import "JYBuyOrSaleView.h"
#import "JYTradingBaseCell.h"
#import "JYBusinessDetailView.h"
#import "JYTradingService.h"
//#import "DRNRealTimeBlurView.h"


@interface JYBuyOrSaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)JYBuyOrSaleView *leftView;

@property (nonatomic,strong)UITableView *topTable;
@property (nonatomic,strong)UITableView *bottomTable;

@property (nonatomic,strong)UILabel *coinNowPriceLabel;     //币的当前价
@property (nonatomic,strong)UILabel *coinForCNYPriceLabel;  //币的人民币价格
@property (nonatomic,strong)UILabel *fallOrDegreesLabel;    //币的当前跌涨幅

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign)NSInteger businessPage;
@property (nonatomic,strong)UIImageView *bottomImageView;
@property (nonatomic,strong)JYBusinessDetailView *businessDetailView;

@property (nonatomic,strong)JYDefaultDataModel *model;

@property (nonatomic,strong)JYTradingModel *matchModel;

@property (nonatomic,strong)NSMutableArray *businessDataArray;


@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSTimer *timerDetail;
@property (nonatomic,strong) JYTradingBaseModel *baseModel;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *count;
@property (nonatomic,assign) BOOL isTopTableScrollBottom;
@property (nonatomic,strong) UIBlurEffect *blur;
@property (nonatomic,strong) UIVisualEffectView *effectview;


@property (nonatomic, strong) UILabel *messageLabel;


@end

@implementation JYBuyOrSaleViewController


- (UILabel *)messageLabel{
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    self.bottomView.tag = 100;
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(37);
    }];
    _bottomImageView.image = [UIImage imageNamed:@"upDoubleArrows"];
    
    
    if (_index.integerValue == 0) {
        
        _leftView.type = 1;
        
    }else if(_index.integerValue == 1){
        
        _leftView.type = 2;
        
    }
    
    self.count = @"";
    self.price = @"";
    
    self.businessPage = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([JYDefaultDataModel sharedDefaultData].tradeStatus.integerValue == 0) {
            
            if (self.timerDetail) {
                
                //关闭定时器
                [self.timerDetail setFireDate:[NSDate distantFuture]];
            }
            
            if (self.timer) {
                //关闭定时器
                [self.timer setFireDate:[NSDate distantFuture]];
            }
            
            
            
            
            if (_index.integerValue == 0) {
                
         
                
                if ([JYAccountModel sharedAccount].token.length != 0) {
                    _leftView.buyOrSaleBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnGrey);
                }
                
                [_leftView.buyOrSaleBtn setTitle:[JYAccountModel sharedAccount].token.length==0 ? @"登录":([JYDefaultDataModel sharedDefaultData].tradeStatus.integerValue == 0?@"暂停交易":@"买入") forState:UIControlStateNormal];
                
            }else if(_index.integerValue == 1){
                
                
                if ([JYAccountModel sharedAccount].token.length != 0) {
                    _leftView.buyOrSaleBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnGrey);
                }

                [_leftView.buyOrSaleBtn setTitle:[JYAccountModel sharedAccount].token.length==0 ? @"登录":([JYDefaultDataModel sharedDefaultData].tradeStatus.integerValue == 0?@"暂停交易":@"卖出") forState:UIControlStateNormal];
            }
            
            
            
//            if (!self.blur) {
//                self.blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//                self.effectview = [[UIVisualEffectView alloc] initWithEffect:self.blur];
//                self.effectview.frame = CGRectMake(0, 0, kScreenWidth/2.0, kScreenHeight);
//                self.effectview.alpha = 1.0;
//                [self.leftView addSubview:self.effectview];
//
//            }
//
//            self.messageLabel.hidden = NO;
//            [self.leftView addSubview:self.messageLabel];
//            [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self.leftView);
//                make.centerY.equalTo(self.leftView).offset(-50);
//                make.width.mas_equalTo(kScreenWidth/4.0);
//                make.height.greaterThanOrEqualTo(@20);
//            }];
//            self.messageLabel.text =[NSString stringWithFormat:@"暂停%@/%@交易",[JYDefaultDataModel sharedDefaultData].coinBaseName,[JYDefaultDataModel sharedDefaultData].coinPayName];
            
            if ([JYAccountModel sharedAccount].token.length == 0) {
                [self matchGuaDanInfoNoTokenWithcoinType:@"" tradeCoinNum:@""];
            }else{
                [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:@""];
            }
            
            [self queryBuyOrSellList];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.isTopTableScrollBottom) {
                    [self.topTable setContentOffset:CGPointMake(0,0) animated:NO];
                    [self.bottomTable setContentOffset:CGPointMake(0,0) animated:NO];
                    self.isTopTableScrollBottom = NO;
                }
                
                
            });
            
            
            
        }else{
            
//            self.messageLabel.hidden = YES;
//            [self.effectview removeFromSuperview];
//            self.blur = nil;
            
            if ([JYAccountModel sharedAccount].token.length == 0) {
                [self matchGuaDanInfoNoTokenWithcoinType:@"" tradeCoinNum:@""];
            }else{
                [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:@""];
            }
            
            [self queryBuyOrSellList];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.isTopTableScrollBottom) {
                    [self.topTable setContentOffset:CGPointMake(0,0) animated:NO];
                    [self.bottomTable setContentOffset:CGPointMake(0,0) animated:NO];
                    self.isTopTableScrollBottom = NO;
                }
                
                
            });
            
            
            if (self.timerDetail) {
                
                //开启定时器
                [self.timerDetail setFireDate:[NSDate distantPast]];
            }
            
            if (self.timer) {
                //开启定时器
                [self.timer setFireDate:[NSDate distantPast]];
            }
            
            
        }
        
    });
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.price = @"";
    self.count = @"";
    
    
    
    
    
    //    if (!self.model) {
    self.model = [JYDefaultDataModel sharedDefaultData];
    //    }
    
    _leftView = [[JYBuyOrSaleView alloc]init];
    
    if (_index.integerValue == 0) {
        
        _leftView.type = 1;
        
    }else if(_index.integerValue == 1){
        
        _leftView.type = 2;
        
    }
    
    self.isTopTableScrollBottom = YES;
    
    [self.scrollView addSubview:_leftView];
    [self.scrollView addSubview:self.topTable];
    [self.scrollView addSubview:self.bottomTable];
    [self.view addSubview:self.businessDetailView];
    
    
    self.topTable.showsVerticalScrollIndicator = NO;
    self.bottomTable.showsVerticalScrollIndicator = NO;
    CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI);
    [self.topTable setTransform:transform];
    
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.bottomImageView];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.bottom.equalTo(self.scrollView).offset(-25);
    }];
    
    
    [self.topTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView).offset(8);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.height.mas_equalTo(200.0*kScreenHeight/667);
    }];
    
    
    
    UIView *centerView = [[UIView alloc]init];
    centerView.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGHalfBTNBG);
    centerView.layer.cornerRadius = 3.0f;
    centerView.layer.masksToBounds = YES;
    
    [self.scrollView addSubview:centerView];
    [centerView addSubview:self.coinNowPriceLabel];
    [centerView addSubview:self.coinForCNYPriceLabel];
    [centerView addSubview:self.fallOrDegreesLabel];
    
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topTable.mas_bottom).offset(5);
        make.right.equalTo(self.scrollView).offset(-8);
        make.width.mas_equalTo(kScreenWidth/2.0-16);
        make.height.mas_equalTo(43);
    }];
    
    
    [self.coinNowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerView).offset(10);
        make.top.equalTo(centerView).offset(9);
        make.height.mas_equalTo(12);
    }];
    
    
    [self.coinForCNYPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coinNowPriceLabel.mas_bottom).offset(7);
        make.left.equalTo(centerView).offset(10);
        make.height.mas_equalTo(10);
    }];
    
    
    [self.fallOrDegreesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerView).offset(-10);
        make.top.equalTo(centerView).offset(9);
        make.height.mas_equalTo(12);
    }];
    
    [self.bottomTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_bottom).offset(5);
        make.right.equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth/2.0);
        make.height.equalTo(self.topTable.mas_height);
        //        make.bottom.equalTo(self.scrollView).offset(-37);
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(37);
    }];
    
    
    [self.businessDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom);
        make.left.equalTo(self.bottomView);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.equalTo(self.view);
    }];
    
    UILabel *label7 = [[UILabel alloc]init];
    label7.text = @"交易明细";
    label7.font = [UIFont systemFontOfSize:15];
    label7.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [self.bottomView addSubview:label7];
    
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(-9);
        make.height.mas_equalTo(16);
    }];
    
    
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(label7.mas_right).offset(9);
        make.height.width.mas_equalTo(14);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-11.5);
    }];
    
    self.coinNowPriceLabel.text = @"0.087498";
    self.coinForCNYPriceLabel.text = @"≈￥4883.30";
    self.fallOrDegreesLabel.text = @"+0.57%";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.tag = 100;
    [self.bottomView addGestureRecognizer:tap];
    
    
    WS(weakSelf);
    _leftView.BuyOrSaleCountHalf = ^(NSInteger index) {
        
        [weakSelf.view endEditing:YES];
        
        CGFloat point = 0.0f;
        
        if (index == 0) {
            
            point = 0.25;
            //25%
            if (weakSelf.baseModel) {
                
                
                
                
                NSDecimalNumber* n1;
                
                
                if (self.index.integerValue == 0) {
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.kemai.doubleValue]];
                }else  if (self.index.integerValue == 1){
                    
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.keyongchiyou.doubleValue]];
                }
                
                
                NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",point]];
                
                NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
                
                
                weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%.3lf", floor(([n3 doubleValue])*1000)/1000];
                
                
            }
            
            
        }else if (index == 1){
            //50%
            point = 0.5;
            if (weakSelf.baseModel) {
                NSDecimalNumber* n1;
                
                
                if (self.index.integerValue == 0) {
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.kemai.doubleValue]];
                }else  if (self.index.integerValue == 1){
                    
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.keyongchiyou.doubleValue]];
                }
                
                NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",point]];
                
                NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
                
                weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%.3lf", floor(([n3 doubleValue])*1000)/1000];
            }
            
        }else if (index == 2){
            //75%
            point = 0.75;
            if (weakSelf.baseModel) {
                NSDecimalNumber* n1;
                
                
                if (self.index.integerValue == 0) {
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.kemai.doubleValue]];
                }else  if (self.index.integerValue == 1){
                    
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.keyongchiyou.doubleValue]];
                }
                
                
                NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",point]];
                
                NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
                
                weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%.3lf", floor(([n3 doubleValue])*1000)/1000];
            }
            
        }else if (index == 3){
            //100%
            
            point = 1.0;
            
            if (weakSelf.baseModel) {
                NSDecimalNumber* n1;
                
                
                if (self.index.integerValue == 0) {
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.kemai.doubleValue]];
                    
                    
//                    weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%@",weakSelf.baseModel.kemai];
                    
                    weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%.3lf", floor(([weakSelf.baseModel.kemai doubleValue])*1000)/1000];
                    
                    
                    
                }else  if (self.index.integerValue == 1){
                    
                    n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",weakSelf.baseModel.keyongchiyou.doubleValue]];
                    NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",point]];
                    
                    NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
                    
                    weakSelf.leftView.countTF.text = [NSString stringWithFormat:@"%.3lf", floor(([n3 doubleValue])*1000)/1000];
                    
                }
                
                
            }
            
        }
        
        
        NSDecimalNumber* n4;
        
        if (self.index.integerValue == 0) {
            
            NSDecimalNumber* n1 = [NSDecimalNumber   decimalNumberWithString:[NSString    stringWithFormat:@"%@",weakSelf.baseModel.keyongjiaoyi]];
            NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",point]];
            n4 = [n1 decimalNumberByMultiplyingBy:n2];
            weakSelf.leftView.payAccountLabel.text = [NSString stringWithFormat:@"%@%@",n4,[JYDefaultDataModel sharedDefaultData].coinPayName];
            
            
        }else{
            
            
            NSDecimalNumber* n1 = [NSDecimalNumber   decimalNumberWithString:[NSString    stringWithFormat:@"%@",weakSelf.leftView.priceTF.text]];
            NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",weakSelf.leftView.countTF.text]];
            n4 = [n1 decimalNumberByMultiplyingBy:n2];
            weakSelf.leftView.payAccountLabel.text = [NSString stringWithFormat:@"%@%@",n4,[JYDefaultDataModel sharedDefaultData].coinPayName];
            
        }
        
        
        
        NSDecimalNumber* n5 = [NSDecimalNumber   decimalNumberWithString:[NSString    stringWithFormat:@"%@",n4]];
        NSDecimalNumber* n6 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"0.002"]];
        NSDecimalNumber* n7 = [n5 decimalNumberByMultiplyingBy:n6];
        weakSelf.leftView.poundageLabel.text = [NSString stringWithFormat:@"%@%@",n7,[JYDefaultDataModel sharedDefaultData].coinPayName];
        
        //        [weakSelf.leftView.payAccountLabel sizeToFit];
        
        
    };
    
    _leftView.BuyOrSale = ^(BOOL isBuy) {
        
        [weakSelf.view endEditing:YES];
        
        if ([JYDefaultDataModel sharedDefaultData].tradeStatus.integerValue == 0) {
            
            [MBProgressHUD showText:@"暂停交易" toContainer:weakSelf.view];
            return ;
            
        }else{
            
            
            if (weakSelf.leftView.priceTF.text.length == 0) {
                [MBProgressHUD showText:@"请输入委托价格!" toContainer:weakSelf.view];
                return ;
            }
            if (weakSelf.leftView.countTF.text.length == 0) {
                [MBProgressHUD showText:@"请输入委托数量!" toContainer:weakSelf.view];
                return ;
            }
            
            
            if (isBuy) {
                //买入确定按钮事件
                [weakSelf queryWithType:@"0" coinType:weakSelf.model.coinBaseID coinNum:weakSelf.leftView.countTF.text tradeCoinId:weakSelf.model.coinPayID tradeCoinNum:weakSelf.leftView.priceTF.text];
                
            }else{
                //卖出确定按钮事件
                [weakSelf queryWithType:@"1" coinType:weakSelf.model.coinBaseID coinNum:weakSelf.leftView.countTF.text tradeCoinId:weakSelf.model.coinPayID tradeCoinNum:weakSelf.leftView.priceTF.text];
                
            }
            
        }
        
    };
    
    
    self.businessDetailView.BusinessIsLoadMore = ^(BOOL isMore) {
        if (isMore) {
            weakSelf.businessPage++;
        }else{
            weakSelf.businessPage = 0;
        }
        [weakSelf queryBussinessDetail];
    };
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryBuyOrSellList) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
    
    
    self.timerDetail = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(queryBussinessDetail) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timerDetail forMode: NSRunLoopCommonModes];
    //关闭定时器
    [self.timerDetail setFireDate:[NSDate distantFuture]];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillAppear:) name:@"timeOutLogin" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopTimer:) name:@"StopTimer" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopTimer2:) name:@"StopTimer2" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getrefreshModel:) name:@"postHomeData" object:nil];
    
    _leftView.priceChange = ^(NSString *price) {
        
        weakSelf.price = price;
        weakSelf.leftView.countTF.text = @"";
        weakSelf.count = @"";
        if ([JYAccountModel sharedAccount].token.length == 0) {
            [weakSelf matchGuaDanInfoNoTokenWithcoinType:weakSelf.count tradeCoinNum:weakSelf.price];
        }else{
            [weakSelf matchTradeGuadaninfoWithcoinNum:weakSelf.count tradeCoinNum:weakSelf.price];
        }
        
        
        
        
    };
    
    _leftView.countChange = ^(NSString *count) {
        weakSelf.count = count;
        
        if ([JYAccountModel sharedAccount].token.length == 0) {
            [weakSelf matchGuaDanInfoNoTokenWithcoinType:weakSelf.count tradeCoinNum:weakSelf.price];
        }else{
            [weakSelf matchTradeGuadaninfoWithcoinNum:weakSelf.count tradeCoinNum:weakSelf.price];
        }
        
    };
    
    
}

- (void)stopTimer:(NSNotification *)noti{
    
    
    if (self.timer) {
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)stopTimer2:(NSNotification *)noti{
    
    
    if (self.timerDetail) {
        //关闭定时器
        [self.timerDetail setFireDate:[NSDate distantFuture]];
    }
}



- (void)getrefreshModel:(NSNotification *)noti{
    
    if (_index.integerValue == 0) {
        
        _leftView.type = 1;
        
    }else if(_index.integerValue == 1){
        
        _leftView.type = 2;
        
    }
    
    self.isTopTableScrollBottom = YES;
    
    self.model = noti.userInfo[@"model"];
    
    //    [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:@""];
    //
    //    [self queryBuyOrSellList];
    
}

- (void)queryBussinessDetail{
    
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"coinType"] = [JYDefaultDataModel sharedDefaultData].coinBaseID;
    param[@"tradeCoinId"] = [JYDefaultDataModel sharedDefaultData].coinPayID;
    [JYTradingService matchTradeTradeDetails:param page:self.businessPage completion:^(id result, id error) {
        
        NSArray *array = result;
        if (array.count>0) {
            if (self.businessPage==0) {
                self.businessDataArray = [NSMutableArray array];
                self.businessDataArray = result;
                
            }else{
                [self.businessDataArray addObjectsFromArray:result];
                [self.timerDetail setFireDate:[NSDate distantFuture]];
            }
            self.businessDetailView.dataArray = self.businessDataArray;
        }else{
            
            self.businessDataArray = [NSMutableArray array];
            self.businessDataArray = result;
            self.businessDetailView.dataArray = self.businessDataArray;
            
        }
        
        
        
        [self.businessDetailView.tableView.mj_header endRefreshing];
        [self.businessDetailView.tableView.mj_footer endRefreshing];
    }];
}


- (void)matchTradeGuadaninfoWithcoinNum:(NSString *)coinNum tradeCoinNum:(NSString *)tradeCoinNum{
    
    
    [JYTradingService matchTradeGuadaninfoWithcoinType:[JYDefaultDataModel sharedDefaultData].coinBaseID tradeCoinId:[JYDefaultDataModel sharedDefaultData].coinPayID tradeCoinNum:tradeCoinNum coinNum:coinNum completion:^(id result, id error) {
        self.baseModel = result;
        
        _leftView.canUseBTCCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.keyongjiaoyi,[JYDefaultDataModel sharedDefaultData].coinPayName];
        _leftView.freeBTCCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.dongjiejiaoyi,[JYDefaultDataModel sharedDefaultData].coinPayName];
        _leftView.canUseETHCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.keyongchiyou,[JYDefaultDataModel sharedDefaultData].coinBaseName];
        _leftView.freeETHCoin.text =  [NSString stringWithFormat:@"%@%@",self.baseModel.dongjiechiyou,[JYDefaultDataModel sharedDefaultData].coinBaseName];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"isCollect" object:self userInfo:@{@"isCollect":@(self.baseModel.isCollect)}];
        
        //        _leftView.poundageLabel.text = [NSString stringWithFormat:@"%@",self.baseModel.lilv];
        _leftView.pricelLabel.text = [NSString stringWithFormat:@"≈￥%.2lf",floor((self.baseModel.dengzhi.doubleValue)*100)/100];
        _leftView.priceTF.text = [NSString    stringWithFormat:@"%@",self.baseModel.jiaoyidanjia];
        
        
        if (self.index.integerValue == 0) {
            _leftView.canBuyLabel.text = [NSString stringWithFormat:@"可买%.3lf", floor((self.baseModel.kemai.doubleValue)*1000)/1000];
            
        }else if (self.index.integerValue == 1){
            
            _leftView.canBuyLabel.text = [NSString stringWithFormat:@"可卖%.3lf", floor((self.baseModel.keyongchiyou.doubleValue)*1000)/1000];
            
            
        }
    }];
}


- (void)matchGuaDanInfoNoTokenWithcoinType:(NSString *)coinNum tradeCoinNum:(NSString *)tradeCoinNum{
    
    
    [JYTradingService matchGuaDanInfoNoTokenWithcoinType:[JYDefaultDataModel sharedDefaultData].coinBaseID tradeCoinId:[JYDefaultDataModel sharedDefaultData].coinPayID tradeCoinNum:tradeCoinNum coinNum:coinNum completion:^(id result, id error) {
        self.baseModel = result;
        
        _leftView.canUseBTCCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.keyongjiaoyi,[JYDefaultDataModel sharedDefaultData].coinPayName];
        _leftView.freeBTCCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.dongjiejiaoyi,[JYDefaultDataModel sharedDefaultData].coinPayName];
        _leftView.canUseETHCoin.text = [NSString stringWithFormat:@"%@%@",self.baseModel.keyongchiyou,[JYDefaultDataModel sharedDefaultData].coinBaseName];
        _leftView.freeETHCoin.text =  [NSString stringWithFormat:@"%@%@",self.baseModel.dongjiechiyou,[JYDefaultDataModel sharedDefaultData].coinBaseName];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"isCollect" object:self userInfo:@{@"isCollect":@(self.baseModel.isCollect)}];
        
        //        _leftView.poundageLabel.text = [NSString stringWithFormat:@"%@",self.baseModel.lilv];
        _leftView.pricelLabel.text = [NSString stringWithFormat:@"≈￥%.2lf",[self.baseModel.dengzhi doubleValue]];
        _leftView.priceTF.text = [NSString    stringWithFormat:@"%@",self.baseModel.jiaoyidanjia];
        
        self.price = self.baseModel.jiaoyidanjia;
        
        if (self.index.integerValue == 0) {
            _leftView.canBuyLabel.text = [NSString stringWithFormat:@"可买%.3lf", floor((self.baseModel.kemai.doubleValue)*1000)/1000];
        }else if (self.index.integerValue == 1){
            
            _leftView.canBuyLabel.text = [NSString stringWithFormat:@"可卖%.3lf", floor((self.baseModel.keyongchiyou.doubleValue)*1000)/1000];
            
        }
    }];
}


- (void)viewDidDisappear:(BOOL)animated
{
    
    
    if (self.timerDetail) {
        //关闭定时器
        [self.timerDetail setFireDate:[NSDate distantFuture]];
    }
    
    if (self.timer) {
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
    
}

- (void)dealloc
{
    if (self.timerDetail) {
        // 停止定时器
        [self.timerDetail invalidate];
        self.timerDetail = nil;
    }
    if (self.timer) {
        // 停止定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}



- (void)queryWithType:(NSString *)type coinType:(NSString *)coinType coinNum:(NSString *)coinNum tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum{
    
    
    
    
    
    _leftView.buyOrSaleBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _leftView.buyOrSaleBtn.enabled = YES;
    });
    
    [JYTradingService matchTradeBuyType:type coinType:coinType coinNum:coinNum tradeCoinId:tradeCoinId tradeCoinNum:tradeCoinNum completion:^(id result, id error) {
        
        
        if (_index.integerValue == 0) {
            
            //买单
            [MBProgressHUD showText:@"买单成功" toContainer:self.view];
            self.leftView.countTF.text = @"";
            self.leftView.poundageLabel.text = @"0.2%";
            self.leftView.payAccountLabel.text = [NSString stringWithFormat:@"%@%@",@"--",[JYDefaultDataModel sharedDefaultData].coinPayName];
            [self queryBuyOrSellList];
            
        }else if(_index.integerValue == 1){
            //卖单
            [MBProgressHUD showText:@"卖单成功" toContainer:self.view];
            self.leftView.countTF.text = @"";
            self.leftView.poundageLabel.text = @"0.2%";
            self.leftView.payAccountLabel.text = [NSString stringWithFormat:@"%@%@",@"--",[JYDefaultDataModel sharedDefaultData].coinPayName];
            [self queryBuyOrSellList];
        }
        
        if ([JYAccountModel sharedAccount].token.length == 0) {
            [self matchGuaDanInfoNoTokenWithcoinType:@"" tradeCoinNum:@""];
        }else{
            [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:@""];
        }
        
        
    }];
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag == 100) {
        
        self.bottomView.tag = 101;
        
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(37);
        }];
        
        
        self.businessPage = 0;
        [self queryBussinessDetail];
        
        
        _bottomImageView.image = [UIImage imageNamed:@"downDoubleArrows"];
        
        
        //开启定时器
        [self.timerDetail setFireDate:[NSDate distantPast]];
        
        
    }else if(tap.view.tag == 101){
        
        self.bottomView.tag = 100;
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(37);
        }];
        
        self.businessPage = 0;
        [self queryBussinessDetail];
        
        _bottomImageView.image = [UIImage imageNamed:@"upDoubleArrows"];
        
        
        //关闭定时器
        [self.timerDetail setFireDate:[NSDate distantFuture]];
        
    }
    
}

- (void)queryBuyOrSellList{
    
    [JYTradingService kMatchTradeGuadanList:self.model.coinBaseID tradeCoinId:self.model.coinPayID completion:^(id result, id error) {
        
        self.matchModel = result;
        
        self.coinNowPriceLabel.text = [NSString stringWithFormat:@"%@",self.matchModel.price];;
        self.coinForCNYPriceLabel.text = [NSString stringWithFormat:@"≈￥%.2lf",floor((self.matchModel.rmbPrice.doubleValue)*100)/100];
        if (self.matchModel.rate.doubleValue>=0) {
            self.fallOrDegreesLabel.text = [NSString stringWithFormat:@"+%.2lf%%",[self.matchModel.rate doubleValue]];
            self.fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
            self.coinNowPriceLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
        }else{
            self.fallOrDegreesLabel.text = [NSString stringWithFormat:@"%.2lf%%",[self.matchModel.rate doubleValue]];
            self.fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
            self.coinNowPriceLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        }
        
        
        [self.topTable reloadData];
        [self.bottomTable reloadData];
        
        
        
    }];
    
}




- (UITableView *)topTable{
    
    if (!_topTable) {
        _topTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _topTable.delegate = self;
        _topTable.dataSource = self;
        _topTable.estimatedRowHeight = 25;
        _topTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_topTable registerClass:[JYTradingBaseCell class] forCellReuseIdentifier:@"JYTradingBaseCell"];
        _topTable.tableFooterView = [UIView new];
    }
    
    return _topTable;
    
}

- (UITableView *)bottomTable{
    
    if (!_bottomTable) {
        _bottomTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bottomTable.delegate = self;
        _bottomTable.dataSource = self;
        _bottomTable.estimatedRowHeight = 25;
        _bottomTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_bottomTable registerClass:[JYTradingBaseCell class] forCellReuseIdentifier:@"JYTradingBaseCell"];
        _bottomTable.tableFooterView = [UIView new];
    }
    
    return _bottomTable;
    
}

- (UILabel *)coinNowPriceLabel
{
    if (!_coinNowPriceLabel) {
        _coinNowPriceLabel = [UILabel new];
        _coinNowPriceLabel.font = [UIFont systemFontOfSize:15];
        _coinNowPriceLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _coinNowPriceLabel;
}

- (UILabel *)coinForCNYPriceLabel
{
    if (!_coinForCNYPriceLabel) {
        _coinForCNYPriceLabel = [UILabel new];
        _coinForCNYPriceLabel.font = [UIFont systemFontOfSize:12];
        _coinForCNYPriceLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _coinForCNYPriceLabel;
}

- (UILabel *)fallOrDegreesLabel
{
    if (!_fallOrDegreesLabel) {
        _fallOrDegreesLabel = [UILabel new];
        _fallOrDegreesLabel.font = [UIFont systemFontOfSize:12];
        _fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _fallOrDegreesLabel;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGHalfBTNBG);
    }
    return _bottomView;
}


- (UIImageView *)bottomImageView
{
    if (!_bottomImageView) {
        _bottomImageView = [UIImageView new];
        _bottomImageView.image = [UIImage imageNamed:@"upDoubleArrows"];
    }
    return _bottomImageView;
}

- (JYBusinessDetailView *)businessDetailView
{
    if (!_businessDetailView) {
        _businessDetailView = [[JYBusinessDetailView alloc]init];
        
    }
    return _businessDetailView;
}

#pragma mark - tableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    //        if (self.topTable.contentSize.height > self.topTable.bounds.size.height) {
    //            yOffset = self.topTable.contentSize.height - self.topTable.bounds.size.height;
    //        }
    //        [self.topTable setContentOffset:CGPointMake(0, yOffset) animated:NO];
    //    });
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    JYTradingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYTradingBaseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.product = _service.dataSource[indexPath.row];
    
    if (tableView == self.topTable) {
        
        
        
        
        JYTradingBuyOreSellModel *model = [[JYTradingBuyOreSellModel alloc]init];;
        
        if (self.matchModel.sell.count<20) {
            
            
            if (self.matchModel.sell.count == 0) {
                model.tradePriceStr = @"empty";
                model.coinNumStr = @"empty";
            }else{
                
                if (indexPath.row > self.matchModel.sell.count-1) {
                    model.tradePriceStr = @"empty";
                    model.coinNumStr = @"empty";
                    
                }
                else{
                    model = self.matchModel.sell[indexPath.row];
                }
            }
            
        }else if(self.matchModel.sell.count == 20){
            model = self.matchModel.sell[indexPath.row];
        }
        
        cell.type = 1;
        cell.row = indexPath.row+1;
        cell.model = model;
    }else{
        
        
        JYTradingBuyOreSellModel *model = [[JYTradingBuyOreSellModel alloc]init];;
        if (self.matchModel.buy.count<20) {
            
            
            if (self.matchModel.buy.count == 0) {
                
                model.tradePriceStr = @"empty";
                model.coinNumStr = @"empty";
            }else{
                
                if (indexPath.row > self.matchModel.buy.count-1) {
                    model.tradePriceStr = @"empty";
                    model.coinNumStr = @"empty";
                    
                }
                else{
                    model = self.matchModel.buy[indexPath.row];
                }
                
            }
            
        }else if(self.matchModel.buy.count == 20){
            model = self.matchModel.buy[indexPath.row];
        }
        cell.type = 2;
        cell.row = indexPath.row + 1;
        cell.model = model;
        
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == self.topTable) {
        
        JYTradingBuyOreSellModel *model = [[JYTradingBuyOreSellModel alloc]init];;
        
        if (self.matchModel.sell.count<20) {
            
            
            if (self.matchModel.sell.count == 0) {
                model.tradePriceStr = @"empty";
                model.coinNumStr = @"empty";
            }else{
                
                if (indexPath.row > self.matchModel.buy.count-1) {
                    model.tradePriceStr = @"empty";
                    model.coinNumStr = @"empty";
                    
                }
                else{
                    model = self.matchModel.sell[indexPath.row];
                    _leftView.priceTF.text = model.tradePrice;
                    self.price = model.tradePrice;
                    [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:model.tradePrice];
                }
            }
            
        }else if(self.matchModel.sell.count == 20){
            model = self.matchModel.sell[19-indexPath.row];
            self.price = model.tradePrice;
            [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:model.tradePrice];
        }
        
    }else{
        
        
        JYTradingBuyOreSellModel *model = [[JYTradingBuyOreSellModel alloc]init];;
        if (self.matchModel.buy.count<20) {
            
            
            if (self.matchModel.buy.count == 0) {
                
                model.tradePriceStr = @"empty";
                model.coinNumStr = @"empty";
            }else{
                
                if (indexPath.row > self.matchModel.buy.count-1) {
                    model.tradePriceStr = @"empty";
                    model.coinNumStr = @"empty";
                    
                }
                else{
                    model = self.matchModel.buy[indexPath.row];
                    self.price = model.tradePrice;
                    [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:model.tradePrice];
                }
                
            }
            
        }else if(self.matchModel.buy.count == 20){
            model = self.matchModel.buy[indexPath.row];
            self.price = model.tradePrice;
            [self matchTradeGuadaninfoWithcoinNum:@"" tradeCoinNum:model.tradePrice];
        }
        
    }
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
