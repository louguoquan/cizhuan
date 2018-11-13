//
//  JYC2CViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYC2CViewController.h"
#import "JYC2CBuyView.h"
#import "JYWithdrawalView.h"
#import "JYC2CBuyNextView.h"
#import "JYC2CRecordListViewController.h"
#import "JYAssetsService.h"
#import "JYRecordController.h"




@interface JYC2CViewController ()

{
    BOOL _wasKeyboardManagerEnabled;
}

@property (nonatomic,strong)UIView *navigationView;

@property (nonatomic,strong)UILabel *navigationLabel;

@property (nonatomic,strong)JYC2CBuyView *buyView;
@property (nonatomic,strong)JYC2CBuyNextView *buyNextView;
@property (nonatomic,strong)JYWithdrawalView *withdrawalView;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *btn1;

@property (nonatomic,assign)NSInteger first;
@property (nonatomic,assign)NSInteger isShowFirst;
@property (nonatomic,strong)JYBankModel *bankModel;
@property (nonatomic,strong)JYUSDTModel *usdtModel;


@end

@implementation JYC2CViewController




- (void)viewWillAppear:(BOOL)animated
{
    [self queryBankInfo];
    [self queryOrderWithTag:0];
    [self queryWirthNote];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.first = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _navigationLabel;
    _navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    _navigationLabel.text = @"充值提现";
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    self.containerView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    
    [self setupView];
    
    [self.containerView addSubview:self.buyView];
    [self.containerView addSubview:self.withdrawalView];
    [self.containerView addSubview:self.buyNextView];
    
    if (self.isStop) {
        self.buyView.isStop = @"YES";
//        [self.buyView.buyBtn setTitle:@"暂停买入" forState:UIControlStateNormal];
//        self.buyView.buyBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnGrey);
    }
    
    
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-20);
        make.top.equalTo(self.containerView).offset(10);
        make.left.equalTo(self.containerView).offset(10);
        
    }];
    
    
    WS(weakSelf)
    self.buyView.OrderCreateSuccess = ^{
        weakSelf.buyView.alpha = 1.0;
        weakSelf.buyNextView.alpha = 0.0;
        [UIView animateWithDuration:1.5 animations:^{
            weakSelf.buyView.alpha = 0.0;
            weakSelf.buyNextView.alpha = 1.0;
        }];
        [weakSelf.view endEditing:YES];
        weakSelf.first = 0;
        [weakSelf queryOrderWithTag:0];
    };
    [self.buyNextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView);
        
    }];
    
    
    
    self.buyNextView.buyTableView.ClickBtnWithStatus = ^(NSInteger index) {
        
        if (index == 3) {
            index = -1;
        }
        [weakSelf queryOrderWithTag:index];
    };
    
    
    
    self.buyView.alpha = 0.0;
    self.buyNextView.alpha = 0.0;
    
    if (self.buyView.alpha == 0.0) {
        
        [self.withdrawalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.top.equalTo(self.containerView);
            make.left.equalTo(self.buyNextView);
            make.bottom.equalTo(self.containerView);
        }];
        
    }else{
        
        [self.withdrawalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.top.equalTo(self.containerView);
            make.left.equalTo(self.buyView.mas_right).offset(10);
            make.right.equalTo(self.containerView);
            make.bottom.equalTo(self.containerView);
        }];
    }
    
    
    
    
    self.withdrawalView.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderStatusChange:) name:@"orderStatusChange" object:nil];
    
}


- (void)queryBankInfo{
    //获取银行卡信息
    
    [JYAssetsService mobileCmsBankCardCcompletion:^(id result, id error) {
        self.bankModel = result;
        self.buyNextView.model = self.bankModel;
        
    }];
    
    
    [JYAssetsService matchTradeGetUsdtCcompletion:^(id result, id error) {
        self.usdtModel = result;
        
        self.buyView.model = self.usdtModel;
        
    }];
    
    
}

- (void)orderStatusChange:(NSNotification *)noti{
    
    [self.view endEditing:YES];
    if ([noti.userInfo[@"status"]isEqualToString:@"cancel"]) {
        
        self.first = 0;
    }
    [self queryOrderWithTag:0];
    
    
}


- (void)queryWirthNote{
    
    
    [JYAssetsService fetchWithdrawNoticeCompletion:^(id result, id error) {
        
        self.withdrawalView.messageView.array = result;
        
    }];
    
    
    
    
}


