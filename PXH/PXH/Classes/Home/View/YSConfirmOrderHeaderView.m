//
//  YSConfirmOrderHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSConfirmOrderHeaderView.h"
#import "YSButton.h"
@interface YSConfirmOrderHeaderView ()
@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@property (nonatomic, strong) YSButton  *button;
@end

@implementation YSConfirmOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    UILabel *label = [UILabel new];
    label.text = @"收货地址";
    label.textColor = HEX_COLOR(@"#333333");
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.offset(10);
        make.top.offset(0);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *addressView = [UIView new];
    [self addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    _button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    _button.space = 10;
    _button.backgroundColor = MAIN_COLOR;
    [_button setTitle:@"新增地址" forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    [_button addTarget:self action:@selector(chooseAddress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(40);
        make.left.bottom.right.offset(0);
        make.width.equalTo(self);
        make.height.greaterThanOrEqualTo(label);
    }];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        if (self.block) {
            self.block(nil, nil);
        }
    }];
    [addressView addGestureRecognizer:tap];
    
    UIImageView *nextImageView = [UIImageView new];
    nextImageView.image = [UIImage imageNamed:@"more-right"];
    [addressView addSubview:nextImageView];
    [nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressView);
        make.right.offset(-10);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(8);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#555555");
    [addressView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.right.equalTo(nextImageView.mas_left).offset(-10);
    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    _addressLabel.numberOfLines = 0;
    [addressView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.bottom.offset(-10);
        make.left.offset(10);
        make.right.equalTo(nextImageView.mas_left).offset(-10);
    }];
    
}

//选择地址
- (void)chooseAddress
{
    if (self.block) {
        self.newAddress(nil, nil);
    }
}

- (void)setAddress:(YSAddress *)address {
    _address = address;
    
    if (address) {
        _button.hidden = YES;
//        _nameLabel.hidden = NO;
//        _addressLabel.hidden = NO;
        _nameLabel.text = [NSString stringWithFormat:@"%@  %@", _address.name, _address.mobile];
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@", _address.provinceName, _address.cityName, _address.districtName, _address.address];
    } else {
//        _nameLabel.text = @"";
//        _addressLabel.text = @"";
        _button.hidden = NO;
//        _nameLabel.hidden = YES;
//        _addressLabel.hidden = YES;
    }
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _nameLabel.preferredMaxLayoutWidth = _nameLabel.width;
    _addressLabel.preferredMaxLayoutWidth = _addressLabel.width;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
