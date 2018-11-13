//
//  YSOrderProductTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderProductTableViewCell.h"

@interface YSOrderProductTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *countLabel;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *specLabel;

@end

@implementation YSOrderProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.contentView.backgroundColor = HEX_COLOR(@"#f7f7f7");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.specLabel];
    
    WS(weakSelf);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(90);
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo);
        make.right.offset(-10);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(10);
        make.right.offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(weakSelf.priceLabel.mas_left).offset(-10);
        make.right.lessThanOrEqualTo(weakSelf.countLabel.mas_left).offset(-10);
    }];
    
    [self.specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.nameLabel);
        make.bottom.lessThanOrEqualTo(weakSelf.logo.mas_bottom);
    }];
}

- (void)setProduct:(YSSettleProduct *)product {
    _product = product;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:kPlaceholderImage];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
    _countLabel.text = [NSString stringWithFormat:@"x%zd", _product.num];
    _nameLabel.text = _product.productName;
    _specLabel.text = _product.normal;
    
    
    if (_product.type == 1) {
        //普通产品
        _iconImageView.hidden = YES;
    }else if (_product.type == 2) {
        //秒杀
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_秒杀"];
    }else {
        //抢购
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_抢购"];
    }

}

- (void)setOrderProduct:(YSOrderProduct *)orderProduct {
    _orderProduct = orderProduct;
    
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_orderProduct.productImage] placeholderImage:kPlaceholderImage];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _orderProduct.price];
    _countLabel.text = [NSString stringWithFormat:@"x%@", _orderProduct.num];
    _nameLabel.text = _orderProduct.productName;
    _specLabel.text = _orderProduct.normal;

    
    if (_orderProduct.type == 1) {
        //普通产品
        _iconImageView.hidden = YES;
    }else if (_orderProduct.type == 2) {
        //秒杀
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_秒杀"];
    }else {
        //抢购
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
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textColor = HEX_COLOR(@"#666666");
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = HEX_COLOR(@"#333333");
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)specLabel {
    if (!_specLabel) {
        _specLabel = [UILabel new];
        _specLabel.font = [UIFont systemFontOfSize:12];
        _specLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _specLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
