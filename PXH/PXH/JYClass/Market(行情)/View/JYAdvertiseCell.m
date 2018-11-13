//
//  JYAdvertiseCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAdvertiseCell.h"


@interface JYAdvertiseCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end


@implementation JYAdvertiseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(17);
        make.right.equalTo(self.contentView).offset(-17);
        make.height.mas_equalTo(15);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(17);
        make.right.equalTo(self.contentView).offset(-17);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
}

-(void)setModel:(JYCmsIndexModel *)model
{
    self.titleLabel.text = model.title;

    self.timeLabel.text = model.ct;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTitleTEXT);
        
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AdvertiseCellTimeTEXT);
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
