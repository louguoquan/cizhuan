//
//  YSPayViewController.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPayViewController.h"
#import "YSConfirmOrderViewController.h"
#import "YSPaySuccessViewController.h"

#import "YSPasswordPayView.h"
#import "SDPayWayView.h"
//#import "YSPayModel.h"

#import "YSOrderService.h"
#import "YSPayManager.h"

@interface YSPayViewController ()

@property (nonatomic, strong) SDPayWayView  *payWayView;

@end

@implementation YSPayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self creatLeftButton];
    self.navigationItem.title = @"确认支付";
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if ([viewControllers[viewControllers.count - 2] isKindOfClass:[YSConfirmOrderViewController class]]) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:viewControllers];
        [array removeObjectAtIndex:array.count - 2];
        [self.navigationController setViewControllers:array animated:YES];
    }
    
    [self initSubviews];
}

- (void)creatLeftButton
{
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(0, 0, 60, 40);
    returnButton.width = -20;
    [returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:returnButton];
}

- (void)returnAction
{
    [self judgeLoginActionWith:6];
}

- (void)initSubviews {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *label = [UILabel new];
    label.text = @"实付金额:";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#666666");
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
    }];
    
    UILabel *totalLabel = [UILabel new];
    totalLabel.font = [UIFont boldSystemFontOfSize:35.f];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.textColor = MAIN_COLOR;
    totalLabel.text = [NSString stringWithFormat:@"￥%.2f", _totalPrice];
    [self.containerView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(label.mas_bottom).offset(15);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalLabel.mas_bottom).offset(25);
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = HEX_COLOR(@"#666666");
    label1.text = @"选择支付方式";
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.offset(0);
    }];
    
    _payWayView = [[SDPayWayView alloc] initWithTypes:@[@(SDPayWayBalancePay), @(SDPayWayAliPay), @(SDPayWayWechatPay)]];
    [self.containerView addSubview:_payWayView];
    [_payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-55);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(55);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:2 withBackgroundColor:MAIN_COLOR];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"确认支付" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
        make.left.offset(15);
        make.height.mas_equalTo(44);
    }];
}

- (void)payAction {
    
    if (_totalPrice <= 0) {
        [self preparePay:nil];
    }else {
        if (_payWayView.payWay == SDPayWayBalancePay) {
            CGFloat userCash = [YSAccount sharedAccount].amount;
            if (_totalPrice > userCash) {
                [self judgeLoginActionWith:3];
            } else {
                if ([[YSAccount sharedAccount].isSetPayPwd integerValue] == 0) {
                    [self judgeLoginActionWith:2];
                } else {
                    [[[YSPasswordPayView alloc] initWithCompletion:^(id result, id error) {
                        [self preparePay:result];
                    }] show];
                }
            }
        }else {
            [self preparePay:nil];
        }
    }
}

- (void)preparePay:(NSString *)password {

    [MBProgressHUD showLoadingText:@"准备支付" toContainer:self.view];
    NSInteger payMethod = _payWayView.payWay == SDPayWayAliPay ? 3 : (_payWayView.payWay == SDPayWayWechatPay ? 2 : 1);
    WS(weakSelf);
    [YSOrderService orderPay:_orderId payMethod:payMethod payPassword:password completion:^(id result, SDError *error) {
    
        if (!error) {
            [MBProgressHUD dismissForContainer:self.view];

            if (_totalPrice <= 0) {
                [self paySuccess];
            }else {
                [YSPayManager sharedManager].block = ^(YSPayType type, BOOL isSuccess, id error) {
                    if (isSuccess) {
                        [weakSelf paySuccess];
                    }
                };
                
                if (payMethod == 1) {
                    [self paySuccess];
                    
                    [YSAccountService fetchUserInfoWithCompletion:nil];
                    
                }else if (payMethod == 2) {
                    [self wechatPay:result];
                }else {
                    [self aliPay:result[@"alipayString"]];
                }
            }
        } else {
            
            [MBProgressHUD showErrorMessage:error.errorMessage toContainer:self.view];
            
            
        }
//        alipayString = "";
//        appId = "";
//        nonceStr = "";
//        "package_" = "";
//        partnerid = "";
//        paySign = "";
//        prepayId = "";
//        signType = "";
//        timeStamp = "";

    }];
}


- (void)aliPay:(NSString *)payString {

    // NOTE: 调用支付结果开始支付
//    [[AlipaySDK defaultService] payOrder:payString fromScheme:APP_SCHEME callback:^(NSDictionary *resultDic) {
//        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
//            [self paySuccess];
//        }else {
//            [MBProgressHUD showErrorMessage:resultDic[@"memo"] toContainer:nil];
//        }
//    }];

}

- (void)wechatPay:(NSDictionary *)payParameters {
    
//    //调起微信支付
//    PayReq* req             = [[PayReq alloc] init];
//    req.openID              = payParameters[@"appId"];
//    req.partnerId           = kWechatPartnerID;
//    req.prepayId            = payParameters[@"prepayId"];
//    req.nonceStr            = payParameters[@"nonceStr"];
//    req.timeStamp           = [payParameters[@"timeStamp"] intValue];
//    req.package             = @"Sign=WXPay";
//    req.sign                = payParameters[@"paySign"];
//    [WXApi sendReq:req];
}

- (void)paySuccess {
    YSPaySuccessViewController *vc = [YSPaySuccessViewController new];
    vc.orderId = _orderId;
    [self.navigationController pushViewController:vc animated:YES];

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
