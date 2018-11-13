//
//  JJRegistWithEmailViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJRegistWithEmailViewController.h"

#import "JJRegistNextViewController.h"
#import "JJRegistWithEmailViewController.h"


@interface JJRegistWithEmailViewController ()

@property (nonatomic, strong) UILabel *loginTitle;
@property (nonatomic, strong) YSCellView    *mobileCell;

@property (nonatomic, strong) UILabel *login;

@property (nonatomic, strong) UILabel *loginWithOther;

@end

@implementation JJRegistWithEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    if (!self.isResetPwd) {
        navigationLabel.text = @"注册";
    }
    else {
        navigationLabel.text = @"找回密码";
    }
    
    UIImageView *logImgView = [[UIImageView alloc] init];
    logImgView.image = [UIImage imageNamed:@"login_nowhite"];
    [self.containerView addSubview:logImgView];
    [logImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.equalTo(self.containerView).offset(20);
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
    _mobileCell.ys_textFiled.placeholder = @"邮箱地址";
    _mobileCell.ys_bottomLineHidden = NO;
    _mobileCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mobileCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    _mobileCell.ys_textFiled.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:_mobileCell];
    _mobileCell.backgroundColor = [UIColor clearColor];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logImgView.mas_bottom).mas_offset(40.f);
        make.left.offset(15.f);
        make.right.offset(-15.f);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 2.f;
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = GoldColor;
    [self.containerView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileCell.mas_bottom).offset(30);
        make.left.right.equalTo(_mobileCell);
        make.height.mas_equalTo(50);
        
    }];
    
    
    [self.containerView addSubview:self.loginWithOther];
    [self.loginWithOther mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.left.equalTo(loginBtn);
        make.bottom.equalTo(self.containerView).offset(-10);
        
    }];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taptoEmail:)];
    self.loginWithOther.userInteractionEnabled = YES;
    
    [self.loginWithOther addGestureRecognizer:tap1];
    
    
    [self.view addSubview:self.login];
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30);
        make.height.mas_offset(20);
    }];
    
    NSString *string1 =  @"已经有MACH账号？登录";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
    [string addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(string1.length-2, 2)];
    self.login.attributedText = string;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.login.userInteractionEnabled = YES;
    [self.login addGestureRecognizer:tap];
    
    
    if (self.isResetPwd) {
        self.loginWithOther.text = @"手机找回";
    }else{
        self.loginWithOther.text = @"手机注册";
    }
    
    self.loginWithOther.hidden = YES;
    
    
    
}

- (void)taptoEmail:(UITapGestureRecognizer *)tap{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)nextStep:(UIButton *)btn{
    
    
    if (_mobileCell.ys_text.length == 0) {
        [MBProgressHUD showText:@"请输入邮箱地址" toContainer:self.view];
        return;
    }else if ( ![self check_Mail:_mobileCell.ys_text]){
        
        [MBProgressHUD showText:@"邮箱不合法" toContainer:nil];
        return;
    }
    
    
    if (self.isResetPwd) {
        
        //忘记密码
        //发送邮箱验证码
        [JJLoginService requestMobileCodeSend:_mobileCell.ys_text type:@"1" category:@"2" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            
            JJRegistNextViewController *vc = [[JJRegistNextViewController alloc]init];
            vc.isResetPwd = self.isResetPwd;
            vc.type = @"5";
            vc.mobileOrEmail = _mobileCell.ys_text;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        
    }else{
        //发送邮箱验证码
        [JJLoginService requestMobileCodeSend:_mobileCell.ys_text type:@"0" category:@"2" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            
            JJRegistNextViewController *vc = [[JJRegistNextViewController alloc]init];
            vc.isResetPwd = self.isResetPwd;
            vc.type = @"5";
            vc.mobileOrEmail = _mobileCell.ys_text;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        
        
    }
    
    
    
    
}



#pragma 正则匹配数字、字母或下划线
- (BOOL)check_LetterUnderlineNumber:(NSString *)string
{
    NSString *pattern = @"^[0-9a-zA-Z_]{2,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:string];
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


- (UILabel *)loginTitle
{
    if (!_loginTitle) {
        _loginTitle = [[UILabel alloc]init];
        _loginTitle.textColor = GoldColor;
        if (self.isResetPwd) {
            _loginTitle.text = @"邮箱找回";
        }else{
            _loginTitle.text = @"邮箱注册";
            
        }
        
        _loginTitle.font = [UIFont systemFontOfSize:30];
        
    }
    return _loginTitle;
}

- (UILabel *)login
{
    if (!_login) {
        _login = [[UILabel alloc]init];
        _login.textColor = HEX_COLOR(@"#333333");
        _login.font = [UIFont systemFontOfSize:16];
        
    }
    return _login;
}

- (UILabel *)loginWithOther
{
    if (!_loginWithOther) {
        _loginWithOther = [[UILabel alloc]init];
        _loginWithOther.textColor = GoldColor;
        _loginWithOther.font = [UIFont systemFontOfSize:16];
        
    }
    return _loginWithOther;
}


@end
