//
//  YSProductCollectionTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductCollectionTableViewCell.h"

@interface YSProductCollectionTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UILabel  *nameLabel;

@property (nonatomic, strong) UILabel  *salesLabel;

@property (nonatomic, strong) UILabel  *priceLabel;

//@property (nonatomic, strong) UILabel  *marketPriceLabel;

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation YSProductCollectionTableViewCell

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
    [self.contentView addSubview:self.deleteButton];
    [self.contentView addSubview:self.priceLabel];
//    [self.contentView addSubview:self.marketPriceLabel];
    
    WS(weakSelf);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.height.width.mas_equalTo(90);
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
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo.mas_bottom);
        make.right.offset(-10);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo.mas_bottom);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.height.mas_equalTo(17);
    }];
    
//    [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.priceLabel.mas_top).offset(-10);
//        make.left.equalTo(weakSelf.priceLabel);
//    }];
}

- (void)setProduct:(YSProduct *)product {
    _product = product;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_product.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _product.productName;
    _salesLabel.text = [NSString stringWithFormat:@"销量%zd", _product.saleCount];
    
//    _marketPriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"市价￥%.2f", _product.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];

    if (_product.type == 1) {
        //普通产品
        _priceLabel.text = [NSString stringWithFormat:@"  会员价:%.2f   ", _product.price];
        _iconImageView.hidden = YES;
    }else if (_product.type == 2) {
        //秒杀
        _priceLabel.text = [NSString stringWithFormat:@"  秒杀价:%.2f   ", _product.price];
        
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"product_秒杀"];
    }else {
        //抢购
        _priceLabel.text = [NSString stringWithFormat:@"  抢购价:%.2f   ", _product.price];
        
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
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _nameLabel;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [UILabel new];
        _salesLabel.font = [UIFont systemFontOfSize:10];
        _salesLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _salesLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        
        WS(weakSelf);
        [_deleteButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:weakSelf.product}];
        }];
    }
    return _deleteButton;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:11];
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
//        _marketPriceLabel.font = [UIFont systemFontOfSize:11];
//        _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
//    }
//    return _marketPriceLabel;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
