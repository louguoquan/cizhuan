//
//  JJTransformCell.m
//  PXH
//
//  Created by louguoquan on 2018/8/2.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJTransformCell.h"


@interface JJTransformCell ()

@property (nonatomic,strong)UIImageView *coinImageView;
@property (nonatomic,strong)UILabel *coinName;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end



@implementation JJTransformCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.coinImageView];
    [self.contentView addSubview:self.coinName];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    
    [self.coinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.height.mas_offset(40);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.coinName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinImageView.mas_right).offset(10);
        make.centerY.equalTo(self.coinImageView);
        make.height.mas_offset(20);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.coinImageView);
        make.height.mas_offset(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.countLabel.mas_bottom);
        make.height.mas_offset(20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#F2F2F2");
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(0.8);
    }];
    
}

-(void)setModel:(JJTransformModel *)model
{
    
    [self.coinImageView sd_setImageWithURL:[NSURL URLWithString:model.infoCoin.image] placeholderImage:[UIImage imageNamed:@"eth"]];
    self.coinName.text = model.infoCoin.name;
    self.countLabel.text = model.ReleaseAssets;
    self.priceLabel.text = [NSString stringWithFormat:@"≈￥%@",model.fold];
    
}

- (UIImageView *)coinImageView
{
    if (!_coinImageView) {
        _coinImageView = [[UIImageView alloc]init];
    }
    return _coinImageView;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:15];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}

- (UILabel *)coinName
{
    if (!_coinName) {
        _coinName = [[UILabel alloc]init];
        _coinName.font = [UIFont systemFontOfSize:18];
        _coinName.textColor = HEX_COLOR(@"#333333");
    }
    return _coinName;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _priceLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
