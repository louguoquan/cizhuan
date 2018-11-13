//
//  YSProductTableViewCell.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductTableViewCell.h"

@interface YSProductTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UILabel  *nameLabel;

@property (nonatomic, strong) UILabel  *salesLabel;

@property (nonatomic, strong) UILabel  *priceLabel;

@property (nonatomic, strong) UILabel  *marketPriceLabel;

@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) UIView *saleView;

@end

@implementation YSProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.salesLabel];
    [self.contentView addSubview:self.buyButton];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.marketPriceLabel];
    
    WS(weakSelf);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.height.width.mas_equalTo(115);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo.mas_top);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.offset(-10);
    }];
    
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(13);
        make.left.right.equalTo(weakSelf.nameLabel);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo.mas_bottom);
        make.right.offset(-20);
//        make.height.mas_equalTo(25);
//        make.width.mas_equalTo(85);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo.mas_bottom);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.height.mas_equalTo(17);
    }];
    
    [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.priceLabel.mas_top).offset(-10);
        make.left.equalTo(weakSelf.priceLabel);
    }];
}

- (void)setProduct:(YSProduct *)product {
    _product = product;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_product.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _product.productName;

    _salesLabel.text = [NSString stringWithFormat:@"销量: %zd", _product.saleCount];
    
    if (_product.store.integerValue == 0) {
        [self.logo addSubview:self.saleView];
        [self.saleView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.left.bottom.right.offset(0);
            
        }];
    }
    
//    _marketPriceLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"市价￥%.2f", _product.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
    
    if (_product.type == 1) {
        //普通产品
        _priceLabel.text = [NSString stringWithFormat:@" 会员价:%.2f  ", _product.vipPrice];
        _iconImageView.hidden = YES;
    }else if (_product.type == 2) {
        //秒杀
        _priceLabel.text = [NSString stringWithFormat:@" 秒杀价:%.2f  ", _product.price];
        
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_秒杀"];
    }else {
        //抢购
        _priceLabel.text = [NSString stringWithFormat:@" 抢购价:%.2f  ", _product.price];
        
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [UILabel new];
        _salesLabel.font = [UIFont systemFontOfSize:14];
        _salesLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _salesLabel;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_buyButton setTitle:@"加入购物车" forState:UIControlStateNormal];
//        [_buyButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
//        _buyButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_buyButton jm_setCornerRadius:2 withBorderColor:MAIN_COLOR borderWidth:1.f];
        [_buyButton setImage:[UIImage imageNamed:@"72x72"] forState:0];
        [_buyButton addTarget:self action:@selector(addToShopCart:) forControlEvents:UIControlEventTouchUpInside];
        _buyButton.userInteractionEnabled = YES;
    }
    return _buyButton;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.backgroundColor = MAIN_COLOR;
        _priceLabel.layer.cornerRadius = 2;
        _priceLabel.clipsToBounds = YES;
    }
    return _priceLabel;
}

//- (UILabel *)marketPriceLabel {
//    if (!_marketPriceLabel) {
//        _marketPriceLabel = [UILabel new];
//        _marketPriceLabel.font = [UIFont systemFontOfSize:13];
//        _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
//    }
//    return _marketPriceLabel;
//}

- (UIView *)saleView
{
    if (!_saleView) {
        
        _saleView = [UIView new];
        _saleView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        UIImageView *saleImage = [UIImageView new];
        saleImage.image = [UIImage imageNamed:@"售罄"];
        [_saleView addSubview:saleImage];
        [saleImage mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.center.equalTo(_saleView);
            make.width.height.mas_equalTo(60);
            
        }];
    }
    return _saleView;
}

//加入购物车
- (void)addToShopCart:(UIButton *)sender
{
    self.addShopCart(_product.productId);
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
