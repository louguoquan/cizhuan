//
//  JYKLineHeaderView.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYKLineHeaderView.h"

@interface JYKLineHeaderView ()

@property (nonatomic,strong)UILabel *btcPriceLabel;
@property (nonatomic,strong)UILabel *cnyPriceLabel;
@property (nonatomic,strong)UILabel *fallOrDegreesLabel;
@property (nonatomic,strong)UILabel *highBtcPriceLabel;
@property (nonatomic,strong)UILabel *lowBtcPriceLabel;
@property (nonatomic,strong)UILabel *countLabel;

@end

@implementation JYKLineHeaderView



- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(KLINEHEADBG);
    
    [self addSubview:self.btcPriceLabel];
    [self addSubview:self.cnyPriceLabel];
    [self addSubview:self.fallOrDegreesLabel];
    [self addSubview:self.highBtcPriceLabel];
    [self addSubview:self.lowBtcPriceLabel];
    [self addSubview:self.countLabel];
    
    
    [self.btcPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self).offset(13);
        make.height.mas_equalTo(20);
    }];
    
    [self.cnyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self.btcPriceLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    
    
    [self.fallOrDegreesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self.cnyPriceLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(12);
    }];
    
    [self.highBtcPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(22);
        make.height.mas_equalTo(12);
    }];
    
    [self.lowBtcPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self.highBtcPriceLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self.lowBtcPriceLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
    }];
    
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"高";
    label1.font = [UIFont systemFontOfSize:13];
    label1.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    [self addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"低";
    label2.font = [UIFont systemFontOfSize:13];
    label2.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    [self addSubview:label2];
    
    UILabel *label3 = [UILabel new];
    label3.text = @"24H量";
    label3.font = [UIFont systemFontOfSize:13];
    label3.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    [self addSubview:label3];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(40);
        make.height.mas_equalTo(12);
        make.top.equalTo(self.highBtcPriceLabel);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(40);
        make.height.mas_equalTo(12);
        make.top.equalTo(self.lowBtcPriceLabel);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(30);
        make.height.mas_equalTo(12);
        make.top.equalTo(self.countLabel);
    }];
    
    
    self.btcPriceLabel.text = @"0";
    self.cnyPriceLabel.text = @"≈￥0";
    self.fallOrDegreesLabel.text = @"+0%";
    
    self.highBtcPriceLabel.text = @"0";
    self.lowBtcPriceLabel.text = @"0";
    self.countLabel.text = @"0";
    
}


- (void)setModel:(JYKlineHeaderModel *)model
{
    
    self.btcPriceLabel.text = model.price;
    
    self.cnyPriceLabel.text = [NSString stringWithFormat:@"≈￥%.2lf",[model.rmbPrice doubleValue]];
    
    if (model.rate.doubleValue>=0) {
        self.fallOrDegreesLabel.text = [NSString stringWithFormat:@"+%.2lf%%",[model.rate doubleValue]];
        self.fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
        
        self.btcPriceLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
    }else{
        self.fallOrDegreesLabel.text = [NSString stringWithFormat:@"%.2lf%%",[model.rate doubleValue]];
        self.fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        self.btcPriceLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
    }
    
    self.highBtcPriceLabel.text = model.maxPrice;
    self.lowBtcPriceLabel.text = model.minPrice;
    
    self.countLabel.text = model.total;
    
    
}

- (UILabel *)btcPriceLabel{
    
    if (!_btcPriceLabel) {
        _btcPriceLabel = [UILabel new];
        _btcPriceLabel.font = [UIFont systemFontOfSize:24];
        _btcPriceLabel.dk_textColorPicker = DKColorPickerWithKey(KLINEHEADTEXTRED);
    }
    return _btcPriceLabel;
    
}


- (UILabel *)cnyPriceLabel{
    
    if (!_cnyPriceLabel) {
        _cnyPriceLabel = [UILabel new];
        _cnyPriceLabel.font = [UIFont systemFontOfSize:15];
        _cnyPriceLabel.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    }
    return _cnyPriceLabel;
    
}

- (UILabel *)fallOrDegreesLabel{
    
    if (!_fallOrDegreesLabel) {
        _fallOrDegreesLabel = [UILabel new];
        _fallOrDegreesLabel.font = [UIFont systemFontOfSize:15];
        _fallOrDegreesLabel.dk_textColorPicker = DKColorPickerWithKey(KLINEHEADTEXTRED);
    }
    return _fallOrDegreesLabel;
    
}

- (UILabel *)highBtcPriceLabel{
    
    if (!_highBtcPriceLabel) {
        _highBtcPriceLabel = [UILabel new];
        _highBtcPriceLabel.font = [UIFont systemFontOfSize:13];
        _highBtcPriceLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _highBtcPriceLabel;
    
}


- (UILabel *)lowBtcPriceLabel{
    
    if (!_lowBtcPriceLabel) {
        _lowBtcPriceLabel = [UILabel new];
        _lowBtcPriceLabel.font = [UIFont systemFontOfSize:13];
        _lowBtcPriceLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _lowBtcPriceLabel;
    
}


- (UILabel *)countLabel{
    
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    }
    return _countLabel;
    
}

@end
