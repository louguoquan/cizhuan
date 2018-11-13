//
//  SeckillView.m
//  PXH
//
//  Created by futurearn on 2017/12/18.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "SeckillView.h"

@implementation SeckillView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setSeckillProduct:(YSSeckillProduct *)seckillProduct
{
    _seckillProduct = seckillProduct;
    
    self.backgroundColor = [UIColor whiteColor];
    //产品图片
    UIImageView *logo = [UIImageView new];
    logo.contentMode = UIViewContentModeScaleAspectFill;
    [logo sd_setImageWithURL:[NSURL URLWithString:_seckillProduct.image] placeholderImage:kPlaceholderImage];
    logo.layer.cornerRadius = 5;
    logo.clipsToBounds = YES;
    [self addSubview:logo];
    if (kScreenWidth == 320) {
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(10);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(120);
        }];
    } else {
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(10);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(150);
        }];
    }
    
    //产品名称
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = HEX_COLOR(@"#333333");
    nameLabel.text = _seckillProduct.productName;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logo);
        make.left.equalTo(logo.mas_right).offset(13);
        make.right.offset(-10);
    }];
    
    //规格
    UILabel *originLabel = [[UILabel alloc] init];
    originLabel.font = [UIFont systemFontOfSize:12];
    originLabel.text = _seckillProduct.summary;
    originLabel.textColor = HEX_COLOR(@"#999999");
    [self addSubview:originLabel];
    [originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom);
        make.left.equalTo(logo.mas_right).offset(13);
        make.right.offset(-10);
    }];
    
    //马上抢按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitle:@"马上抢" forState:UIControlStateNormal];
    button.layer.cornerRadius = 2;
    button.backgroundColor = HEX_COLOR(@"#f46b10");
    button.clipsToBounds = YES;
    button.userInteractionEnabled = NO;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(logo);
        make.right.offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    //价格
    UILabel *priceLabel = [UILabel new];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = HEX_COLOR(@"#f46b10");
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _seckillProduct.price];
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button);
        make.left.equalTo(logo.mas_right).offset(10);
    }];
    
    //市场价
//    UILabel *marketPriceLabel = [UILabel new];
//    marketPriceLabel.font = [UIFont systemFontOfSize:12];
//    marketPriceLabel.textColor = HEX_COLOR(@"#999999");
//    [self addSubview:marketPriceLabel];
//    [marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(priceLabel.mas_right).offset(3);
//        make.bottom.equalTo(priceLabel);
//    }];
    
//    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", _seckillProduct.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
//    marketPriceLabel.attributedText = priceAttr;
    
    UILabel *salesLabel = [UILabel new];
    salesLabel.textAlignment = NSTextAlignmentRight;
    salesLabel.font = [UIFont systemFontOfSize:12];
    if (_seckillProduct.buyCount >= 0) {
        salesLabel.text = [NSString stringWithFormat:@"已抢%zd件", _seckillProduct.buyCount];

    } else {
        salesLabel.text = @"已抢0件";

    }
    salesLabel.textColor = HEX_COLOR(@"#666666");
    [self addSubview:salesLabel];
    [salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button.mas_top).offset(-10);
        make.height.mas_equalTo(16);
        make.right.offset(-10);
    }];
    
    //进度条视图
    UIView *backview = [UIView new];
    backview.backgroundColor = HEX_COLOR(@"#ffc29a");
    backview.layer.masksToBounds = YES;
    backview.layer.cornerRadius = 16 * 0.5;

    [self addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        if (ScreenWidth == 320) {
            make.width.mas_equalTo(100);
        } else {
            make.width.mas_equalTo(115);
        }
        make.bottom.equalTo(button.mas_top).offset(-10);
        make.left.equalTo(logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(salesLabel.mas_left).offset(-10);
    }];
    
    CGFloat percent = ((CGFloat)_seckillProduct.buyCount) / _seckillProduct.limitCount;
    if (percent > 1.0) {
        percent = 1.0;
    }
    
    UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 115 * percent, 16)];
    progressView.backgroundColor = HEX_COLOR(@"#f46b10");
    progressView.layer.masksToBounds = YES;
    progressView.layer.cornerRadius = 16 * 0.5;
    [backview addSubview:progressView];
    
    UILabel *progressLabel = [UILabel new];
    progressLabel.font = [UIFont systemFontOfSize:12];
    progressLabel.textColor = [UIColor whiteColor];
    if (_seckillProduct.percent.integerValue >= 0) {
        progressLabel.text = _seckillProduct.percent;
    } else if (_seckillProduct.percent.integerValue > 100){
        progressLabel.text = @"100%";
    } else {
        progressLabel.text = @"0%";
    }
    [backview addSubview:progressLabel];
    
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];

}

@end
