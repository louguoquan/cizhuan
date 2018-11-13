//
//  YSWalletViewController.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSWalletViewController.h"
#import "YSRechargeViewController.h"
#import "YSPaymentSettingsViewController.h"
#import "YSBillViewController.h"
#import "YSWithDrawController.h"
#import "YSButton.h"

@interface YSWalletViewController ()

@property (nonatomic, strong) UILabel   *amountLabel;
@property (nonatomic, strong) UILabel   *rewardlabel;

@end

@implementation YSWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的钱包";

    [self initSubviews];
    [self fetchJiFen];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)fetchJiFen
{
    [YSAccountService fetchUserInfoWithCompletion:^(id result, id error) {
        
        NSString *header = @"账户余额 : ";
        NSString *total = [NSString stringWithFormat:@"%@￥%.2f", header, [YSAccount sharedAccount].amount];
        
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:total];
        [att addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, header.length)];
        _amountLabel.attributedText = att;
        
        NSString *header1 = @"分润金额 : ";
        NSString *total1 = [NSString stringWithFormat:@"%@￥%.2f", header1, [YSAccount sharedAccount].reward];
        
        NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc]initWithString:total1];
        [att1 addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, header.length)];
        _rewardlabel.attributedText = att1;
        
//        _amountLabel.text = [NSString stringWithFormat:@"￥%.2f", [YSAccount sharedAccount].amount];
//        _amountLabel.text = [NSString stringWithFormat:@"%.2f", [YSAccount sharedAccount].amount];

    }];
}

- (void)initSubviews {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"账单" style:UIBarButtonItemStylePlain target:self action:@selector(checkBill)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    WS(weakSelf);
    UIImageView *headerView = [self createHeaderView];
    [self.containerView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.with.equalTo(weakSelf.containerView);
        make.height.mas_equalTo(headerView.mas_width).multipliedBy(240 / 750.0);
    }];
    
    YSCellView *cell1 = [self createCellForTitle:@"立即充值" image:@"recharge"];
    [cell1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf.navigationController pushViewController:[YSRechargeViewController new] animated:YES];
    }];
    [self.containerView addSubview:cell1];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    YSCellView *cell2 = [self createCellForTitle:@"支付密码设置" image:@"password"];
    [cell2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [weakSelf.navigationController pushViewController:[YSPaymentSettingsViewController new] animated:YES];
    }];
    [self.containerView addSubview:cell2];
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell1.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    button.space = 10;
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [button setTitle:@"为了您的资金安全,使用余额前请先设置支付密码" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"notice"] forState:UIControlStateNormal];
    [self.containerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell2.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
}

- (void)checkBill {
    
    YSBillViewController *vc = [YSBillViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - view

- (UIImageView *)createHeaderView {
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"wallet_bg"];
    imageView.userInteractionEnabled = YES;
    
    _amountLabel = [UILabel new];
    _amountLabel.textColor = [UIColor whiteColor];
    _amountLabel.textAlignment = NSTextAlignmentCenter;
    _amountLabel.font = [UIFont boldSystemFontOfSize:30];
    [imageView addSubview:_amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.offset(20);
    }];
    
    _rewardlabel = [UILabel new];
    _rewardlabel.userInteractionEnabled = YES;
    _rewardlabel.textColor = [UIColor whiteColor];
    _rewardlabel.textAlignment = NSTextAlignmentCenter;
    _rewardlabel.font = [UIFont boldSystemFontOfSize:26];
    [imageView addSubview:_rewardlabel];
    [_rewardlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView).offset(-20);
        make.bottom.offset(-20);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reward:)];
    [_rewardlabel addGestureRecognizer:tap];
    
    UIButton *cashOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashOut setTitle:@"提现" forState:0];
    [cashOut setTitleColor:[UIColor whiteColor] forState:0];
    cashOut.titleLabel.font = [UIFont systemFontOfSize:15];
    cashOut.layer.masksToBounds = YES;
    cashOut.layer.cornerRadius = 5.f;
    cashOut.layer.borderWidth = 1.f;
    cashOut.layer.borderColor = [UIColor whiteColor].CGColor;
    [cashOut addTarget:self action:@selector(cashout:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:cashOut];
    [cashOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_rewardlabel);
        make.left.mas_equalTo(_rewardlabel.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
//    UILabel *label = [UILabel new];
//    label.font = [UIFont systemFontOfSize:15];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"账户余额";
//    label.textColor = [UIColor whiteColor];
//    [imageView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.offset(-20);
//        make.centerX.equalTo(imageView);
//        make.right.mas_equalTo(_amountLabel.mas_left).offset(-10);
//        make.centerY.mas_equalTo(_amountLabel);
//
//    }];
    
    return imageView;
}

- (YSCellView *)createCellForTitle:(NSString *)title image:(NSString *)imageName {
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = NO;
    cell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    cell.ys_leftImage = [UIImage imageNamed:imageName];
    cell.ys_text = title;
    cell.ys_contentFont = [UIFont systemFontOfSize:15];
    cell.ys_contentTextColor = HEX_COLOR(@"#666666");
    
    return cell;
}

- (void)reward:(UITapGestureRecognizer *)tap
{
    NSLog(@"分润明细");
}

- (void)cashout:(UIButton *)button
{
    NSLog(@"提现");
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请问是否提现全部分润" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:cancel];
//    [alert addAction:confirm];
//    [self presentViewController:alert animated:YES completion:nil];
    
    [self.navigationController pushViewController:[YSWithDrawController new] animated:YES];
    
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
