//
//  YSCartProductTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/1.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCartProductTableViewCell.h"
#import "YSSteper.h"

@interface YSCartProductTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UIButton  *checkButton;

@property (nonatomic, strong) UIButton  *deleteButton;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *marketPriceLabel;

@property (nonatomic, strong) UILabel   *specLabel;

@property (nonatomic, strong) YSSteper  *steper;

@end

@implementation YSCartProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.checkButton];
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.marketPriceLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.specLabel];
    [self.contentView addSubview:self.deleteButton];
    [self.contentView addSubview:self.steper];
    
    WS(weakSelf);
    //选择按钮
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.height.width.mas_equalTo(30);
    }];
    
    //图片
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(90);
        make.left.equalTo(weakSelf.checkButton.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    //价格
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.greaterThanOrEqualTo(@60);
    }];
    
    //市场价
    [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
        make.right.offset(-10);
    }];
    
    //产品名称
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(weakSelf.priceLabel.mas_left).offset(-10);

    }];
    //产品规格
    [_specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.nameLabel);
        make.right.lessThanOrEqualTo(weakSelf.priceLabel.mas_left).offset(-10);
//        make.right.lessThanOrEqualTo(weakSelf.marketPriceLabel.mas_left).offset(-10);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo);
        make.right.offset(-10);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(60);
    }];
    
    [_steper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel);
        make.bottom.equalTo(weakSelf.logo);
        make.height.mas_equalTo(24);
//        make.width.mas_equalTo(80);
        make.width.mas_equalTo(110);
    }];
}


- (void)setProduct:(YSCartProduct *)product {
    
    _product = product;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:product.productImage] placeholderImage:kPlaceholderImage];
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.price];
//    _priceLabel.backgroundColor = [UIColor redColor];
    
//    _marketPriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", _product.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
    
    _nameLabel.text = _product.productName;
    
    _specLabel.text = [NSString stringWithFormat:@"规格%@" ,_product.normal];
    
    _steper.defaultValue = _product.num;
    
    _checkButton.selected = _product.selected;
    _checkButton.tag = [product.productId integerValue];
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

- (void)checkButton:(UIButton *)sender
{
    self.checkAction(sender.tag);
}

#pragma mark - view
//选择按钮
- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButton setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"check-pressed"] forState:UIControlStateSelected];
        _checkButton.userInteractionEnabled = YES;
        [_checkButton addTarget:self action:@selector(checkButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}
//图片
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
//价格
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        if (ScreenWidth == 320) {
            _priceLabel.font = [UIFont systemFontOfSize:13];
        } else {
            _priceLabel.font = [UIFont systemFontOfSize:15];
        }
        
        _priceLabel.textColor = MAIN_COLOR;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"123123123123123";
    }
    return _priceLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        _marketPriceLabel = [UILabel new];
        _marketPriceLabel.font = [UIFont systemFontOfSize:12];
        _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
        _marketPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _marketPriceLabel;

}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UILabel *)specLabel {
    if (!_specLabel) {
        _specLabel = [UILabel new];
        _specLabel.font = [UIFont systemFontOfSize:11];
        _specLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _specLabel;

}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        WS(weakSelf);
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [_deleteButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(2), @"model":weakSelf.product}];
        }];
    }
    return _deleteButton;
}

- (YSSteper *)steper {
    if (!_steper) {
        WS(weakSelf);
        _steper = [YSSteper new];
        _steper.block = ^(NSInteger num, BOOL isIncrement) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1), @"isIncrement":@(isIncrement),@"model":weakSelf.product}];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
        };
        _steper.NumChange = ^(NSInteger num) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(3), @"productNum":@(num), @"model":weakSelf.product, @"index":@(weakSelf.indexPath)}];
        };
    }
    return _steper;
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
