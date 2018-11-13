//
//  YSRefundsDetailViewController.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRefundsDetailViewController.h"
#import "YSWebViewController.h"

#import "YSOrderService.h"
//#import <Meiqia/MQChatViewManager.h>

@interface YSRefundsDetailViewController ()

@property (nonatomic, strong) YSRefundsDetail   *detail;

@property (nonatomic, strong) UILabel   *statusLabel;

@property (nonatomic, strong) YSCellView    *priceCell;

@property (nonatomic, strong) YSCellView    *reasonCell;

@property (nonatomic, strong) YSCellView    *timeCell;

@property (nonatomic, strong) YSCellView    *mobileCell;

@end

@implementation YSRefundsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"退货详情";
    
    [self setup];
    
    [self fetchRefundsDetail];
}

- (void)setup {
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
    }];
    
    UIImageView *iconView = [UIImageView new];
    [iconView setImage:[UIImage imageNamed:@"notice"]];
    [view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconView.image.size);
        make.left.offset(10);
        make.top.offset(10);
    }];
    
    _statusLabel = [UILabel new];
    _statusLabel.font = [UIFont systemFontOfSize:14];
    _statusLabel.textColor = HEX_COLOR(@"#333333");
    _statusLabel.text = @"退货申请正在审核中";
    [view addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(10);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:1 withBorderColor:MAIN_COLOR borderWidth:1];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button setTitle:@"撤销申请" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelRefund) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 jm_setCornerRadius:1 withBorderColor:MAIN_COLOR borderWidth:1];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button1 setTitle:@"联系客服" forState:UIControlStateNormal];
    [button1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        YSWebViewController *vc = [YSWebViewController new];
//        vc.urlString = kCustomerService_URL;
//        vc.title = @"客服";
//        [self.navigationController pushViewController:vc animated:YES];
        
#pragma mark  最简单的集成方法: 全部使用meiqia的,  不做任何自定义UI.
//        MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
//        [chatViewManager setoutgoingDefaultAvatarImage:[UIImage imageNamed:@"meiqia-icon"]];
//        [chatViewManager pushMQChatViewControllerInViewController:self];
//        
        
    }];
    [view addSubview:button1];

//    [@[button, button1] mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(iconView.mas_bottom).offset(20);
//        make.height.mas_equalTo(30);
//        make.bottom.offset(-20);
//    }];
//    [@[button, button1] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:95 tailSpacing:95];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(95);
        make.bottom.offset(-20);
        make.left.offset(60);
    }];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
        make.bottom.offset(-20);
        make.width.mas_equalTo(95);
        make.right.offset(-60);
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(-10);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = HEX_COLOR(@"#333333");
    label1.text = @"售后明细:";
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.mas_equalTo(37);
        make.left.offset(10);
    }];
    
    _priceCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _priceCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _priceCell.ys_titleColor = HEX_COLOR(@"#999999");
    _priceCell.ys_title = @"退款金额:";
    _priceCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _priceCell.ys_contentTextColor = HEX_COLOR(@"#888888");
    _priceCell.ys_bottomLineHidden = NO;
    [view1 addSubview:_priceCell];
    [_priceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.height.mas_equalTo(35).priority(751);
        make.left.right.offset(0);
    }];
    
    _reasonCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _reasonCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _reasonCell.ys_titleColor = HEX_COLOR(@"#999999");
    _reasonCell.ys_title = @"退款原因:";
    _reasonCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _reasonCell.ys_contentTextColor = HEX_COLOR(@"#888888");
    _reasonCell.ys_bottomLineHidden = NO;
    [view1 addSubview:_reasonCell];
    [_reasonCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceCell.mas_bottom);
        make.height.mas_equalTo(35).priority(751);
        make.left.right.offset(0);
    }];

    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _mobileCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_titleColor = HEX_COLOR(@"#999999");
    _mobileCell.ys_title = @"联系方式:";
    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_contentTextColor = HEX_COLOR(@"#888888");
    _mobileCell.ys_bottomLineHidden = NO;
    [view1 addSubview:_mobileCell];
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_reasonCell.mas_bottom);
        make.height.mas_equalTo(35);
        make.left.right.offset(0);
    }];


    _timeCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _timeCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _timeCell.ys_titleColor = HEX_COLOR(@"#999999");
    _timeCell.ys_title = @"申请时间:";
    _timeCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _timeCell.ys_contentTextColor = HEX_COLOR(@"#888888");
    _timeCell.ys_bottomLineHidden = NO;
    [view1 addSubview:_timeCell];
    [_timeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileCell.mas_bottom);
        make.height.mas_equalTo(35);
        make.left.right.offset(0);
        make.bottom.offset(0);
    }];
    

}

- (void)updateGui {
    _statusLabel.text = [YSRefundsDetail statusStringWithStatus:_detail.status];
    _priceCell.ys_text = [NSString stringWithFormat:@"￥%.2f", _detail.amount];
    
    _reasonCell.ys_text = _detail.reason;
    
    _timeCell.ys_text = _detail.time;
    
    _mobileCell.ys_text = _detail.mobile;
    
    if (_detail.type == 1) {
        //退款
        _priceCell.ys_title = @"退款金额:";
        _reasonCell.ys_title = @"退款原因:";
        self.navigationItem.title = @"退款详情";
    }else {
        //退货
        _priceCell.ys_title = @"退货金额:";
        _reasonCell.ys_title = @"退货原因:";
        self.navigationItem.title = @"退货详情";
    }
    
}
//撤销申请
- (void)cancelRefund {
    [MBProgressHUD showLoadingText:@"撤销申请中" toContainer:nil];
    [YSOrderService fetchOrderCancelRefunds:_detail.customerServiceId completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"撤销成功" toContainer:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)fetchRefundsDetail {
    
    [MBProgressHUD showLoadingText:@"正在获取售后详情" toContainer:nil];
    [YSOrderService fetchOrderRefundsDetail:_order.orderId completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        _detail = result;
        
        [self updateGui];
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
