//
//  JYBusinessDetailCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBusinessDetailCell.h"


@interface JYBusinessDetailCell ()

@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *formLabel;
@end


@implementation JYBusinessDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.formLabel];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(11);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
        
    }];
    
    
    [self.formLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.height.mas_equalTo(11);
        make.left.equalTo(self.timeLabel.mas_right).offset(10);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];

    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.left.equalTo(self.formLabel.mas_right).offset(10);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];

    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo((kScreenWidth-50)/4.0);
    }];
}

- (void)setModel:(JYBussinessModel *)model
{
    
    self.timeLabel.text = model.timeString;
    self.priceLabel.text = model.tradePriceStr;
    self.countLabel.text = model.tradeNumStr;
    
    if (model.direction.integerValue == 0) {
        self.formLabel.text = @"买入";
        self.formLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
    }else if (model.direction.integerValue == 1){
        self.formLabel.text = @"卖出";
        self.formLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        
    }
    
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTimeTEXT);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}


- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTimeTEXT);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _priceLabel;
}


- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:13];
        _countLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTimeTEXT);
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}


- (UILabel *)formLabel
{
    if (!_formLabel) {
        _formLabel = [UILabel new];
        _formLabel.font = [UIFont systemFontOfSize:13];
        _formLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTimeTEXT);
        _formLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _formLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
