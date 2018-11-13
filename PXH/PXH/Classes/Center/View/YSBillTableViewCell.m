//
//  YSBillTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBillTableViewCell.h"

@interface YSBillTableViewCell ()

@property (nonatomic, strong) UILabel   *timeLabel;

@property (nonatomic, strong) UILabel   *amountLabel;

@property (nonatomic, strong) UILabel   *typeLabel;

@end

@implementation YSBillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.amountLabel];
    
    WS(weakSelf);
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.contentView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.right.lessThanOrEqualTo(weakSelf.typeLabel.mas_left).offset(-5);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.offset(-10);
        make.left.greaterThanOrEqualTo(weakSelf.typeLabel.mas_right).offset(5);
    }];
}

- (void)setDetail:(YSAmountDetail *)detail {
    _detail = detail;
    
    _timeLabel.text = _detail.time;
    
    _typeLabel.text = _detail.memo;
    
    if (_detail.amount < 0) {
        self.amountLabel.textColor = [UIColor blackColor];
    }else {
        self.amountLabel.textColor = MAIN_COLOR;
    }
    self.amountLabel.text = [NSString stringWithFormat:@"%+.2f", _detail.amount];
}

#pragma mark - view

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _typeLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}

- (UILabel *)amountLabel {
    
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.font = [UIFont boldSystemFontOfSize:18];
        _amountLabel.textColor = MAIN_COLOR;
        _amountLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _amountLabel;
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