- (void)queryOrderWithTag:(NSInteger )tag{
    
    
    
    [JYAssetsService fetchOrderListWithType:@"0" status:tag completion:^(id result, id error) {
        
        NSArray *array = result;
        
        
        if (self.first == 0) {
            if (array.count>0) {
                
                self.buyView.alpha = 0.0;
                self.buyNextView.alpha = 1.0;
                self.isShowFirst = 0;
                JYBuyOrderListModel *model = [array firstObject];
                self.bankModel.remarks = model.remark;
                self.buyNextView.model = self.bankModel;
                
                
            }else{
                self.buyView.alpha = 1.0;
                self.buyNextView.alpha = 0.0;
                self.isShowFirst = 1;
            }
        }
        
        self.first ++;
        
        self.buyNextView.buyTableView.dataArray = [NSMutableArray arrayWithArray:array];
        [self.buyNextView.buyTableView.tableView reloadData];
        self.buyNextView.buyTableView.tableView.scrollEnabled = NO;
        [self.buyNextView.buyTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(array.count*81+50);
            
        }];
        
        if (array.count > 0 ) {
            
            [self.buyNextView.noteView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.buyNextView).offset(-10);
            }];
            
        }else{
            [self.buyNextView.noteView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenWidth);
                make.left.equalTo(self.buyNextView);
                make.top.equalTo(self.buyNextView.buyTableView.mas_bottom).offset(20);
            }];
        }
    }];
    
}



- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    [UIView commitAnimations];
}




- (void)setupView{
    
    self.navigationView = [[UIView alloc] init];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(200);
    }];
    
    
    self.navigationItem.titleView = self.navigationView;
    
    
    self.btn = [[UIButton alloc]init];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn  setTitle:@"充值" forState:UIControlStateNormal];
    [self.btn  dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    [self.navigationView addSubview:self.btn ];
    [self.btn addTarget:self action:@selector(chanege:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn1 = [[UIButton alloc]init];
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:18];
    self.btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn1 setTitle:@"提现" forState:UIControlStateNormal];
    [self.btn1 dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    [self.navigationView addSubview:self.btn1];
    [self.btn1 addTarget:self action:@selector(chanege:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.right.equalTo(self.navigationView);
        make.top.equalTo(_navigationView).offset(5);
        make.bottom.equalTo(_navigationView).offset(-5);
    }];
    
    [self.btn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.equalTo(self.navigationView);
        make.top.equalTo(_navigationView).offset(5);
        make.bottom.equalTo(_navigationView).offset(-5);
    }];
    
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"记录" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    [btn addTarget:self action:@selector(gotoRecordListView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)gotoRecordListView{
    
    //    JYC2CRecordListViewController *vc = [[JYC2CRecordListViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    JYRecordController *vc = [[JYRecordController alloc] init];
    vc.type = RecordType_Withdraw;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chanege:(UIButton *)btn{
    
    if (btn == _btn) {
        
        if (self.isShowFirst) {
            self.buyView.alpha = 1.0;
        }else{
            self.buyNextView.alpha = 1.0;
        }
        //        if (self.buyView.alpha == 0.0) {
        //            self.buyView.alpha = 1.0;
        //        }else if(self.buyNextView.alpha == 0.0) {
        //            self.buyNextView.alpha = 1.0;
        //        }
        
        self.withdrawalView.hidden = YES;
    }else{
        
        if (self.buyView.alpha == 0.0) {
            self.buyNextView.alpha = 0;
        }else if(self.buyNextView.alpha == 0.0) {
            self.buyView.alpha = 0.0;
        }
        
        self.withdrawalView.hidden = NO;
    }
    
    if (self.buyView.alpha == 0) {
        
        [self.withdrawalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.top.equalTo(self.containerView);
            make.left.equalTo(self.buyNextView);
            make.bottom.equalTo(self.containerView);
        }];
        
        
    }else{
        
        [self.withdrawalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.top.equalTo(self.containerView);
            make.left.equalTo(self.buyView.mas_right).offset(10);
            make.right.equalTo(self.containerView);
            make.bottom.equalTo(self.containerView);
        }];
    }
    
    
    
    
}

- (JYC2CBuyView *)buyView
{
    if (!_buyView) {
        _buyView = [[JYC2CBuyView alloc]init];
        _buyView.layer.cornerRadius = 4.0f;
        _buyView.layer.masksToBounds = YES;
    }
    return _buyView;
}

- (JYC2CBuyNextView *)buyNextView
{
    if (!_buyNextView) {
        _buyNextView = [[JYC2CBuyNextView alloc]init];
        _buyNextView.layer.cornerRadius = 4.0f;
        _buyNextView.layer.masksToBounds = YES;
    }
    return _buyNextView;
}




- (JYWithdrawalView *)withdrawalView
{
    if (!_withdrawalView) {
        _withdrawalView = [[JYWithdrawalView alloc]init];
        
    }
    return _withdrawalView;
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
