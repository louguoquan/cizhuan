//
//  YSLoginViewController.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLoginViewController.h"
#import "YSChangePasswordViewController.h"
#import "YSRegisterViewController.h"

@interface YSLoginViewController ()

@property (nonatomic, strong) YSCellView    *mobileCell;

@property (nonatomic, strong) YSCellView    *pswCell;

@property (nonatomic, strong) UIButton      *visibleButton;

@end

@implementation YSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"手机登录";
    
    [self initSubviews];
}

- (void)initSubviews {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _mobileCell.backgroundColor = [UIColor whiteColor];
    _mobileCell.ys_title = @"手机号";
    _mobileCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_titleColor = HEX_COLOR(@"#666666");
    _mobileCell.ys_titleWidth = 15 * 3;
    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_contentPlaceHolder = @"请输入手机号";
    [self.containerView addSubview:_mobileCell];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    _pswCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _pswCell.backgroundColor = [UIColor whiteColor];
    _pswCell.ys_textFiled.secureTextEntry = YES;
    _pswCell.ys_title = @"密码";
    _pswCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _pswCell.ys_titleColor = HEX_COLOR(@"#666666");
    _pswCell.ys_titleWidth = 15 * 3;
    _pswCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _pswCell.ys_contentPlaceHolder = @"请输入密码";
    [self.containerView addSubview:_pswCell];
    [_pswCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileCell.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    UIButton *visibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [visibleButton setImage:[UIImage imageNamed:@"not-see"] forState:UIControlStateNormal];
    [visibleButton setImage:[UIImage imageNamed:@"see"] forState:UIControlStateSelected];
    [visibleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        sender.selected = !sender.selected;
        self.pswCell.ys_textFiled.secureTextEntry = !sender.selected;
    }];
    [visibleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    _pswCell.ys_accessoryView = visibleButton;

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pswCell.mas_bottom).offset(30);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [registButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [registButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [registButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self.view endEditing:YES];
        [self.navigationController pushViewController:[YSRegisterViewController new] animated:YES];
    }];
    [self.containerView addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom);
        make.height.mas_equalTo(30);
        make.left.equalTo(loginButton);
        make.bottom.offset(-20);
    }];
    
    UIButton *forgetPswButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPswButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPswButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPswButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    forgetPswButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetPswButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self.view endEditing:YES];
        YSChangePasswordViewController *vc = [YSChangePasswordViewController new];
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.containerView addSubview:forgetPswButton];
    [forgetPswButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom);
        make.height.mas_equalTo(30);
        make.right.equalTo(loginButton);
    }];
}

- (void)login {
    
    [self.view endEditing:YES];
    if (_mobileCell.ys_text.length <= 0 || _pswCell.ys_text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入正确的账号密码" toContainer:nil];
        return;
    }
    
    [MBProgressHUD showLoadingText:@"正在登陆" toContainer:nil];
//    [YSAccountService loginServiceType:1
//                                mobile:_mobileCell.ys_text
//                              password:_pswCell.ys_text
//                                  code:nil
//                              userInfo:nil
//                            completion:^(id result, id error) {
//                                [MBProgressHUD showSuccessMessage:@"登录成功" toContainer:nil];
//                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                    [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
//                                });
//                            }];
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
