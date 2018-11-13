
//
//  JJSafeSetCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJSafeSetCell.h"

@interface JJSafeSetCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,strong)UIImageView *subImg;


@end

@implementation JJSafeSetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subImg];
    [self.contentView addSubview:self.subLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(20);
    }];
    
    [self.subImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_offset(15);
        make.width.mas_offset(10);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25);
        make.centerY.equalTo(self.contentView);
        make.height.mas_offset(20);
    }];
    
}

- (void)setViewWithTitle:(NSString *)title sub:(NSString *)sub{
    
    
    self.titleLabel.text = title;
    self.subLabel.text = sub;
    
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
        _subLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _subLabel;
}


- (UIImageView *)subImg
{
    if (!_subImg) {
        _subImg = [[UIImageView alloc]init];
        _subImg.image = [UIImage imageNamed:@"JJ_return"];
    }
    return _subImg;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
