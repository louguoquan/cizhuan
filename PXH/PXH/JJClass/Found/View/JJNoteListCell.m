//
//  JJNoteListCell.m
//  PXH
//
//  Created by louguoquan on 2018/10/9.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJNoteListCell.h"

@interface JJNoteListCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIImageView *tagImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;


@end


@implementation JJNoteListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.tagImageView];
    
    self.iconImageView.hidden = YES;
    self.tagImageView.hidden = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.width.mas_offset(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.width.mas_offset(15);
    }];
}


- (void)setModel:(JJHomeModel *)model
{
    self.titleLabel.text = model.title;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    self.timeLabel.text = model.time;
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    self.tagImageView.backgroundColor = [UIColor greenColor];
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#777777");
    }
    return _timeLabel;
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

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UIImageView *)tagImageView
{
    if (!_tagImageView) {
        _tagImageView = [[UIImageView alloc]init];
    }
    return _tagImageView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
