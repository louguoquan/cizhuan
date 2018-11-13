//
//  JJCoinInView.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCoinInView.h"

@interface JJCoinInView ()

@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIImageView *addressImageView;
//@property (nonatomic,strong)UILabel *addressName;
@property (nonatomic,strong)UILabel *fuzhiLabel;
@property (nonatomic,strong)UILabel *chaxunLabel;


@property (nonatomic,strong)JJWalletModel *model;

@end

@implementation JJCoinInView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor = HEX_COLOR(@"#F8F8F8");
    
    UIView *iconBgView = [[UIView alloc]init];
    iconBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:iconBgView];
    
    [iconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(30);
        
    }];
    
    [iconBgView addSubview:self.addressImageView];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconBgView);
        make.top.equalTo(iconBgView).offset(10);
        make.width.height.mas_offset(80);
        make.bottom.equalTo(iconBgView).offset(-10);
    }];
    
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = HEX_COLOR(@"#333333");
    label1.text = @"充值地址";
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(iconBgView.mas_bottom).offset(20);
        make.height.mas_offset(20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = GoldColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(1);
        make.top.equalTo(label1.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.greaterThanOrEqualTo(@15);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    
    [self addSubview:self.fuzhiLabel];
    [self.fuzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    self.chaxunLabel.hidden = YES;
    [self addSubview:self.chaxunLabel];
    [self.chaxunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fuzhiLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.fuzhiLabel.userInteractionEnabled = YES;
    [self.fuzhiLabel addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    self.chaxunLabel.userInteractionEnabled = YES;
    [self.chaxunLabel addGestureRecognizer:tap1];
    
    
    
    //    [iconBgView addSubview:self.addressName];
    //    [self.addressName mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(iconBgView);
    //        make.top.equalTo(self.addressImageView.mas_bottom).offset(5);
    //        make.height.mas_offset(15);
    //
    //    }];
    
    
    
    
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        pBoard.string = self.model.walletAddress;
        [MBProgressHUD showText:@"复制地址成功" toContainer:[UIApplication sharedApplication].keyWindow];
        
    }
    
}





- (void)tap1:(UITapGestureRecognizer *)tap{
    
    if (self.jjRefreshAccount) {
        self.jjRefreshAccount();
    }
    
    
}

- (void)setUpModel:(JJWalletModel *)model
{
    self.model = model;
    self.addressLabel.text = model.walletAddress;
    self.addressLabel.numberOfLines = 0;
    [self.addressLabel sizeToFit];
    
    [self.addressImageView sd_setImageWithURL:[NSURL URLWithString:model.addressUrl] placeholderImage:[UIImage imageNamed:@"eth"]];
    //    self.addressName.text = [NSString stringWithFormat:@"%@官方钱包",model.coinCode];
    
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
    }
    return _fuzhiLabel;
}

- (UILabel *)chaxunLabel
{
    if (!_chaxunLabel) {
        _chaxunLabel = [[UILabel alloc]init];
        _chaxunLabel.font = [UIFont systemFontOfSize:14];
        _chaxunLabel.textColor = HEX_COLOR(@"#333333");
        _chaxunLabel.text = @"刷新账户";
        _chaxunLabel.backgroundColor = HEX_COLOR(@"#ffffff");
        _chaxunLabel.layer.cornerRadius = 4.0f;
        _chaxunLabel.layer.masksToBounds = YES;
        _chaxunLabel.layer.borderColor = HEX_COLOR(@"#333333").CGColor;
        _chaxunLabel.layer.borderWidth = 1.0f;
        _chaxunLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _chaxunLabel;
}



//- (UILabel *)addressName
//{
//    if (!_addressName) {
//        _addressName = [[UILabel alloc]init];
//        _addressName.font = [UIFont systemFontOfSize:14];
//        _addressName.textColor = HEX_COLOR(@"#333333");
//    }
//    return _addressName;
//}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _addressLabel;
}
- (UIImageView *)addressImageView
{
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc]init];
    }
    return _addressImageView;
}


@end
