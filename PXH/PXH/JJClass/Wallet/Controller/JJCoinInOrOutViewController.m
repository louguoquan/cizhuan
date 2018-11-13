//
//  JJCoinInOrOutViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCoinInOrOutViewController.h"
#import "JJCoinInView.h"
#import "JJCoinOutView.h"
#import "JJCheckOutViewController.h"

@interface JJCoinInOrOutViewController ()

@property (nonatomic,strong)UIButton *coinInBtn;
@property (nonatomic,strong)UIButton *coinOutBtn;

@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *priceLabel;


@property (nonatomic,strong)UIView *head;
@property (nonatomic,strong)JJCoinInView *coinInView;
@property (nonatomic,strong)JJCoinOutView *coinOutView;
@property (nonatomic,strong)UIWebView *web;


@property (nonatomic,strong)UILabel *freeLabel;
@property (nonatomic,strong)UILabel *releaseLabel;

@property (nonatomic,assign)BOOL isRefresh;

@end

@implementation JJCoinInOrOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isRefresh = NO;
    
    [self setUpNav];
    [self setUI];
    [self isSetPayPwd];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y<-10) {
        if (!self.isRefresh) {
            [self reload];
        }
    }
    
}

- (void)isSetPayPwd{
    
    [JJMineService JJMobileMemberJudgePasswordJDGCompletion:^(id result, id error) {
        if (error) {
            SDError *err = error;
            [MBProgressHUD showErrorMessage:err.errorMessage toContainer:[UIApplication sharedApplication].keyWindow];
        }
    }];
    
}

- (void)setUI{
    
    self.containerView.backgroundColor = HEX_COLOR(@"#F8F8F8");
    self.view.backgroundColor = HEX_COLOR(@"#F8F8F8");
    
    self.head = [[UIView alloc]init];
    self.head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.containerView addSubview:self.head];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.containerView);
        //        make.height.mas_offset(200);
    }];
    
    UIView *buttonView = [[UIView alloc]init];
    buttonView.layer.borderColor = GoldColor.CGColor;
    buttonView.layer.borderWidth = 1.0f;
    buttonView.layer.cornerRadius = 20;
    buttonView.layer.masksToBounds = YES;
    [self.head addSubview:buttonView];
    
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.head).offset(40);
        make.top.equalTo(self.head).offset(10);
        make.right.equalTo(self.head).offset(-40);
        make.height.mas_offset(40);
    }];
    
    [buttonView addSubview:self.coinInBtn];
    [buttonView addSubview:self.coinOutBtn];
    
    [self.coinInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(buttonView);
        make.right.equalTo(self.coinOutBtn.mas_left);
    }];
    
    [self.coinOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(buttonView);
        make.width.equalTo(self.coinInBtn);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"现有%@数量",self.coinName];
    label.textColor = HEX_COLOR(@"#AFB0B4");
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.head addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.head);
        make.top.equalTo(buttonView.mas_bottom).offset(20);
        make.height.mas_offset(15);
    }];
    
    
    [self.head addSubview:self.countLabel];
    [self.head addSubview:self.priceLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.head);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.mas_offset(18);
    }];
    
    if ([self.coinName isEqualToString:CoinNameChange]) {
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.head);
            make.top.equalTo(self.countLabel.mas_bottom).offset(10);
            make.height.mas_offset(15);
        }];
        [self.head addSubview:self.freeLabel];
        [self.head addSubview:self.releaseLabel];
        [self.releaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.freeLabel.mas_right).offset(10);
            make.width.mas_offset(80);
            make.height.mas_offset(30);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self.head).offset(-25);
        }];
        
        
        [self.freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.head);
            make.width.mas_offset(kScreenWidth/2.0);
            make.height.mas_offset(15);
            make.centerY.equalTo(self.releaseLabel);
        }];
        
        
        
        
        self.freeLabel.text = [NSString stringWithFormat:@"锁定:%@",self.model.freezeBalance];
        
    }
    else{
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.head);
            make.top.equalTo(self.countLabel.mas_bottom).offset(10);
            make.height.mas_offset(15);
            make.bottom.equalTo(self.head).offset(-25);
        }];
    }
    
    self.countLabel.text = self.model.balance;
    self.priceLabel.text = [NSString stringWithFormat:@"≈￥%@",self.model.fold];
    
    [self.containerView addSubview:self.coinInView];
    [self.containerView addSubview:self.coinOutView];
    
    [self.coinInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.head.mas_bottom);
        //        make.bottom.equalTo(self.containerView);
    }];
    
    [self.coinInView setUpModel:self.model];
    self.coinOutView.padingLabel.text = [NSString stringWithFormat:@"手续费:%@",self.model.poundage];
    
    
    //    [self.coinOutView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.containerView).offset(10);
    //        make.right.equalTo(self.containerView).offset(-10);
    //        make.top.equalTo(self.head.mas_bottom).offset(10);
    //        make.bottom.equalTo(self.containerView);
    //    }];
    
    self.coinInView.hidden = NO;
    self.coinOutView.hidden = YES;
    
    WS(weakSelf);
    self.coinOutView.jjTransformClick = ^{
        
        [weakSelf query];
        
    };
    
    self.coinInView.jjRefreshAccount = ^{
        [weakSelf reload];
    };
    
    
    self.web = [[UIWebView alloc] init];
    self.web.delegate = self;
    self.web.scrollView.scrollEnabled = NO;
    [self.containerView addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coinInView.mas_bottom);
        make.left.right.equalTo(self.containerView);
        make.height.mas_offset(200);
        make.bottom.equalTo(self.containerView);
    }];
    
    NSString *htmlString = self.model.url;
    [self.web  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
}



