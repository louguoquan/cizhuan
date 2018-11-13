//
//  YSTicketTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTicketTableViewCell.h"

@interface YSTicketTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel       *nameLabel;

@property (nonatomic, strong) UILabel       *timeLabel;

@property (nonatomic, strong) UILabel       *integralLabel;

@property (nonatomic, strong) UIButton  *button;

@end

@implementation YSTicketTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _logo = [UIImageView new];
    [self.contentView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(75);
        make.left.offset(30);
        make.centerY.equalTo(self.contentView);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logo);
        make.left.equalTo(_logo.mas_right).offset(10);
        make.right.offset(-10);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = HEX_COLOR(@"#999999");
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.left.equalTo(_logo.mas_right).offset(10);
        make.right.offset(-10);
    }];
    
    WS(weakSelf);
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = MAIN_COLOR;
    _button.layer.cornerRadius = 2;
    _button.clipsToBounds = YES;
    _button.titleLabel.font = [UIFont systemFontOfSize:14];
    [_button setTitle:@"立即兑换" forState:UIControlStateNormal];
    [_button setTitle:@"已兑换" forState:UIControlStateSelected];

    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_logo);
        make.right.offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    
    _integralLabel = [UILabel new];
    _integralLabel.font = [UIFont systemFontOfSize:15];
    _integralLabel.textColor = MAIN_COLOR;
    [self.contentView addSubview:_integralLabel];
    [_integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_logo);
        make.left.equalTo(_logo.mas_right).offset(10);
        make.right.equalTo(_button.mas_left).offset(-10);
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    self.couponClick(sender.tag, _coupon);
}

- (void)setRow:(NSInteger)row
{
    _row = row;
    _button.tag = row;
}

- (void)setState:(NSInteger)state
{
    _state = state;
    if (_state == 1) {
        _button.userInteractionEnabled = YES;
    } else {
        _button.userInteractionEnabled = NO;
    }
}

- (void)setCoupon:(YSLifeCoupons *)coupon {
    _coupon = coupon;
    [_logo sd_setImageWithURL:[NSURL URLWithString:_coupon.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _coupon.title;
    
    _timeLabel.text = [NSString stringWithFormat:@"有效期至%@", _coupon.endTime];
    
    _integralLabel.text = [NSString stringWithFormat:@"%@积分", _coupon.score];
    
    _button.selected = _coupon.isExchange;
    _button.backgroundColor = _coupon.isExchange == 1 ? [UIColor grayColor] : MAIN_COLOR;
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
