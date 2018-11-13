//
//  JJBuyCoinNextStepViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinNextStepViewController.h"
#import "JJBuyCoinHeadView.h"
#import "JJBuyCoinPayViewController.h"
#import "JJBuyCoinFinishViewController.h"


@interface JJBuyCoinNextStepViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *balanceLabel;
@property (nonatomic,strong)UILabel *countMLabel;
@property (nonatomic, strong) YSCellView *countCell;
@property (nonatomic, strong) UIView *countBgView;
@property (nonatomic,strong)UIWebView *web;
@property (nonatomic,strong)UIButton *submitBtn;
@property (nonatomic,strong)YSCellView *busPwd;

@end

@implementation JJBuyCoinNextStepViewController


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"兑换";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self isSetPayPwd];
    
    [self setUpNav];
    self.containerView.backgroundColor = HEX_COLOR(@"#F7F8F9");
    
    //    JJBuyCoinHeadView *vc = [[JJBuyCoinHeadView alloc]init];
    //    [self.containerView addSubview:vc];
    //    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.top.equalTo(self.containerView);
    //        make.height.mas_offset(140);
    //    }];
    
    [self.containerView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(30);
        make.centerX.equalTo(self.containerView);
        make.height.mas_offset(20);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"剩余%@数量",CoinNameChange];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.containerView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.height.mas_offset(23);
    }];
    
    [self.containerView addSubview:self.countBgView];
    [self.countBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.top.equalTo(self.countLabel.mas_bottom).offset(15);
    }];
    
    
    _countCell = [self creatCellLeftTitle:nil PlaceHolder:[NSString stringWithFormat:@"请输入%@兑换数量",CoinNameChange] rightView:nil isLineHidden:NO];
    
    _countCell.ys_textFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    
    _countMLabel = [[UILabel alloc]init];
    _countMLabel.text = @"支付金额:0.00";
    _countMLabel.textColor = HEX_COLOR(@"#555555");
    _countMLabel.font = [UIFont systemFontOfSize:15];
    _countMLabel.textAlignment = NSTextAlignmentLeft;
    [self.countBgView addSubview:_countMLabel];
    [_countMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBgView).offset(15);
        make.right.equalTo(self.countBgView).offset(-10);
        make.top.equalTo(_countCell.mas_bottom).offset(10);
        make.height.mas_offset(15);
    }];
    
    [self.countBgView addSubview:self.busPwd];
    [self.busPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBgView).offset(5);
        make.right.equalTo(self.countBgView).offset(-5);
        make.height.mas_offset(30);
        make.top.equalTo(self.countMLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.countBgView).offset(-30);
    }];
    
    
    self.web = [[UIWebView alloc] init];
    self.web.delegate = self;
    self.web.scrollView.scrollEnabled = NO;
    [self.containerView addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countBgView.mas_bottom).offset(20);
        make.left.right.equalTo(self.countBgView);
        make.height.mas_offset(200);
    }];
    //    NSString *htmlString = self.webUrl;
    
    
    
    [self.containerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(40);
        make.width.mas_offset(kScreenWidth-20);
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.web.mas_bottom).offset(40);
        make.bottom.equalTo(self.containerView).offset(-30);
    }];
    
    self.countLabel.text = @"0.00";
    NSString *string1 = [NSString stringWithFormat:@"可用%@:%@",PayCoinNameChange,@"0.00"];
    NSString *string2 = [NSString stringWithFormat:@"可用%@:",PayCoinNameChange];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
    [string addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"#333333") range:NSMakeRange(0, string2.length)];
    self.balanceLabel.attributedText = string;
    
    [self query];
    
    [_countCell.ys_textFiled addTarget:self action:@selector(countWithQuery:) forControlEvents:UIControlEventEditingChanged];
    
    [self countWithQuery:_countCell.ys_textFiled];
    
}


- (void)isSetPayPwd{
    
    [JJMineService JJMobileMemberJudgePasswordJDGCompletion:^(id result, id error) {
        if (error) {
            SDError *err = error;
            [MBProgressHUD showErrorMessage:err.errorMessage toContainer:[UIApplication sharedApplication].keyWindow];
        }
    }];
    
}

