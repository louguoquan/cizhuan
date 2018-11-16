
//
//  CTProductCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductCell.h"

@interface CTProductCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *specifLabel;

@end


@implementation CTProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.specifLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.height.mas_offset(60);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];

    
    [self.specifLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.bottom.equalTo(self.iconImageView);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];
    
    
    self.titleLabel.text = @"马可波罗釉面砖LF36898";
    self.priceLabel.text = @"￥15.6-18.8";
    self.specifLabel.text = [NSString stringWithFormat:@"规格:%@",@"400ml"];

    self.iconImageView.backgroundColor = [UIColor redColor];


}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
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

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        _priceLabel.textColor = HEX_COLOR(@"##FC6C5A");
    }
    return _priceLabel;
}

- (UILabel *)specifLabel
{
    if (!_specifLabel) {
        _specifLabel = [[UILabel alloc]init];
        _specifLabel.font = [UIFont systemFontOfSize:11];
        _specifLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _specifLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
