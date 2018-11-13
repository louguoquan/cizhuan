//
//  JJBuyCoinFinishViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinFinishViewController.h"
#import "JJBuyCoinHeadView.h"


@interface JJBuyCoinFinishViewController ()

@property (nonatomic, strong)UIView *countBgView;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UILabel *messageLabel;
@property (nonatomic, strong)UILabel *countLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *orderIdLabel;
@property (nonatomic, strong)UILabel *statusBtnLabel;
@end

@implementation JJBuyCoinFinishViewController

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
    
    [self setUpNav];
    
    self.containerView.backgroundColor = HEX_COLOR(@"#F7F8F9");
    
    JJBuyCoinHeadView *vc = [[JJBuyCoinHeadView alloc]init];
    vc.type = 2;
    [self.containerView addSubview:vc];
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        make.height.mas_offset(140);
    }];
    
    
    [self.containerView addSubview:self.countBgView];
    [self.countBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(vc.mas_bottom).offset(15);
        make.bottom.equalTo(self.containerView);
    }];
    
    [self.countBgView addSubview:self.statusLabel];
    [self.countBgView addSubview:self.messageLabel];
    [self.countBgView addSubview:self.countLabel];
    [self.countBgView addSubview:self.timeLabel];
    [self.countBgView addSubview:self.orderIdLabel];
    [self.countBgView addSubview:self.statusBtnLabel];
    
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countBgView).offset(30);
        make.left.right.equalTo(self.countBgView);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = GoldColor;
    [self.countBgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBgView).offset(10);
        make.right.equalTo(self.countBgView).offset(-10);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(1);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line).offset(20);
        make.width.mas_equalTo(kScreenWidth/2.0f);
        make.height.greaterThanOrEqualTo(@20);
        make.centerX.equalTo(self.countBgView);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(50);
        make.left.right.equalTo(self.countBgView);
        make.height.mas_equalTo(20);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = HEX_COLOR(@"#E6E6E6");
    [self.countBgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.messageLabel);
        make.top.equalTo(self.countLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(20);
        make.left.right.equalTo(self.countBgView);
        make.height.mas_equalTo(20);
    }];
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.countBgView);
        make.height.mas_equalTo(20);
    }];
    
    [self.statusBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderIdLabel.mas_bottom).offset(50);
        make.left.equalTo(self.countBgView).offset(20);
        make.right.equalTo(self.countBgView).offset(-20);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.countBgView).offset(-60);
    }];
    
    

    NSString *string1 = @"兑换状态:审核中";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
    [string addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(5, string1.length-5)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(5, string1.length-5)];
    self.statusLabel.attributedText = string;
    
    
    

    
    
    NSString *string4 = [NSString stringWithFormat:@"请将您的用户名和支付截图发送至官方邮箱%@",self.email];
    NSMutableAttributedString *string5 = [[NSMutableAttributedString alloc] initWithString:string4];
    [string5 addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(4, 8)];
    [string5 addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(19, string4.length-19)];
    self.messageLabel.attributedText = string5;
    self.messageLabel.numberOfLines = 0;
    [self.messageLabel sizeToFit];
    

    
 
    
//    self.timeLabel.text = @"认购时间:1028-10-10 10:10:10";
//    self.orderIdLabel.text = @"订单编号：sadjahdjajdas";
    self.statusBtnLabel.text = @"兑换审核中";
    
    
}

- (void)back
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

- (void)setModel:(JJBuyModel *)model
{
    _model = model;
    self.timeLabel.text = [NSString stringWithFormat:@"认购时间:%@",model.order.ct];
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.order.orderNo];
    
    NSString *string2 = [NSString stringWithFormat:@"兑换%@%@",self.model.order.buyNumber,CoinNameChange];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:string2];
    [string3 addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"ef0022") range:NSMakeRange(2, string2.length-2-CoinNameChange.length)];
    self.countLabel.attributedText = string3;
    
    
}

- (UIView *)countBgView
{
    if (!_countBgView) {
        _countBgView = [[UIView alloc]init];
        _countBgView.backgroundColor = [UIColor whiteColor];
    }
    return _countBgView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:20];
        _statusLabel.textColor = HEX_COLOR(@"#333333");
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = HEX_COLOR(@"#333333");
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:20];
        _countLabel.textColor = HEX_COLOR(@"#333333");
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}

- (UILabel *)orderIdLabel
{
    if (!_orderIdLabel) {
        _orderIdLabel = [[UILabel alloc]init];
        _orderIdLabel.font = [UIFont systemFontOfSize:14];
        _orderIdLabel.textColor = HEX_COLOR(@"#666666");
        _orderIdLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _orderIdLabel;
}

- (UILabel *)statusBtnLabel
{
    if (!_statusBtnLabel) {
        _statusBtnLabel = [[UILabel alloc]init];
        _statusBtnLabel.font = [UIFont systemFontOfSize:18];
        _statusBtnLabel.textColor = GoldColor;
        _statusBtnLabel.layer.cornerRadius = 7.0f;
        _statusBtnLabel.layer.masksToBounds = YES;
        _statusBtnLabel.backgroundColor = HEX_COLOR(@"#F8F8F8");
        _statusBtnLabel.layer.borderColor = GoldColor.CGColor;
        _statusBtnLabel.layer.borderWidth = 1.0f;
        _statusBtnLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusBtnLabel;
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
