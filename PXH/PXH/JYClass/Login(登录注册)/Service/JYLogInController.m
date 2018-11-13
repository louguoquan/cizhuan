//
//  JYLogInController.m
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYLogInController.h"
#import "JYPageController.h"

#import "JYLoginService.h"
#import "JJRegistViewController.h"


@interface JYLogInController ()

@property (nonatomic, strong) YSCellView    *mobileCell;
@property (nonatomic, strong) YSCellView    *pswCell;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *loginMessage;
@property (nonatomic, strong) UILabel *loginTitle;

@end

@implementation JYLogInController

- (void)viewWillAppear:(BOOL)animated
{
    //这里隐藏导航栏
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden =NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"登录";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame =CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:@"backWhite"] forState:0];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setUpUI
{
    WS(weakSelf);
    
    
    [self.containerView addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *logImgView = [[UIImageView alloc] init];
    logImgView.image = [UIImage imageNamed:@"login_white"];
    [self.containerView addSubview:logImgView];
    [logImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100.f);
        make.centerX.equalTo(weakSelf.containerView).offset(-30);
        make.height.mas_equalTo(49.f);
        make.width.mas_offset(128);
    }];
    
    
    [self.containerView addSubview:self.loginTitle];
    [self.loginTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logImgView);
        make.left.equalTo(logImgView.mas_right).offset(10);
        make.height.equalTo(logImgView);
    }];
    
    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:18];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"手机号码" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor]
                                        }];
    _mobileCell.ys_textFiled.attributedPlaceholder = attrString;
    _mobileCell.ys_bottomLineHidden = NO;
    _mobileCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mobileCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    _mobileCell.ys_textFiled.textColor = [UIColor whiteColor];
    _mobileCell.ys_bottomLine.backgroundColor = HEX_COLOR(@"#41434B");
    [self.containerView addSubview:_mobileCell];
    _mobileCell.backgroundColor = [UIColor clearColor];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logImgView.mas_bottom).mas_offset(40.f);
        make.left.offset(15.f);
        make.right.offset(-15.f);
        make.height.mas_equalTo(60);
    }];
    
    _pswCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _pswCell.ys_contentFont = [UIFont systemFontOfSize:18];
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"密码" attributes:
                                       @{NSForegroundColorAttributeName:[UIColor whiteColor]
                                         }];
    _pswCell.ys_textFiled.attributedPlaceholder = attrString1;
    _pswCell.ys_bottomLineHidden = NO;
    _pswCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    _pswCell.ys_textFiled.secureTextEntry = YES;
    _pswCell.ys_bottomLine.backgroundColor = HEX_COLOR(@"#41434B");
    _pswCell.ys_textFiled.textColor = [UIColor whiteColor];
    [self.containerView addSubview:_pswCell];
    _pswCell.backgroundColor = [UIColor clearColor];
    [_pswCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mobileCell.mas_bottom).mas_offset(10.f);
        make.left.right.equalTo(_mobileCell);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 2.f;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = GoldColor;
    [self.containerView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pswCell.mas_bottom).offset(30);
        make.left.right.equalTo(_pswCell);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *forgetPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPswButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPswButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPswButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [forgetPswButton setTitleColor:GoldColor forState:UIControlStateNormal];
    [forgetPswButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self.view endEditing:YES];
        JJRegistViewController *pageVC = [[JJRegistViewController alloc] init];
        pageVC.isResetPwd = YES;
        [self.navigationController pushViewController:pageVC animated:YES];
    }];
    [self.containerView addSubview:forgetPswButton];
    [forgetPswButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).mas_offset(15.f);
        make.height.mas_equalTo(40);
        make.left.equalTo(loginBtn);
        make.bottom.offset(-20);
    }];
    
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [registButton setTitleColor:GoldColor forState:UIControlStateNormal];
    [registButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self.view endEditing:YES];
        JJRegistViewController *pageVC = [[JJRegistViewController alloc] init];
        pageVC.isResetPwd = NO;
        [self.navigationController pushViewController:pageVC animated:YES];
    }];
    [self.containerView addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(forgetPswButton);
        make.right.equalTo(loginBtn);
    }];
    
    
    [self.containerView addSubview:self.loginMessage];
    [self.loginMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(forgetPswButton);
        make.right.equalTo(registButton.mas_left);
    }];
    
    
    
    //    self.mobileCell.ys_text = @"15239293216";//15267850711
    //    self.pswCell.ys_text = @"l111111";
    
    self.mobileCell.ys_text = @"";//15267850711
    self.pswCell.ys_text = @"";
    //
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginAction:(UIButton *)sender
{
    NSLog(@"登录");
    
    if (![self judgmentOfLegality]) return;
    
    [self.view endEditing:YES];
    //发送注册请求
    [MBProgressHUD showLoadingText:@"正在登录" toContainer:nil];
    
    
    [JJLoginService mobileMemberLoginWithMobile:self.mobileCell.ys_text password:self.pswCell.ys_text Completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"登录成功" toContainer:nil];
        
        [JJMineService JJMobileMemberOneDayLoginCompletion:^(id result, id error) {
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
        });
    }];
    

}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"home_bg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)loginMessage
{
    if (!_loginMessage) {
        _loginMessage = [[UILabel alloc]init];
        _loginMessage.textColor = [UIColor whiteColor];
        _loginMessage.text = @"还没有MACH账号？";
        _loginMessage.font = [UIFont systemFontOfSize:16];
    }
    return _loginMessage;
}


- (UILabel *)loginTitle
{
    if (!_loginTitle) {
        _loginTitle = [[UILabel alloc]init];
        _loginTitle.textColor = GoldColor;
        _loginTitle.text = @"登录";
        _loginTitle.font = [UIFont systemFontOfSize:30];
        
    }
    return _loginTitle;
}

//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (isLegal) {
        isLegal = self.mobileCell.ys_textFiled.text.length;
        message = @"账号不能为空";
    }
    
    if (isLegal) {
        isLegal = self.pswCell.ys_textFiled.text.length;
        message = @"密码不能为空";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}

#pragma 正则匹配数字(至少length位)
- (BOOL)check_Number:(NSString *)string length:(NSInteger)length
{
    NSString *emailRegex = [NSString stringWithFormat:@"^\\d{%ld,}$", (long)length];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma 正则匹配邮箱号
- (BOOL)check_Mail:(NSString *)string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma 正则匹配6-20位数字和字母组合
- (BOOL)check_LetterNumGroup:(NSString *)string
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:string];
}

@end
