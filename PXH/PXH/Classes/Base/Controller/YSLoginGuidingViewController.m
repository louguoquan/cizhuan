//
//  YSLoginGuidingViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLoginGuidingViewController.h"
#import "YSRegisterViewController.h"
#import "YSLoginViewController.h"
#import "YSChangePasswordViewController.h"
#import "YSButton.h"

//#import <UMSocialCore/UMSocialCore.h>
#import "YSAccountService.h"

@interface YSLoginGuidingViewController ()

@end


@implementation YSLoginGuidingViewController

//- (BOOL)prefersNavigationBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    [self setup];
}

- (void)setup {
    
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = [UIImage imageNamed:@"login_bg"];
    [self.containerView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
    }];
    
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = [UIImage imageNamed:@"login_icon"];
    [self.containerView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(100);
        make.size.mas_equalTo(iconImageView.image.size);
    }];
    
    UIImageView *sloganImageView = [UIImageView new];
    sloganImageView.image = [UIImage imageNamed:@"login_slogan"];
    [self.containerView addSubview:sloganImageView];
    [sloganImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(iconImageView.mas_bottom).offset(44);
        make.size.mas_equalTo(sloganImageView.image.size);
    }];
    
    YSButton *pwLoginButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    pwLoginButton.space = 10;
    [pwLoginButton setImage:[UIImage imageNamed:@"login_mobile"] forState:UIControlStateNormal];
    [pwLoginButton jm_setCornerRadius:2 withBackgroundColor:HEX_COLOR(@"#e15352")];
    [pwLoginButton setTitle:@"账号登录" forState:UIControlStateNormal];
    pwLoginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [pwLoginButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        YSLoginViewController *vc = [YSLoginViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.containerView addSubview:pwLoginButton];
    [pwLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sloganImageView.mas_bottom).offset(80);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    YSButton *wxLoginButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    wxLoginButton.space = 10;
    [wxLoginButton setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    [wxLoginButton jm_setCornerRadius:2 withBackgroundColor:HEX_COLOR(@"#e15352")];
    [wxLoginButton setTitle:@"微信登录" forState:UIControlStateNormal];
    wxLoginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [wxLoginButton addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:wxLoginButton];
    [wxLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwLoginButton.mas_bottom).offset(25);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(50);
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxLoginButton.mas_bottom).offset(35);
        make.left.right.equalTo(wxLoginButton);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"OR";
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HEX_COLOR(@"#999999");
    label.font = [UIFont systemFontOfSize:15];
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(lineView);
        make.width.mas_equalTo(75);
    }];
    
    YSButton *registerLoginButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    [registerLoginButton setImage:[UIImage imageNamed:@"login_password"] forState:UIControlStateNormal];
    [registerLoginButton jm_setCornerRadius:2 withBorderColor:HEX_COLOR(@"#e15352") borderWidth:1];
    [registerLoginButton setTitle:@"立即注册" forState:UIControlStateNormal];
    registerLoginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerLoginButton setTitleColor:HEX_COLOR(@"#e15352") forState:UIControlStateNormal];
    [registerLoginButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        YSRegisterViewController *vc = [YSRegisterViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.containerView addSubview:registerLoginButton];
    [registerLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(35);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.mas_equalTo(50);
        make.bottom.offset(-50);
    }];
}

    
- (void)wxLogin {
    
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
//        if (!error && result) {
//            [MBProgressHUD showLoadingText:@"正在登陆" toContainer:nil];
//            UMSocialUserInfoResponse *userInfo = result;
//            [YSAccountService loginServiceType:2
//                                        mobile:nil
//                                      password:nil
//                                          code:nil
//                                      userInfo:userInfo
//                                    completion:^(id result, id error) {
//                                        
//                                        if ([[YSAccount sharedAccount].viewMobile isEqualToString:@""]) {
//                                            [MBProgressHUD dismissForContainer:nil];
//                                            NSLog(@"需要绑定手机号");
//                                            
//                                            YSChangePasswordViewController *vc = [YSChangePasswordViewController new];
//                                            vc.type = 10;
//                                            [self.navigationController pushViewController:vc animated:YES];
//                                        } else {
//                                            [MBProgressHUD showSuccessMessage:@"登录成功" toContainer:nil];
//                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                                [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
//                                            });
//                                        }
//                                    }];
//        }
//    }];
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
