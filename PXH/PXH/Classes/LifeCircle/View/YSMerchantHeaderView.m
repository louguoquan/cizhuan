//
//  YSMerchantHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantHeaderView.h"

@interface YSMerchantHeaderView ()

//@property (nonatomic, strong) SDCycleScrollView     *cycleScrollView;

@property (nonatomic, strong) UIImageView   *imageView;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *descLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@end

@implementation YSMerchantHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:nil placeholderImage:kPlaceholderImage];
//    [self addSubview:_cycleScrollView];
//    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.mas_equalTo(kScreenWidth * 750.f / 520.f);
//    }];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(kScreenWidth * 520.f / 750.f);
    }];

    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = HEX_COLOR(@"#999999");
    _descLabel.numberOfLines = 0;
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *iconView = [UIImageView new];
    iconView.image = [UIImage imageNamed:@"life_address"];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(12);
        make.left.offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];

    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(5);
        make.right.offset(-10);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UIImageView *iconView1 = [UIImageView new];
    iconView1.image = [UIImage imageNamed:@"coupon"];
    [self addSubview:iconView1];
    [iconView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.size.mas_equalTo(iconView1.image.size);
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEX_COLOR(@"#666666");
    label.text = @"电子券";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconView1);
        make.left.equalTo(iconView1.mas_right).offset(5);
    }];
    
}

- (void)setShop:(YSLifeMerchants *)shop {
    _shop = shop;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_shop.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _shop.name;
    
    _descLabel.text = _shop.desc;
   
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%@]", _shop.area] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", _shop.address]]];
    _addressLabel.attributedText = string;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
