//
//  YSChangePasswordViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSChangePasswordViewController.h"

#import "YSValidateButton.h"

#import <YYText.h>

#import "YSWebViewController.h"

@interface YSChangePasswordViewController ()

@property (nonatomic, strong) YSCellView    *mobileCell;

@property (nonatomic, strong) YSCellView    *codeCell;

@property (nonatomic, strong) YSCellView    *pswCell;

@property (nonatomic, strong) UIButton      *protocolButton;

@end

@implementation YSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = _type == 1 ? @"忘记密码" : _type == 10 ? @"绑定手机号" : (_type == 2 ? @"修改登录密码" : @"修改支付密码");
    
    [self initSubviews];
}

- (void)initSubviews {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    NSInteger YSCellViewType;
    if (_type == 1 || _type == 10) {
        YSCellViewType = YSCellViewTypeTextField;
    } else {
        YSCellViewType = YSCellViewTypeLabel;
    }
    
    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewType];
    _mobileCell.ys_title = @"手机号";
    _mobileCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_titleColor = HEX_COLOR(@"#666666");
    _mobileCell.ys_titleWidth = 15 * 3;
    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:14];
    
    if (_type == 1 || _type == 10) {
        _mobileCell.ys_contentPlaceHolder = @"请输入手机号";
    } else {
        _mobileCell.ys_text = [YSAccount sharedAccount].mobile;
    }
    
    _mobileCell.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:_mobileCell];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    _codeCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _codeCell.ys_title = @"验证码";
    _codeCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _codeCell.ys_titleColor = HEX_COLOR(@"#666666");
    _codeCell.ys_titleWidth = 15 * 3;
    _codeCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _codeCell.ys_contentPlaceHolder = @"请输入验证码";
    _codeCell.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:_codeCell];
    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileCell.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    YSValidateButton *validateButton = [[YSValidateButton alloc] initWithSeconds:60];
    validateButton.backgroundColor = MAIN_COLOR;
    [validateButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [sender sendCodeToPhoneNumber:_mobileCell.ys_text type:(_type == 3 || _type == 10)? 4 : 3];
    }];
    [validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
    }];
    _codeCell.ys_accessoryView = validateButton;
    _codeCell.ys_accessoryRightInsets = 10;
    
    _pswCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _pswCell.ys_title = @"密码";
    _pswCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _pswCell.ys_titleColor = HEX_COLOR(@"#666666");
    _pswCell.ys_titleWidth = 15 * 3;
    _pswCell.ys_contentFont = [UIFont systemFontOfSize:14];
    if (_type == 3) {
        _pswCell.ys_contentPlaceHolder = @"请设置6位数字密码";
    } else {
        _pswCell.ys_contentPlaceHolder = @"请输入密码";
    }
    _pswCell.ys_textFiled.secureTextEntry = YES;
    _pswCell.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:_pswCell];
    [_pswCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeCell.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.height.mas_equalTo(47);
    }];
    
    if (_type == 10) {
        
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _protocolButton.userInteractionEnabled = YES;
        [_protocolButton setImage:[UIImage imageNamed:@"choose-normal"] forState:UIControlStateNormal];
        [_protocolButton setImage:[UIImage imageNamed:@"choose-pressed"] forState:UIControlStateSelected];
        [_protocolButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            sender.selected = !sender.selected;
        }];
        [self.containerView addSubview:_protocolButton];
        [_protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_pswCell.mas_bottom).offset(10);
            make.left.offset(15);
            make.height.width.mas_equalTo(20);
        }];

        NSString *registerStr = @"绑定即代表同意";
        UIFont *registerFont = [UIFont systemFontOfSize:12];
        CGSize labelSize = [registerStr boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:registerFont} context:nil].size;
        YYLabel *label = [self labelWith:registerStr font:registerFont type:1];
        [self.containerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(_protocolButton).offset(2);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(labelSize.width + 10);
            make.top.equalTo(_protocolButton).offset(2);
            make.left.equalTo(_protocolButton.mas_right).offset(10);
        }];
        
        NSString *str1 = @"《用户协议》";
        CGSize label1Size = [str1 boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:registerFont} context:nil].size;
        YYLabel *label1 = [self labelWith:str1 font:registerFont type:2];
        [self.containerView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_protocolButton).offset(2);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(label1Size.width + 3);
            make.left.equalTo(label.mas_right);
        }];
        
        UITapGestureRecognizer *userTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTap)];
        [label1 addGestureRecognizer:userTap];
        
        NSString *str2 = @"和";
        CGSize label2Size = [str2 boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:registerFont} context:nil].size;
        YYLabel *label2 = [self labelWith:str2 font:registerFont type:1];
        [self.containerView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_protocolButton).offset(2);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(label2Size.width);
            make.left.equalTo(label1.mas_right);
        }];
        
        NSString *str3 = @"《会员协议》";
        CGSize label3Size = [str1 boundingRectWithSize:CGSizeMake(ScreenWidth, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:registerFont} context:nil].size;
        YYLabel *label3 = [self labelWith:str3 font:registerFont type:2];
        [self.containerView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_protocolButton).offset(2);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(label3Size.width + 3);
            make.left.equalTo(label2.mas_right);
        }];
        
        UITapGestureRecognizer *vipTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vipTap)];
        [label3 addGestureRecognizer:vipTap];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (_type != 10) {
            make.top.equalTo(_pswCell.mas_bottom).offset(50);
//        } else {
//            make.top.equalTo(label.mas_bottom).offset(30);
//        }
        
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(45);
        make.bottom.offset(-20);
    }];
    
}

