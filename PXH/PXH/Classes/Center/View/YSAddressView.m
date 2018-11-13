//
//  YSAddressView.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAddressView.h"
#import "YSButton.h"

@interface YSAddressView ()

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@property (nonatomic, strong) UIView    *actionView;

@end

@implementation YSAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.actionView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = LINE_COLOR;
    [self addSubview:lineView1];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.offset(10);
        make.top.offset(0);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(45.f);
        make.left.right.bottom.offset(0);
    }];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(9);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)setAddress:(YSAddress *)address {
    
    _address = address;
    _nameLabel.text = [NSString stringWithFormat:@"%@  %@", _address.name, _address.mobile];
    _addressLabel.text = _address.address;
    [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.f);
    }];

}

- (void)setStation:(YSServiceStation *)station {
    
    _station = station;
    _nameLabel.text = [NSString stringWithFormat:@"%@  %@", _station.name, _station.mobile];
    _addressLabel.text = _station.address;
    
    [_actionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45.f);
    }];

}

#pragma mark - view

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"收货地址";
        _titleLabel.textColor = HEX_COLOR(@"#333333");
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return _titleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _nameLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = HEX_COLOR(@"#666666");
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

- (UIView *)actionView {
    if (!_actionView) {
        _actionView = [UIView new];
        _actionView.backgroundColor = BACKGROUND_COLOR;
        _actionView.clipsToBounds = YES;
        
        YSButton *mobileButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
        mobileButton.backgroundColor = [UIColor whiteColor];
        mobileButton.space = 10;
        [mobileButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        [mobileButton setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
        mobileButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [mobileButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [mobileButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            if (_station) {
                [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(10), @"model":_station}];
            }
        }];
        [_actionView addSubview:mobileButton];
        [mobileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.left.top.offset(0);
        }];

        YSButton *navButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
        navButton.backgroundColor = [UIColor whiteColor];
        navButton.space = 10;
        [navButton setTitle:@"去这里" forState:UIControlStateNormal];
        [navButton setImage:[UIImage imageNamed:@"navigation"] forState:UIControlStateNormal];
        navButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [navButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [navButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            if (_station) {
                [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(11), @"model":_station}];
            }
        }];
        [_actionView addSubview:navButton];
        [navButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.right.top.offset(0);
            make.left.equalTo(mobileButton.mas_right);
            make.width.equalTo(mobileButton);
        }];
        
        WS(weakSelf);
        UIView *lineView = [UIView new];
        lineView.backgroundColor = LINE_COLOR;
        [_actionView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.centerX.equalTo(weakSelf.actionView);
            make.height.mas_equalTo(20);
            make.top.mas_offset(7.5);
        }];
        
    }
    return _actionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
