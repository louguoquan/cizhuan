//
//  YSOrderSectionHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderSectionHeaderView.h"

#import "YSOrder.h"

@interface YSOrderSectionHeaderView ()

@property (nonatomic, strong) UILabel   *orderNoLabel;

@property (nonatomic, strong) UILabel   *statusLabel;

@end

@implementation YSOrderSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.orderNoLabel];
    [self.contentView addSubview:self.statusLabel];
    
    WS(weakSelf);
    [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.offset(-10);
        make.left.greaterThanOrEqualTo(weakSelf.orderNoLabel.mas_right).offset(10);
    }];
    
}

- (void)setOrderNo:(NSString *)orderNo status:(NSInteger)status {
    _orderNoLabel.text = [NSString stringWithFormat:@"订单编号%@", orderNo];
    
    _statusLabel.text = [YSOrder statusStringForStatus:status];
}

#pragma mark - view

- (UILabel *)orderNoLabel {
    if (!_orderNoLabel) {
        _orderNoLabel = [UILabel new];
        _orderNoLabel.font = [UIFont systemFontOfSize:13];
        _orderNoLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _orderNoLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.textColor = MAIN_COLOR;
        _statusLabel.textAlignment = NSTextAlignmentRight;
    }
    return _statusLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