- (void)viewDidDisappear:(BOOL)animated
{
    self.web = nil;
    [self cleanCacheAndCookie];
    
    
}



/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight =[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    [self.web mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(webViewHeight+10);
        make.bottom.equalTo(self.containerView).offset(-10);
    }];
}

- (void)reload{
    
    self.isRefresh = YES;
    [MBProgressHUD showLoadingToContainer:self.view];
    [JJWalletService JJRefreshCoin:self.model.coinTypeId Completion:^(id result, id error) {
        if (!error) {
            [JJWalletService JJMyAccountWithCoinId:self.model.coinTypeId Completion:^(id result, id error) {
                
                [MBProgressHUD dismissForContainer:self.view];
                
                if (!error) {
                    self.model = result;
                    self.countLabel.text = self.model.balance;
                    self.priceLabel.text = [NSString stringWithFormat:@"≈￥%@",self.model.fold];
                    [self.coinInView setUpModel:self.model];
                }
                self.isRefresh = NO;
            }];
        }
    }];
    
    

    
}

- (void)query{
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showLoadingToContainer:self.view];
    [JJWalletService JJPutForwardWithCoinId:self.model.coinTypeId number:self.coinOutView.countCell.ys_text toAddress:self.coinOutView.addressCell.ys_text password:self.coinOutView.busPwd.ys_text Completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:self.view];
        if (!error) {
            
            self.coinOutView.countCell.ys_text = @"";
            self.coinOutView.addressCell.ys_text = @"";
            self.coinOutView.busPwd.ys_text = @"";
            [self reload];
            [MBProgressHUD showText:@"转账成功" toContainer:[UIApplication sharedApplication].keyWindow];
            
        }
        
    }];
    
}

