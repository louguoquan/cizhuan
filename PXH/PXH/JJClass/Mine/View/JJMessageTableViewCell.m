//
//  JJMessageTableViewCell.m
//  PXH
//
//  Created by Kessssss on 2018/11/14.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJMessageTableViewCell.h"

@interface JJMessageTableViewCell()
@property (nonatomic,readwrite,weak) UILabel *titleLabel;
@property (nonatomic,readwrite,weak) UILabel *dateLabel;
@property (nonatomic,readwrite,weak) UILabel *contentLabel;
@end
@implementation JJMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).mas_equalTo(20);
        make.right.equalTo(self.dateLabel).mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.top.equalTo(self.titleLabel.mas_top);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.dateLabel.mas_right);
//        make.height.mas_equalTo(40);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --------------getters--------------
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"欢迎下载瓷砖之家，使用前必读！";
        [self.contentView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"11-14";
        label.font     = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"房顶都多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多多";
        label.font     = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 2;
        label.preferredMaxLayoutWidth = 40;
        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}
@end
