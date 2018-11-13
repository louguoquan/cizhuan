//
//  YSIndexCollectionCell.m
//  PXH
//
//  Created by futurearn on 2018/3/31.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSIndexCollectionCell.h"

@interface YSIndexCollectionCell()

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIButton *addShopCart;

@end

@implementation YSIndexCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSubViews];
    }
    return self;
}


- (void)initWithSubViews
{
    self.iconImage = [UIImageView new];
    _iconImage.image = kPlaceholderImage;
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.width.height.mas_equalTo(ScreenWidth / 3 - 20);
        make.right.offset(-10);
    }];
    
    self.productName = [UILabel new];
    _productName.font = [UIFont systemFontOfSize:15];
    _productName.numberOfLines = 3;
    _productName.textColor = HexColor(0x333333);
    [self.contentView addSubview:_productName];
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.iconImage);
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    self.price = [UILabel new];
    self.price.font = [UIFont systemFontOfSize:15];
    _price.textColor = MAIN_COLOR;
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_productName);
        make.top.mas_equalTo(_productName.mas_bottom).offset(10);
        make.bottom.offset(-10);
    }];
    
    self.addShopCart = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addShopCart setImage:[UIImage imageNamed:@"72x72"] forState:0];
    [_addShopCart addTarget:self action:@selector(addshopCart:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addShopCart];
    
//    UIImageView *shopCart = [UIImageView new];
//    shopCart.image = [UIImage imageNamed:@"shoppingcart-pressed"];
//    [self.contentView addSubview:shopCart];
    [_addShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_price);
        make.right.mas_equalTo(self.iconImage);
        make.width.height.mas_equalTo(22);
    }];
}

- (void)setSeckillProduct:(YSSeckillProduct *)seckillProduct
{
    _seckillProduct = seckillProduct;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:seckillProduct.image] placeholderImage:kPlaceholderImage];
    _productName.text = seckillProduct.productName;
    _price.text = [NSString stringWithFormat:@"￥%.2f", seckillProduct.price];
    _addShopCart.tag = [seckillProduct.productId integerValue];
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    NSString *url = @"http://mobile.zjpxny.com/file";
    url = [NSString stringWithFormat:@"%@%@", url, dic[@"image"]];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kPlaceholderImage];
    _productName.text = dic[@"productName"];
    _price.text = [NSString stringWithFormat:@"￥%@", dic[@"salePriceView"]];
    _addShopCart.tag = [dic[@"id"] integerValue];
}

- (void)addshopCart:(UIButton *)sender
{
    NSString *ID = [NSString stringWithFormat:@"%ld", (long)sender.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"首页加入购物车" object:ID];
}


@end