- (void)userTap
{
    YSWebViewController *vc = [YSWebViewController new];
    vc.urlString = @"http://mobile.zjpxny.com/product/html?code=register";
    vc.title = @"用户协议";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)vipTap
{
    YSWebViewController *vc = [YSWebViewController new];
    vc.urlString = @"http://mobile.zjpxny.com/product/html?code=upgrade";
    vc.title = @"会员协议";
    [self.navigationController pushViewController:vc animated:YES];
}

//type 1为普通  2为可点击
- (YYLabel *)labelWith:(NSString *)text font:(UIFont *)font type:(NSInteger)type
{
    YYLabel *label = [YYLabel new];
    label.font = font;
    label.text = text;
    if (type == 1) {
        label.textColor = HEX_COLOR(@"#888888");
    } else {
        label.textColor = MAIN_COLOR;
    }
    label.textAlignment = NSTextAlignmentLeft;
    label.userInteractionEnabled = YES;
    return label;
}

- (void)confirm {
    
    [self.view endEditing:YES];
    if (_mobileCell.ys_text.length <= 0 || _codeCell.ys_text.length <= 0 || _pswCell.ys_text.length <= 0) {
        [MBProgressHUD showInfoMessage:@"请补全信息" toContainer:nil];
        return;
    }
    
    if (_type == 2) {
        if (_pswCell.ys_text.length < 6 || _pswCell.ys_text.length > 10) {
            [MBProgressHUD showInfoMessage:@"请输入6到10位登录密码" toContainer:nil];
            return;
        }
    }
    if (_type == 10) {
        if (![YSAccountService isMobile:_mobileCell.ys_text]) {
            [MBProgressHUD showInfoMessage:@"请输入正确的手机号" toContainer:nil];
            return;
        }
    }
    if (_type == 3) {
        if (_pswCell.ys_text.length != 6) {
            [MBProgressHUD showInfoMessage:@"请输入6位数字密码" toContainer:nil];
            return;
        }
    }
    
    
    if (_type == 10) {
        if (!_protocolButton.selected) {
            [MBProgressHUD showInfoMessage:@"请阅读并同意会员协议" toContainer:nil];
            return;
        }
    }
    
    
    
//    NSString *url = _type == 1 ? kResetPsw_URL : (_type == 2 ? kChangePsw_URL : kChangePayPsw_URL);
    NSString *url = _type == 1 ? kResetPsw_URL : _type == 10 ? kphone_URL : (_type == 2 ? kChangePsw_URL : kChangePayPsw_URL);
    [MBProgressHUD showLoadingText:@"" toContainer:nil];
    [YSAccountService updatePasswordWithUrl:url mobile:_mobileCell.ys_text code:_codeCell.ys_text password:_pswCell.ys_text completion:^(id result, id error) {
        if (_type == 1) {
            [MBProgressHUD showSuccessMessage:@"修改成功,请重新登录" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if (_type == 2) {
            [MBProgressHUD showSuccessMessage:@"修改成功,请重新登录" toContainer:nil];
            [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeLogin];
        } else if (_type == 10) {
            [MBProgressHUD showSuccessMessage:@"绑定成功" toContainer:nil];
            [YSAccount sharedAccount].mobile = result[@"mobile"];
            [YSAccount sharedAccount].viewMobile = result[@"mobile"];
            [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
        }else {
            [YSAccount sharedAccount].isSetPayPwd = @"1";
            [MBProgressHUD showSuccessMessage:@"修改成功" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
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
