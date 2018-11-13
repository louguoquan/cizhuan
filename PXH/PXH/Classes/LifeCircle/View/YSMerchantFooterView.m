
//
//  YSMerchantFooterView.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantFooterView.h"
#import "YSPhoneView.h"

@interface YSMerchantFooterView ()

@property (nonatomic, strong) UILabel   *timeLabel;

@end

@implementation YSMerchantFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
//        [self initSubviews];
    }
    return self;
}

- (void)initSubviewsWith:(YSLifeMerchants *)dic {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UIImageView *iconView = [UIImageView new];
    iconView.image = [UIImage imageNamed:@"rule"];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.size.mas_equalTo(iconView.image.size);
        make.left.offset(10);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEX_COLOR(@"#666666");
    label.text = @"兑换须知";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(5);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = LINE_COLOR;
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];

 
    UILabel *label1 = [UILabel new];
    label1.text = @"使用规则:";
    label1.textColor = MAIN_COLOR;
    label1.font = [UIFont systemFontOfSize:14];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.left.offset(30);
    }];
    
    _rulesLabel = [UILabel new];
//    _rulesLabel.text = @"有效期";
    _rulesLabel.textColor = HEX_COLOR(@"#666666");
    _rulesLabel.font = [UIFont systemFontOfSize:13];
    _rulesLabel.numberOfLines = 0;
    [self addSubview:_rulesLabel];
    [_rulesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.left.offset(30);
        make.right.offset(-10);
//        make.bottom.offset(0);
    }];
    
        
    YSPhoneView *phoneView = [YSPhoneView new];
    phoneView.shopDic = dic;
    [self addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rulesLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)setShopDic:(YSLifeMerchants *)shopDic
{
    [self initSubviewsWith:shopDic];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
