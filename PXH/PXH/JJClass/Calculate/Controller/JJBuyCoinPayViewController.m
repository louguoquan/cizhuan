//
//  JJBuyCoinPayViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinPayViewController.h"
#import "JJBuyCoinHeadView.h"
#import "JJBuyCoinFinishViewController.h"


@interface JJBuyCoinPayViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UILabel *countLabel;
@property (nonatomic, strong)UILabel *payLabel;
@property (nonatomic, strong)YSCellView *countCell;
@property (nonatomic, strong)UIView *countBgView;
@property (nonatomic, strong)UIImageView *QrCodeImageView;
@property (nonatomic, strong)UILabel *QrCodeNameLabel;
@property (nonatomic, strong)UILabel *QrCodeDesLabel;

@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *fuzhiLabel;

@property (nonatomic, strong)UILabel *desLabel;

@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation JJBuyCoinPayViewController


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
    vc.type = 1;
    [self.containerView addSubview:vc];
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        make.height.mas_offset(140);
    }];
    
  
    [self.containerView addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(vc.mas_bottom).offset(30);
        make.height.mas_offset(20);
    }];
    
    [self.containerView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.payLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.containerView addSubview:self.countBgView];
    [self.countBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.top.equalTo(self.countLabel.mas_bottom).offset(15);
    }];
    
    
    [self.countBgView addSubview:self.QrCodeImageView];
    [self.QrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.countBgView).offset(50);
        make.width.height.mas_offset(90);
        make.centerY.equalTo(self.countBgView);
        make.top.equalTo(self.countBgView).offset(15);
        make.bottom.equalTo(self.countBgView).offset(-15);
    }];
    
    [self.countBgView addSubview:self.QrCodeNameLabel];
    [self.QrCodeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.QrCodeImageView.mas_left).offset(-15);
        make.centerY.equalTo(self.QrCodeImageView).offset(-14);
        make.height.mas_offset(28);
    }];
    
    [self.countBgView addSubview:self.QrCodeDesLabel];
    [self.QrCodeDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.QrCodeImageView.mas_left).offset(-15);
        make.top.equalTo(self.QrCodeNameLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    
    

    [self.containerView addSubview:self.addressLabel];
    [self.containerView addSubview:self.fuzhiLabel];
    [self.containerView addSubview:self.desLabel];
    
   
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countBgView.mas_bottom).offset(20);
        make.left.right.equalTo(self.countBgView);
        make.height.greaterThanOrEqualTo(@20);
    }];
 
    
    [self.fuzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.countBgView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];

    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fuzhiLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.countBgView);
        make.height.greaterThanOrEqualTo(@20);
    }];

    
    
    [self.containerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(40);
        make.width.mas_offset(kScreenWidth-20);
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.desLabel.mas_bottom).offset(40);
        make.bottom.equalTo(self.containerView).offset(-30);
    }];
    

    
    
//    NSString *string1 = [NSString stringWithFormat:@"认购%@%@",@"1000",CoinNameChange];
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
//    [string addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(2, string1.length-2-CoinNameChange.length)];
//    self.payLabel.attributedText = string;
    
//    NSString *string2 = [NSString stringWithFormat:@"支付%@%@",@"1.0",PayCoinNameChange];
//
//    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:string2];
//    [string3 addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(2, string2.length-2-PayCoinNameChange.length)];
//    self.countLabel.attributedText = string3;

    
    
    
//    self.QrCodeImageView.backgroundColor = [UIColor redColor];
    self.QrCodeNameLabel.text = @"ETH";
    self.QrCodeDesLabel.text = @"官方以太坊钱包";
    
//
//    self.addressLabel.text = @"jhdsfajhsdjfjsahjdhfjasdhfjshdfjhsdjkfhjashdjfhsadfhjasdhfjadsh";
//    self.addressLabel.numberOfLines = 0;
//    [self.addressLabel sizeToFit];
    
    self.desLabel.text = @"确认打款后，点击申请审核，我们将尽快审核您的兑换订单，并兑换购信息反馈给您。";
    self.desLabel.numberOfLines = 0;
    [self.desLabel sizeToFit];
}

