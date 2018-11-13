//
//  JYC2CRecordListCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYC2CRecordListCell.h"


@interface JYC2CRecordListCell ()

@property (nonatomic,strong)UILabel *coinTypeLabel;
@property (nonatomic,strong)UILabel *coinComeLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *countLabel;

@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;

@end


@implementation JYC2CRecordListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.coinTypeLabel];
    [self.contentView addSubview:self.coinComeLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.countLabel];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11);
        make.left.equalTo(self.contentView).offset(11);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(60);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(11);
        make.height.mas_equalTo(11);
        make.bottom.equalTo(self.contentView).offset(-11);
        make.width.mas_equalTo(60);
    }];
    
    [self.coinTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2.mas_right).offset(5);
        make.top.equalTo(self.label1);
        make.height.mas_equalTo(11);
    }];
    
    [self.coinComeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2.mas_right).offset(5);
        make.top.equalTo(self.label2);
        make.height.mas_equalTo(11);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.top.equalTo(self.label1);
        make.height.mas_equalTo(11);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-11);
        make.top.equalTo(self.label2);
        make.height.mas_equalTo(11);
        
    }];
}


-(void)setModel:(JYC2CRecordListModel *)model
{
    
    self.label1.text = @"订单号";
    
    self.label2.text = @"转账划入";
    
    self.coinTypeLabel.text = model.orderNo;
    
    self.timeLabel.text = model.createTime;
    
    self.coinComeLabel.text = @"(8891099@qq.com转入)";
    
    self.countLabel.text = model.tradeNum;
    
}

- (UILabel *)coinTypeLabel
{
    if (!_coinTypeLabel) {
        _coinTypeLabel = [UILabel new];
        _coinTypeLabel.font = [UIFont systemFontOfSize:11];
        _coinTypeLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    return _coinTypeLabel;
}

- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.font = [UIFont systemFontOfSize:11];
        _label1.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.font = [UIFont systemFontOfSize:11];
        _label2.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    return _label2;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:9];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _timeLabel;
}

- (UILabel *)coinComeLabel
{
    if (!_coinComeLabel) {
        _coinComeLabel = [UILabel new];
        _coinComeLabel.font = [UIFont systemFontOfSize:11];
        _coinComeLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    return _coinComeLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    return _countLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
