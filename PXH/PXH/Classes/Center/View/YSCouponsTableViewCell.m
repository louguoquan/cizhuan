//
//  YSCouponsTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponsTableViewCell.h"

@interface YSCouponsTableViewCell ()

@property (nonatomic, strong) UIView   *bgView;

@property (nonatomic, strong) UIImageView   *bgImageView;

@property (nonatomic, strong) UIImageView   *tagImageView;

@property (nonatomic, strong) UILabel   *totalPriceLabel;

@property (nonatomic, strong) UILabel   *rulesLabel;

@property (nonatomic, strong) UILabel   *sourceLabel;

@property (nonatomic, strong) UILabel   *timeLabel;

@end

@implementation YSCouponsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    
    _bgView = [UIView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(15);
        make.right.offset(-10);
    }];
    
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageNamed:@"coupons_bg0"];
    [_bgView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(-5);
        make.width.mas_equalTo(95);
    }];
    
    _totalPriceLabel = [UILabel new];
    _totalPriceLabel.font = [UIFont systemFontOfSize:24];
    _totalPriceLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.centerX.offset(0);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.text = @"优惠券";
    [_bgImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-15);
        make.centerY.offset(15);
        make.centerX.offset(0);
    }];
    
    _sourceLabel = [UILabel new];
    _sourceLabel.font = [UIFont systemFontOfSize:13];
    _sourceLabel.textColor = HEX_COLOR(@"#333333");
    [_bgView addSubview:_sourceLabel];
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgImageView.mas_right).offset(10);
        make.centerY.offset(0);
    }];
    
    _rulesLabel = [UILabel new];
    _rulesLabel.font = [UIFont systemFontOfSize:13];
    _rulesLabel.textColor = HEX_COLOR(@"#333333");
    [_bgView addSubview:_rulesLabel];
    [_rulesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sourceLabel);
        make.bottom.equalTo(_sourceLabel.mas_top).offset(-10);
    }];
    
    
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = HEX_COLOR(@"#999999");
    [_bgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sourceLabel);
        make.top.equalTo(_sourceLabel.mas_bottom).offset(10);
    }];
    
    _tagImageView = [UIImageView new];
    [_bgView addSubview:_tagImageView];
    [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.mas_offset(70.f);
    }];
}

- (void)setCoupons:(YSCoupons *)coupons {
    _coupons = coupons;
    
    NSMutableAttributedString *priceAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", _coupons.money]];
    [priceAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}]];
    _totalPriceLabel.attributedText = priceAttrString;

    _rulesLabel.text = _coupons.title;
//    [NSString stringWithFormat:@"满%.2f减%.2f", _coupons.conditonMoney, _coupons.money];
    _sourceLabel.text = [NSString stringWithFormat:@"来源 : %@", _coupons.from];
#pragma mark - 如果传值为空，则默认显示有效期到2099年
    if (_coupons.endDate == nil) {
        _timeLabel.text = @"有效期至2099-12-31";
    } else {
        _timeLabel.text = [NSString stringWithFormat:@"有效期至%@", _coupons.endDate];
    }
    
    //status 0 未使用 1已使用  2已过期
    
    if (_coupons.status == 0) {
        _bgImageView.image = [UIImage imageNamed:@"coupons_bg1"];

    }else if (_coupons.status == 1) {
        _bgImageView.image = [UIImage imageNamed:@"coupons_bg3"];
        _tagImageView.image = [UIImage imageNamed:@"已使用-1"];
    }else {
        _bgImageView.image = [UIImage imageNamed:@"coupons_bg3"];
        _tagImageView.image = [UIImage imageNamed:@"已过期"];
    }
    
//    状态  0-待使用  1-已使用 2-已过期

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
