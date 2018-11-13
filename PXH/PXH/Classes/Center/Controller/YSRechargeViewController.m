//
//  YSRechargeViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRechargeViewController.h"
#import "YSRechargeSuccessViewController.h"

#import "SDPayWayView.h"
#import "YSButton.h"
#import "YSOrderService.h"
#import "YSPayManager.h"

@interface YSRechargeViewController ()

@property (nonatomic, strong) UILabel   *amountLabel;

@property (nonatomic, strong) YSCellView    *priceCell;

@property (nonatomic, strong) SDPayWayView  *payWayView;

@end

@implementation YSRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"充值";
    
    [self initSubviews];
}

- (void)initSubviews {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-60);
    }];
    
    UIView *footerView = [self footerView];
    [self.view addSubview:footerView];
    [self.containerView addSubview:self.amountLabel];
    [self.containerView addSubview:self.priceCell];
    UIView *view = [self createPayWayView];
    [self.containerView addSubview:view];
    
    WS(weakSelf);
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(30);
        make.centerX.equalTo(weakSelf.containerView);
    }];
    
    [self.priceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.amountLabel.mas_bottom).offset(30);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceCell.mas_bottom).offset(10);
        make.left.right.offset(0);
    }];
    
    YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    button.space = 10;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button setTitle:@"充值须知:充值余额不可提现,仅限于购买产品" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
}

- (void)recharge {
    
    if (_priceCell.ys_text.length <= 0 || [_priceCell.ys_text doubleValue] <= 0) {
        [MBProgressHUD showInfoMessage:@"请输入正确地充值金额" toContainer:nil];
        return;
    }
//    if ([YSAccount sharedAccount].isSetPayPwd.integerValue == 0) {
//        [self judgeLoginActionWith:2];
//    } else {
        [MBProgressHUD showLoadingText:@"正在提交订单" toContainer:nil];
        NSInteger payMethod = _payWayView.payWay == SDPayWayAliPay ? 2 : 1;
        [YSOrderService recharge:_priceCell.ys_text payMethod:payMethod completion:^(id result, id error) {
            
            WS(weakSelf);
            [YSPayManager sharedManager].block = ^(YSPayType type, BOOL isSuccess, id error) {
                if (isSuccess) {
                    [weakSelf paySuccess];
                }
            };
            [MBProgressHUD dismissForContainer:nil];
            if (payMethod == 1) {
                [self wechatPay:result];
            }else {
                [self aliPay:result[@"alipayString"]];
            }
        }];
//    }
}

- (void)aliPay:(NSString *)payString {
    
//    // NOTE: 调用支付结果开始支付
//    [[AlipaySDK defaultService] payOrder:payString fromScheme:APP_SCHEME callback:^(NSDictionary *resultDic) {
//        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
//            [self paySuccess];
//        }else {
//            [MBProgressHUD showErrorMessage:resultDic[@"memo"] toContainer:nil];
//        }
//    }];
    
}

- (void)wechatPay:(NSDictionary *)payParameters {
    
    //调起微信支付
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
    
    [MBProgressHUD dismissForContainer:nil];
    [YSAccountService fetchUserInfoWithCompletion:nil];
    
    YSRechargeSuccessViewController *vc = [YSRechargeSuccessViewController new];
    vc.price = _priceCell.ys_text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [SDUtil textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

#pragma mark - view

- (UIView *)footerView {
    
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"立即充值" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerView);
        make.height.mas_equalTo(40);
        make.left.offset(15);
    }];
    
    return footerView;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.font = [UIFont boldSystemFontOfSize:40];
        _amountLabel.textColor = MAIN_COLOR;
        _amountLabel.textAlignment = NSTextAlignmentRight;
        _amountLabel.text = [NSString stringWithFormat:@"%.2f", [YSAccount sharedAccount].amount];
    }
    
    return _amountLabel;
}

- (YSCellView *)priceCell {
    if (!_priceCell) {
        _priceCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _priceCell.backgroundColor = [UIColor whiteColor];
        _priceCell.ys_contentTextAlignment = NSTextAlignmentRight;
        _priceCell.ys_title = @"充值金额";
        _priceCell.ys_contentPlaceHolder = @"请输入要充值的金额";
        _priceCell.ys_titleFont = [UIFont systemFontOfSize:15];
        _priceCell.ys_titleColor = HEX_COLOR(@"#333333");
        _priceCell.ys_contentFont = [UIFont systemFontOfSize:15];
        _priceCell.ys_contentTextColor = HEX_COLOR(@"#333333");
        _priceCell.ys_textFiled.delegate = self;
    }
    return _priceCell;
}

- (UIView *)createPayWayView {
    UIView *view = [UIView new];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#333333");
    label.text = @"充值方式";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lineView = [UILabel new];
    lineView.backgroundColor = LINE_COLOR;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    _payWayView = [[SDPayWayView alloc] initWithTypes:@[@(SDPayWayAliPay), @(SDPayWayWechatPay)]];
    [view addSubview:_payWayView];
    [_payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.bottom.offset(0);
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
