//
//  JYEarningsCell.m
//  PXH
//
//  Created by louguoquan on 2018/6/8.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYEarningsCell.h"

@interface JYEarningsCell ()

@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *statusLabel;


@end


@implementation JYEarningsCell

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
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(15);
    }];

    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(15);
    }];
    
}

- (void)setModel:(JYEarningsModel *)model
{
    self.phoneLabel.text = model.mobile;
    self.timeLabel.text = model.updateTime;
    self.statusLabel.text = @"生效中";
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
