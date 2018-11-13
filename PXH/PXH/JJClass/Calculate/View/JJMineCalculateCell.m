//
//  JJMineCalculateCell.m
//  PXH
//
//  Created by louguoquan on 2018/8/6.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJMineCalculateCell.h"


@interface JJMineCalculateCell ()

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@end

@implementation JJMineCalculateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
    }];
}

- (void)setModel:(JJMineCalculateModel *)model
{
    self.countLabel.text = [NSString stringWithFormat:@"算力来源:%@",model.typeName];
    self.nameLabel.text = [NSString stringWithFormat:@"增加算力:%@",model.number];
    self.timeLabel.text = model.createTime;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
