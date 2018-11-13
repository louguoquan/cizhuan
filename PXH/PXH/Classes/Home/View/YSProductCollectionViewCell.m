//
//  YSProductCollectionViewCell.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductCollectionViewCell.h"

@interface YSProductCollectionViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *vipPriceLabel;

@end

@implementation YSProductCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.vipPriceLabel];
    [self.contentView addSubview:self.nameLabel];
        
    WS(weakSelf);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(weakSelf.logo.mas_width);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.logo.mas_bottom).offset(5);
        make.left.offset(10);
        make.height.mas_equalTo(17);
//        make.bottom.lessThanOrEqualTo(weakSelf.contentView).offset(-10);
        make.bottom.offset(-5);

    }];
    
//    [self.vipPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.priceLabel);
//        make.left.greaterThanOrEqualTo(weakSelf.priceLabel.mas_right).offset(5);
//        make.height.mas_equalTo(17);
//        make.right.offset(-10);
//    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
        make.top.equalTo(weakSelf.logo.mas_bottom).offset(5);
        make.left.offset(10);
        make.right.offset(-10);
//        make.bottom.lessThanOrEqualTo(weakSelf.contentView).offset(-10);
        make.bottom.mas_equalTo(self.priceLabel.mas_top).offset(-5);
    }];
}

- (void)setProduct:(YSProduct *)product {
    _product = product;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_product.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _product.productName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
    
    if (_product.type == 1) {
        //普通产品
//        _vipPriceLabel.text = [NSString stringWithFormat:@" 会员价:%.2f  ", _product.vipPrice];
        _iconImageView.hidden = YES;
    }else if (_product.type == 2) {
        //秒杀
//        _vipPriceLabel.text = [NSString stringWithFormat:@" 秒杀价:%.2f  ", _product.vipPrice];
        
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_秒杀"];
    }else {
        //抢购
//        _vipPriceLabel.text = [NSString stringWithFormat:@" 抢购价:%.2f  ", _product.vipPrice];
        
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_抢购"];
    }
    
}

#pragma mark - view

- (UIImageView *)logo {
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = YES;
        
        _iconImageView = [UIImageView new];
        [_logo addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(0);
        }];
    }
    return _logo;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = MAIN_COLOR;
    }
    return _priceLabel;
}

- (UILabel *)vipPriceLabel {
    
    if (!_vipPriceLabel) {
        _vipPriceLabel = [UILabel new];
        _vipPriceLabel.font = [UIFont systemFontOfSize:12];
        _vipPriceLabel.textColor = [UIColor whiteColor];
        _vipPriceLabel.backgroundColor = MAIN_COLOR;
        _vipPriceLabel.layer.cornerRadius = 1;
        _vipPriceLabel.layer.masksToBounds = YES;
        _vipPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _vipPriceLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

@end
