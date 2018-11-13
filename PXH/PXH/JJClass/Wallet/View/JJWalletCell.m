//
//  JJWalletCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJWalletCell.h"

@interface JJWalletCell ()

@property (nonatomic,strong)UIImageView *coinImageView;
@property (nonatomic,strong)UILabel *coinName;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *coinPriceLabel;

@end

@implementation JJWalletCell

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
    [self.contentView addSubview:self.coinPriceLabel];
    
    
    [self.coinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(20);
        make.width.height.mas_offset(60);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    [self.coinName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinImageView.mas_right).offset(10);
//        make.centerY.equalTo(self.coinImageView);
        make.top.equalTo(self.coinImageView);
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
    
    [self.coinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinName);
        make.bottom.equalTo(self.coinImageView);
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

 -(void)setModel:(JJWalletModel *)model
{
    
    [self.coinImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"eth"]];
    self.coinName.text = model.coinCode;
    self.countLabel.text = model.balance;
    self.priceLabel.text = [NSString stringWithFormat:@"≈￥%@",model.fold];
    if (model.currentPrice.length>0) {
        self.coinPriceLabel.text = [NSString stringWithFormat:@"≈￥%@",model.currentPrice];
    }
    
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
        _countLabel.font = [UIFont systemFontOfSize:18];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}

- (UILabel *)coinName
{
    if (!_coinName) {
        _coinName = [[UILabel alloc]init];
        _coinName.font = [UIFont systemFontOfSize:20];
        _coinName.textColor = HEX_COLOR(@"#333333");
    }
    return _coinName;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _priceLabel;
}

- (UILabel *)coinPriceLabel
{
    if (!_coinPriceLabel) {
        _coinPriceLabel = [[UILabel alloc]init];
        _coinPriceLabel.font = [UIFont systemFontOfSize:18];
        _coinPriceLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _coinPriceLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
