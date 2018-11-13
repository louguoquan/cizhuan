//
//  JYTradingOldDealCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/27.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingOldDealCell.h"

@interface JYTradingOldDealCell ()

@property (nonatomic,strong)UIView *baseView;

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *coinLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *priceOther1Label;
@property (nonatomic,strong)UILabel *priceOther2Label;


@end

@implementation JYTradingOldDealCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self.baseView addSubview:self.statusLabel];
    [self.baseView addSubview:self.typeLabel];
    [self.baseView addSubview:self.timeLabel];
    [self.baseView addSubview:self.coinLabel];
    [self.baseView addSubview:self.countLabel];
    [self.baseView addSubview:self.priceOther1Label];
    [self.baseView addSubview:self.priceOther2Label];

    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.baseView).offset(10);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.centerX.equalTo(self.baseView);
        make.height.mas_equalTo(30);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView).offset(-10);
        make.centerY.equalTo(self.timeLabel);
        make.height.mas_offset(25);
        make.width.mas_equalTo(60);
    }];
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(13);
        make.bottom.equalTo(self.baseView).offset(-25);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinLabel);
        make.centerX.equalTo(self.baseView);
        make.height.mas_equalTo(13);
    }];
    
    [self.priceOther1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView).offset(-10);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(13);
    }];
    
    
    [self.priceOther2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceOther1Label);
        make.top.equalTo(self.priceOther1Label.mas_bottom).offset(10);
        make.height.mas_equalTo(13);
    }];
    

}

- (void)setModel:(JYTradingOrderModel *)model
{
    
    
    if (model.buyType.integerValue == 0){
        self.typeLabel.text = @"买";
        self.typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
    }else if (model.buyType.integerValue == 1){
        self.typeLabel.text = @"卖";
        self.typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
    }
    
    
    self.statusLabel.text = @"已成交";
    self.timeLabel.text = model.createTime;  //时间
    
    self.coinLabel.text = model.average;  //成交均价
    
    self.countLabel.text = model.coinDeal;  //成交数量
    
    self.priceOther1Label.text = [NSString stringWithFormat:@"%@%@",model.totalDeal,[JYDefaultDataModel sharedDefaultData].coinPayName];   //成交额
     self.priceOther2Label.text = [NSString stringWithFormat:@"%@%@",model.fee,[JYDefaultDataModel sharedDefaultData].coinPayName];   //手续费
    
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.layer.cornerRadius = 2.0f;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.dk_textColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
    }
    return _typeLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _timeLabel;
}

- (UILabel *)coinLabel
{
    if (!_coinLabel) {
        _coinLabel = [UILabel new];
        _coinLabel.font = [UIFont systemFontOfSize:13];
        _coinLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _coinLabel;
}


- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _countLabel;
}

- (UILabel *)priceOther1Label
{
    if (!_priceOther1Label) {
        _priceOther1Label = [UILabel new];
        _priceOther1Label.font = [UIFont systemFontOfSize:13];
        _priceOther1Label.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _priceOther1Label;
}

- (UILabel *)priceOther2Label
{
    if (!_priceOther2Label) {
        _priceOther2Label = [UILabel new];
        _priceOther2Label.font = [UIFont systemFontOfSize:13];
        _priceOther2Label.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _priceOther2Label;
}

- (UIView *)baseView
{
    if (!_baseView ) {
        _baseView = [UIView new];
        _baseView.layer.cornerRadius = 4.0f;
        _baseView.layer.masksToBounds = YES;
        _baseView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBG);
    }
    return _baseView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 2.0f;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.dk_textColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _statusLabel.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithGrayBtnBG);
    }
    return _statusLabel;
}


@end