- (void)checkOut{
    
    
    JJCheckOutViewController *vc = [[JJCheckOutViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = [NSString stringWithFormat:@"%@",self.coinName];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}


- (void)submit:(UIButton *)btn{
    
    if (!self.coinOutBtn.selected) {
        self.coinOutBtn.selected = !self.coinOutBtn.selected;
        self.coinInBtn.selected =!self.coinInBtn.selected;
        self.coinOutBtn.backgroundColor = GoldColor;
        self.coinInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        
        [self.coinOutView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(10);
            make.right.equalTo(self.containerView).offset(-10);
            make.top.equalTo(self.head.mas_bottom).offset(10);
            make.bottom.equalTo(self.containerView).offset(-300);
        }];
        
        
        self.coinInView.hidden = YES;
        self.web.hidden = YES;
        self.coinOutView.hidden = NO;
    }else{
        self.coinInBtn.selected = NO;
        self.coinOutBtn.backgroundColor = GoldColor;
        self.coinInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    }
    
}

- (void)submit1:(UIButton *)btn{
    
    if (!self.coinInBtn.selected) {
        self.coinOutBtn.selected = !self.coinOutBtn.selected;
        self.coinInBtn.selected =!self.coinInBtn.selected;
        self.coinInBtn.backgroundColor = GoldColor;
        self.coinOutBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        
        [self.coinInView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.top.equalTo(self.head.mas_bottom);
        }];
        
        self.coinInView.hidden = NO;
        self.web.hidden = NO;
        self.coinOutView.hidden = YES;
        
    }else{
        self.coinOutBtn.selected = NO;
        self.coinInBtn.backgroundColor = GoldColor;
        self.coinOutBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    }
    
}

- (UIButton *)coinInBtn
{
    if (!_coinInBtn) {
        _coinInBtn = [[UIButton alloc]init];
        _coinInBtn.backgroundColor = GoldColor;
        _coinInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_coinInBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_coinInBtn setTitleColor:GoldColor forState:UIControlStateNormal];
        [_coinInBtn setTitleColor:HEX_COLOR(@"#23262E") forState:UIControlStateSelected];
        [_coinInBtn addTarget:self action:@selector(submit1:) forControlEvents:UIControlEventTouchUpInside];
        _coinInBtn.selected = YES;
        
    }
    return _coinInBtn;
}



- (UIButton *)coinOutBtn
{
    if (!_coinOutBtn) {
        _coinOutBtn = [[UIButton alloc]init];
        _coinOutBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        _coinOutBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_coinOutBtn setTitle:@"转账" forState:UIControlStateNormal];
        [_coinOutBtn setTitleColor:GoldColor forState:UIControlStateNormal];
        [_coinOutBtn setTitleColor:HEX_COLOR(@"#23262E") forState:UIControlStateSelected];
        [_coinOutBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _coinOutBtn;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:18];
        _countLabel.textColor = GoldColor;
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = HEX_COLOR(@"#AFB0B4");
    }
    return _priceLabel;
}

- (UILabel *)freeLabel
{
    if (!_freeLabel) {
        _freeLabel = [[UILabel alloc]init];
        _freeLabel.font = [UIFont systemFontOfSize:15];
        _freeLabel.textAlignment = NSTextAlignmentRight;
        _freeLabel.textColor = HEX_COLOR(@"#AFB0B4");
    }
    return _freeLabel;
}

- (UILabel *)releaseLabel
{
    if (!_releaseLabel) {
        _releaseLabel = [[UILabel alloc]init];
        _releaseLabel.font = [UIFont systemFontOfSize:14];
        _releaseLabel.textAlignment = NSTextAlignmentCenter;
        _releaseLabel.textColor = GoldColor;
        _releaseLabel.layer.cornerRadius = 15;
        _releaseLabel.layer.masksToBounds = YES;
        _releaseLabel.layer.borderColor = GoldColor.CGColor;
        _releaseLabel.layer.borderWidth = 0.5f;
        _releaseLabel.text = @"解锁";
        _releaseLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkOut)];
        [_releaseLabel addGestureRecognizer:tap];
    }
    return _releaseLabel;
}

- (JJCoinInView *)coinInView
{
    if (!_coinInView) {
        _coinInView = [[JJCoinInView alloc]init];
    }
    return _coinInView;
}

- (JJCoinOutView *)coinOutView
{
    if (!_coinOutView) {
        _coinOutView = [[JJCoinOutView alloc]init];
    }
    return _coinOutView;
    
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