- (void)countWithQuery:(UITextField *)tf{
    
    
    if (tf.text.length == 0) {
        self.countMLabel.text = [NSString stringWithFormat:@"支付金额:%@%@",@"0.0000",PayCoinNameChange];
        return;
    }
    
    [JJCalculateService JJMobileMemberOrderEthNumber:tf.text.length>0?tf.text:@"0" Completion:^(id result, id error) {
        
        NSDictionary *dict = result;
        
        self.countMLabel.text = [NSString stringWithFormat:@"支付金额:%@%@",dict[@"result"],PayCoinNameChange];
        
    }];
    
    
    
}

- (void)query{
    
    [JJCalculateService JJMobileMemberOrderResidualQuantityCompletion:^(id result, id error) {
        JJBuyInfoModel *model = result;
        self.countLabel.text = model.residualQuantity;
//        self.countMLabel.text = model.shuliang;
        NSString *htmlString =  model.rengouxuzhi;
        
        
        NSString *string1 = [NSString stringWithFormat:@"可用%@:%@",PayCoinNameChange,model.balance];
        NSString *string2 = [NSString stringWithFormat:@"可用%@:",PayCoinNameChange];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
        [string addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"#333333") range:NSMakeRange(0, string2.length)];
        self.balanceLabel.attributedText = string;
        [self.web  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlString]]];
        
    }];
    
    
    
}

- (void)submit:(UIButton *)btn{
    
    if (_countCell.ys_text.length == 0) {
        [MBProgressHUD showText:@"请输入MACH兑换数量" toContainer:self.view];
        return;
    }
    
    if (_busPwd.ys_text.length == 0) {
        [MBProgressHUD showText:@"请输入交易密码" toContainer:self.view];
        return;
    }
    
    [MBProgressHUD showLoadingToContainer:self.view];
    
    
    [JJWalletService JJMobileMemberOrderBalancePay:@"2" buyNumber:_countCell.ys_text payPassword:_busPwd.ys_text Completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:self.view];
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showText:@"兑换成功" toContainer:[UIApplication sharedApplication].keyWindow];
        }
        
    }];
    
    
    
    
    
    
    
}


- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:25];
        _countLabel.textColor = GoldColor;
    }
    return _countLabel;
}

- (UILabel *)balanceLabel
{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc]init];
        _balanceLabel.font = [UIFont systemFontOfSize:25];
        _balanceLabel.textColor = GoldColor;
    }
    return _balanceLabel;
}

- (UIView *)countBgView
{
    if (!_countBgView) {
        _countBgView = [[UIView alloc]init];
        _countBgView.backgroundColor = [UIColor whiteColor];
    }
    return _countBgView;
}


- (YSCellView *)creatCellLeftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder rightView:(id)obj isLineHidden:(BOOL)isHidden
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = isHidden;
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    cell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    if (leftTitle) {
        cell.ys_title = leftTitle;
        cell.ys_titleWidth = 15*4;
    }
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.countBgView).offset(30);
        make.left.equalTo(self.countBgView).offset(10);
        make.right.equalTo(self.countBgView).offset(-10);
        make.height.mas_equalTo(51.f);
    }];
    
    
    
    return cell;
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
    }];
}


- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitle:@"提交兑换" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        
    }
    return _submitBtn;
}

- (YSCellView *)busPwd
{
    if (!_busPwd) {
        _busPwd = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _busPwd.backgroundColor = [UIColor whiteColor];
        _busPwd.ys_bottomLineHidden = NO;
        _busPwd.ys_separatorColor = HEX_COLOR(@"#ededed");
        _busPwd.ys_titleFont = [UIFont systemFontOfSize:14];
        _busPwd.ys_titleColor = HEX_COLOR(@"#333333");
        _busPwd.ys_contentFont = [UIFont systemFontOfSize:14];
        _busPwd.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _busPwd.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _busPwd.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _busPwd.ys_contentPlaceHolder = @"请输入交易密码";
        _busPwd.ys_title = @"交易密码";
        _busPwd.ys_titleWidth = 15*4;
        _busPwd.ys_textFiled.secureTextEntry = YES;
    }
    return _busPwd;
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
