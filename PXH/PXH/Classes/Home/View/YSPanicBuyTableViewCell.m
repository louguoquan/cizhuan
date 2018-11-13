//
//  YSPanicBuyTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPanicBuyTableViewCell.h"

@interface YSPanicBuyTableViewCell ()

@property (nonatomic, strong) UIImageView   *banner;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *marketPriceLabel;

@property (nonatomic, strong) UIButton  *buyButton;

@end

@implementation YSPanicBuyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WS(weakSelf);
    _banner = [UIImageView new];
    _banner.contentMode = UIViewContentModeScaleAspectFill;
    _banner.clipsToBounds = YES;
    [self.contentView addSubview:_banner];
    [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(14);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo((kScreenWidth - 20) * 260.0 / 710.0);
    }];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (kScreenWidth - 20) * 260.0 / 710.0 + 26, ScreenWidth - 20, 20)];;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:_nameLabel];
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.banner.mas_bottom).offset(12);
//        make.left.right.equalTo(weakSelf.banner);
//    }];
    
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton jm_setCornerRadius:2 withBorderColor:MAIN_COLOR borderWidth:1];
    [_buyButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _buyButton.userInteractionEnabled = NO;
    [self.contentView addSubview:_buyButton];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(75);
        make.right.offset(-10);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.textColor = MAIN_COLOR;
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.buyButton);
        make.left.offset(10);
    }];
    
//    _marketPriceLabel = [UILabel new];
//    _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
//    _marketPriceLabel.font = [UIFont systemFontOfSize:14];
//    [self.contentView addSubview:_marketPriceLabel];
//    [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.buyButton);
//        make.left.equalTo(weakSelf.priceLabel.mas_right).offset(10);
//        make.right.lessThanOrEqualTo(weakSelf.buyButton.mas_left).offset(-10);
//    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.buyButton.mas_bottom).offset(10);
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(10);
    }];
    
}

- (void)setProduct:(YSSeckillProduct *)product status:(NSInteger)status {
    
    [_banner sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = product.productName;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.price];
    
//    _marketPriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"市价:￥%.2f", product.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
    
    if (status == 1) {
        [_buyButton setTitle:@"已结束" forState:UIControlStateNormal];
    }else if (status == 2) {
        [_buyButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    }else {
        [_buyButton setTitle:@"预热中" forState:UIControlStateNormal];
    }
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
