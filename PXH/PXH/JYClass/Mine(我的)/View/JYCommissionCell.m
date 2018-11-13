//
//  JYCommissionCell.m
//  PXH
//
//  Created by louguoquan on 2018/6/9.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYCommissionCell.h"

@interface JYCommissionCell ()

@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end


@implementation JYCommissionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(15);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(15);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"时间";
    label.textColor = HEX_COLOR(@"#999999");
    label.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:label];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"佣金(AT)";
    label1.textColor = HEX_COLOR(@"#999999");
    label1.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:label1];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(15);
        make.height.mas_offset(13);
    }];

    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statusLabel);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(15);
        make.height.mas_offset(13);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel);
        make.top.equalTo(label.mas_bottom).offset(15);
        make.height.mas_offset(15);
    }];

    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.statusLabel);
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.height.mas_offset(15);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#666666");
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15);
        make.height.mas_offset(1);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    
    
}


- (void)setModel:(JYCommissionModel *)model
{
    
    self.phoneLabel.text = model.mobile;

//    if (model.status.integerValue == 0) {
//        self.statusLabel.text = @"未到账";
//    }else if (model.status.integerValue == 1){
        self.statusLabel.text = @"已到账";
//    }
    self.timeLabel.text = model.updateTime;
    
    self.priceLabel.text = [NSString stringWithFormat:@"+%@",model.commission];

    
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.dk_textColorPicker = DKColorPickerWithKey(TEXTFIELDTEXT);
    }
    return _phoneLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(TEXTFIELDTEXT);
    }
    return _timeLabel;
}


-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.dk_textColorPicker = DKColorPickerWithKey(ShareViewBULE);
        
    }
    return _statusLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.dk_textColorPicker = DKColorPickerWithKey(ShareViewBULE);
        
    }
    return _priceLabel;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
