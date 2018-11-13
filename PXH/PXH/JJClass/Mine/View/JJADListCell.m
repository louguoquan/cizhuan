//
//  JJADListCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJADListCell.h"

@interface JJADListCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *statusImg;

@end

@implementation JJADListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-100);
        make.height.greaterThanOrEqualTo(@20);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
//    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
//        make.right.equalTo(self.contentView).offset(-10);
//        make.height.greaterThanOrEqualTo(@10);
//        make.bottom.equalTo(self.contentView).offset(-15);
//    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(20);
    }];
    
    
}


- (void)setModel:(JJMessageModel *)model
{
    
    self.titleLabel.text = model.content;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    self.timeLabel.text = model.createTime;
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.font = [UIFont systemFontOfSize:15];
        _desLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _desLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
