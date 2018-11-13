//
//  YSPaymentSettingsViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPaymentSettingsViewController.h"

#import "YSButton.h"
#import "YSValidateButton.h"

@interface YSPaymentSettingsViewController ()

@property (nonatomic, strong) UILabel   *mobileLabel;

@property (nonatomic, strong) YSCellView    *codeCell;

@property (nonatomic, strong) YSCellView    *passWordCell1;

@property (nonatomic, strong) YSCellView    *passWordCell2;

@end

@implementation YSPaymentSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"支付密码设置";
    
    [self initSubviews];
}

- (void)initSubviews {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    UIView *mobileView = [self createMobileView];
    [self.containerView addSubview:mobileView];
    [mobileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
    }];
    
    UIView *passWordView = [self createPassworkView];
    [self.containerView addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobileView.mas_bottom).offset(10);
        make.left.right.offset(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passWordView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
        make.left.offset(15);
        make.right.offset(-15);
        make.bottom.offset(-10);
    }];
}

- (void)confirm {
    if (_codeCell.ys_text.length <= 0 || _passWordCell1.ys_text.length <= 0 || _passWordCell2.ys_text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"信息不完整" toContainer:nil];
        return;
    }
    
    if (_passWordCell1.ys_text.length != 6) {
        [MBProgressHUD showInfoMessage:@"请设置6位支付密码" toContainer:nil];
        return;
    }
    
    if (![_passWordCell2.ys_text isEqualToString:_passWordCell1.ys_text]) {
        [MBProgressHUD showInfoMessage:@"两次密码输入不相同" toContainer:nil];
        return;
    }
    
    [MBProgressHUD showLoadingText:@"正在设置" toContainer:nil];
    [YSAccountService updatePasswordWithUrl:kChangePayPsw_URL mobile:[YSAccount sharedAccount].mobile code:_codeCell.ys_text password:_passWordCell1.ys_text completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"设置成功" toContainer:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - view

- (UIView *)createMobileView {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"phone"];
    [view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.centerX.equalTo(view);
    }];
    
    WS(weakSelf);
    _mobileLabel = [UILabel new];
    _mobileLabel.font = [UIFont systemFontOfSize:20];
    _mobileLabel.textColor = HEX_COLOR(@"#333333");
    _mobileLabel.text = [YSAccount sharedAccount].mobile;
    [view addSubview:_mobileLabel];
    [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(15);
        make.centerX.equalTo(view);
    }];
    
    _codeCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _codeCell.ys_contentPlaceHolder = @"请输入验证码";
    _codeCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _codeCell.ys_contentTextColor = HEX_COLOR(@"#999999");
    [view addSubview:_codeCell];
    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(weakSelf.mobileLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(45);
    }];
    
    YSValidateButton *validateButton = [[YSValidateButton alloc] initWithSeconds:60];
    [validateButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [validateButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [sender sendCodeToPhoneNumber:[YSAccount sharedAccount].mobile type:4];
    }];
    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
    }];
    _codeCell.ys_accessoryView = validateButton;
    _codeCell.ys_accessoryRightInsets = 10;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [validateButton addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(20);
    }];

    return view;
}

- (UIView *)createPassworkView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    _passWordCell1 = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _passWordCell1.ys_title = @"设置密码";
    _passWordCell1.ys_contentPlaceHolder = @"请输入6位数字密码";
    _passWordCell1.ys_bottomLineHidden = NO;
    _passWordCell1.ys_contentFont = [UIFont systemFontOfSize:14];
    _passWordCell1.ys_textFiled.secureTextEntry = YES;
    [view addSubview:_passWordCell1];
    [_passWordCell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    _passWordCell2 = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _passWordCell2.ys_title = @"确认密码";
    _passWordCell2.ys_contentPlaceHolder = @"请输入6位数字密码";
    _passWordCell2.ys_bottomLineHidden = NO;
    _passWordCell2.ys_contentFont = [UIFont systemFontOfSize:14];
    _passWordCell2.ys_textFiled.secureTextEntry = YES;
    [view addSubview:_passWordCell2];
    [_passWordCell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordCell1.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    button.space = 10;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button setTitle:@"为了您的资金安全,此密码仅用于用户余额支付" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordCell2.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
    
    return view;
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