- (void)setModel:(JJBuyModel *)model{
    
    _model = model;
    
    self.addressLabel.text = model.ethAddress;
    
    [self.QrCodeImageView sd_setImageWithURL:[NSURL URLWithString:model.ethQRURL]];
    
    NSString *string1 = [NSString stringWithFormat:@"兑换%@%@",model.order.buyNumber,CoinNameChange];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:string1];
    [string addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(2, string1.length-2-CoinNameChange.length)];
    self.payLabel.attributedText = string;
    
    NSString *string2 = [NSString stringWithFormat:@"支付%@%@",model.order.payPrice,PayCoinNameChange];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:string2];
    [string3 addAttribute:NSForegroundColorAttributeName value:GoldColor range:NSMakeRange(2, string2.length-2-PayCoinNameChange.length)];
    self.countLabel.attributedText = string3;
    
    
}


- (void)copyString{
    
    
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        pBoard.string = self.model.ethAddress;
        [MBProgressHUD showText:@"复制地址成功" toContainer:self.view];
        
    }
    
    
}

- (void)back
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

- (void)submit:(UIButton *)btn{
    
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"是否确认兑换" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
        
        
         [MBProgressHUD showLoadingToContainer:self.view];
        
        [JJCalculateService JJMobileMemberOrderVerifyPageWithID:self.model.order.ID Completion:^(id result, id error) {
            
            [MBProgressHUD dismissForContainer:self.view];
            JJBuyCoinFinishViewController *vc = [[JJBuyCoinFinishViewController alloc]init];
//            vc.email = result[@"result"][@"email"];
            vc.model = self.model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    
        
    })]];
    [alertView show];

    
}


- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:20];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}

- (UILabel *)payLabel
{
    if (!_payLabel) {
        _payLabel = [[UILabel alloc]init];
        _payLabel.font = [UIFont systemFontOfSize:20];
        _payLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _payLabel;
}

- (UILabel *)QrCodeNameLabel
{
    if (!_QrCodeNameLabel) {
        _QrCodeNameLabel = [[UILabel alloc]init];
        _QrCodeNameLabel.font = [UIFont systemFontOfSize:30];
        _QrCodeNameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _QrCodeNameLabel;
}

- (UILabel *)QrCodeDesLabel
{
    if (!_QrCodeDesLabel) {
        _QrCodeDesLabel = [[UILabel alloc]init];
        _QrCodeDesLabel.font = [UIFont systemFontOfSize:15];
        _QrCodeDesLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _QrCodeDesLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _addressLabel;
}

- (UILabel *)fuzhiLabel
{
    if (!_fuzhiLabel) {
        _fuzhiLabel = [[UILabel alloc]init];
        _fuzhiLabel.font = [UIFont systemFontOfSize:14];
        _fuzhiLabel.textColor = HEX_COLOR(@"#333333");
        _fuzhiLabel.text = @"复制地址";
        _fuzhiLabel.backgroundColor = HEX_COLOR(@"#ffffff");
        _fuzhiLabel.layer.cornerRadius = 4.0f;
        _fuzhiLabel.layer.masksToBounds = YES;
        _fuzhiLabel.layer.borderColor = HEX_COLOR(@"#333333").CGColor;
        _fuzhiLabel.layer.borderWidth = 1.0f;
        _fuzhiLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyString)];
        _fuzhiLabel.userInteractionEnabled = YES;
        [_fuzhiLabel addGestureRecognizer:tap];
    }
    return _fuzhiLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _desLabel;
}

- (UIView *)countBgView
{
    if (!_countBgView) {
        _countBgView = [[UIView alloc]init];
        _countBgView.backgroundColor = [UIColor whiteColor];
    }
    return _countBgView;
}







- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitle:@"确认兑换" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        
    }
    return _submitBtn;
}

- (UIImageView *)QrCodeImageView
{
    if (!_QrCodeImageView) {
        _QrCodeImageView = [[UIImageView alloc]init];
        
    }
    return _QrCodeImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
