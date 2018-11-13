//
//  JJMineCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJMineCell.h"

@interface JJMineCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *subLabel;
@end

@implementation JJMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_offset(25);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.height.mas_offset(20);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-35);
        make.height.mas_offset(20);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
    }];
}

- (void)setViewWithTitle:(NSString *)title image:(NSString *)image sub:(NSString *)sub
{
    self.titleLabel.text = title;
    self.iconImageView.image = [UIImage imageNamed:image];
    if (sub.length>0) {
        self.subLabel.hidden = NO;
        self.subLabel.text = sub;
    }else{
        self.subLabel.hidden = YES;
    }
    
}


- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.image = [UIImage imageNamed:@"JJ_return"];
    }
    return _img;
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


- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc]init];
        _subLabel.font = [UIFont systemFontOfSize:15];
        _subLabel.textColor = HEX_COLOR(@"#666666");
        _subLabel.adjustsFontSizeToFitWidth = YES;
        _subLabel.textAlignment = NSTextAlignmentRight;
        _subLabel.minimumFontSize = 0.1;
    }
    return _subLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
