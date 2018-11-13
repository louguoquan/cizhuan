//
//  YSOrderHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderHeaderView.h"
#import "YSAddressView.h"

@interface YSOrderHeaderView ()

@property (nonatomic, strong) UILabel   *statusLabel;

@property (nonatomic, strong) YSAddressView     *addressView;

@property (nonatomic, strong) UILabel   *remarkLabel;

@end

@implementation YSOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#333333");
    label.text = @"订单状态";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10);
        make.height.mas_equalTo(40);
    }];
    
    _statusLabel = [UILabel new];
    _statusLabel.font = [UIFont systemFontOfSize:15];
    _statusLabel.textColor = MAIN_COLOR;
    [self addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(label);
        make.left.equalTo(label.mas_right).offset(15);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(10);
    }];
    
    _addressView = [YSAddressView new];
    [self addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.offset(0);
    }];
    
    WS(weakSelf);
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = HEX_COLOR(@"#333333");
    label1.text = @"留言:";
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressView.mas_bottom).offset(10);
        make.left.offset(10);
    }];
    
    _remarkLabel = [UILabel new];
    _remarkLabel.font = [UIFont systemFontOfSize:14];
    _remarkLabel.textColor = HEX_COLOR(@"#666666");
    _remarkLabel.numberOfLines = 0;
    _remarkLabel.text = @"暂无留言";
    [self addSubview:_remarkLabel];
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressView.mas_bottom).offset(10);
        make.left.equalTo(label1.mas_right).offset(5);
        make.right.lessThanOrEqualTo(@(-10));
        make.bottom.offset(-10);
    }];
}

- (void)setOrder:(YSOrder *)order {
    _order = order;
    
    _statusLabel.text = [YSOrder statusStringForStatus:_order.status];
    
    _remarkLabel.text = _order.memo.length <= 0 ? @"暂无留言" : _order.memo;
    
    if (_order.sendMethod == 2) {
        _addressView.station = _order.service;
        _addressView.titleLabel.text = @"自提点地址";
    }else {
        _addressView.titleLabel.text = @"收货地址";
        _addressView.address = _order.address;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
