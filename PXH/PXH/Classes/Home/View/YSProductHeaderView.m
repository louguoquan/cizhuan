//
//  YSProductHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductHeaderView.h"

#import "YSPanicBuyingView.h"

@interface YSProductHeaderView ()<SDCycleScrollViewDelegate>
{
    BOOL state;
}
@property (nonatomic, strong) UIView    *infoBgView;

@property (nonatomic, strong) YSPanicBuyingView     *panicBuyView;

@property (nonatomic, strong) SDCycleScrollView     *cycleScrollView;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *descLabel;

@property (nonatomic, strong) UILabel   *marketPriceLabel;

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *discountPriceLabel;

@property (nonatomic, strong) UILabel   *salesLabel;

@property (nonatomic, strong) UILabel   *originLabel;

@property (nonatomic, strong) UILabel   *stockLabel;

@property (nonatomic, strong) UIView    *vipEntryView;

@property (nonatomic, strong) UILabel   *desLabel;

@property (nonatomic, strong) UILabel   *messageLabel;

@property (nonatomic, strong) YSCellView    *specCell;

@end

@implementation YSProductHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
//        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)initSubviews {
    
    [self addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.panicBuyView];
    [self.infoBgView addSubview:self.cycleScrollView];
    [self.infoBgView addSubview:self.panicBuyView];
    [self.infoBgView addSubview:self.collectionButton];
    [self.infoBgView addSubview:self.nameLabel];
    [self.infoBgView addSubview:self.descLabel];
//    [self.infoBgView addSubview:self.marketPriceLabel];
    [self.infoBgView addSubview:self.priceLabel];
    [self.infoBgView addSubview:self.discountPriceLabel];
    [self.infoBgView addSubview:self.salesLabel];
//    [self.infoBgView addSubview:self.originLabel];
    [self.infoBgView addSubview:self.stockLabel];
    
    [self addSubview:self.vipEntryView];
//    [self addSubview:self.specCell];
    
    
    WS(weakSelf);
    
        //infoBgView
    {
        [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
        }];
        
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(kScreenWidth * 880 / 750.0);
        }];
        
        [self.panicBuyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.cycleScrollView.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(0);
        }];
        
        [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.panicBuyView.mas_bottom).offset(10);
            make.right.offset(0);
            make.height.width.mas_equalTo(70);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.collectionButton);
            make.left.offset(10);
            make.right.equalTo(weakSelf.infoBgView).offset(-10);
            make.height.mas_equalTo(40);
        }];


        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
            make.left.offset(10);
            make.height.mas_equalTo(20);
        }];
        
        
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(10);
            make.left.equalTo(weakSelf.infoBgView).offset(10);
            make.height.mas_offset(15);
            make.right.equalTo(weakSelf.infoBgView).offset(-10);
            make.bottom.equalTo(self.infoBgView).offset(-10);
        }];
        


    }
    
        //vipEntryView
    [self.vipEntryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.infoBgView.mas_bottom).offset(1);
        make.left.right.offset(0);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    
    [self.vipEntryView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.vipEntryView).offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    [self.vipEntryView addSubview:self.desLabel];
    [self.desLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
        make.left.equalTo(self.vipEntryView).offset(10);
        make.right.equalTo(self.vipEntryView).offset(-10);
        make.height.greaterThanOrEqualTo(@50);
        make.bottom.equalTo(self.vipEntryView.mas_bottom).offset(-10);
    }];
    

}

- (void)setDetail:(YSProductDetail *)detail {

    _detail = detail;

    [_cycleScrollView setImageURLStringsGroup:[_detail.images valueForKey:@"image"]];
    
    self.collectionButton.selected = _detail.isCollect;
    self.collectionButton.tag = _detail.isCollect;
    if (_detail.isCollect == 1) {
        [_collectionButton setTitle:@"已收藏" forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"collect-pressed"] forState:UIControlStateNormal];
    } else {
        [_collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"collect-normal"] forState:UIControlStateNormal];
    }
    
    self.nameLabel.text = _detail.productName;
    self.descLabel.text = _detail.summary;

    self.salesLabel.text = [NSString stringWithFormat:@"已售%@", _detail.saleCount];
    
//    self.originLabel.text = [NSString stringWithFormat:@"产地:%@", _detail.area];
    
    if (_detail.store.integerValue == 0) {
        self.stockLabel.text = @"已售罄";
        self.stockLabel.textColor = MAIN_COLOR;
    } else {
       self.stockLabel.text = [NSString stringWithFormat:@"库存:%@", _detail.store];
    }
    
    
    if (_detail.type == 1) {    //普通产品
//        _marketPriceLabel.hidden = NO;
//        _marketPriceLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", _detail.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
        
        _priceLabel.hidden = NO;
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _detail.salePrice];
        
        _discountPriceLabel.hidden = NO;
        _discountPriceLabel.text = [NSString stringWithFormat:@"  会员价:￥%.2f  ", _detail.vipPrice];
        
        [_panicBuyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else {
//        _marketPriceLabel.hidden = YES;
        _priceLabel.hidden = YES;
        _discountPriceLabel.hidden = YES;
    }

    _panicBuyView.detail = _detail;
}

- (void)setDetailJJ:(JJShopModel *)detailJJ
{
    
    
    _detailJJ = detailJJ;

//
//    if (_detailJJ.images.count ==0) {
//        if (_detailJJ.image.length>0) {
            [_cycleScrollView setImageURLStringsGroup:@[_detailJJ.image]];
//        }
//    }else{
////        [_cycleScrollView setImageURLStringsGroup:_detailJJ.images];
//    }

    _collectionButton.hidden = YES;
    
    self.nameLabel.text = _detailJJ.productName;
    self.descLabel.text = [NSString stringWithFormat:@"赠品:%@",_detailJJ.sendGift];
    
    self.originLabel.hidden = YES;
    _priceLabel.hidden = NO;
    _priceLabel.text = [NSString stringWithFormat:@"价格:%.2f", [_detailJJ.price doubleValue]];
    
    
    _discountPriceLabel.hidden = YES;

    self.desLabel.numberOfLines = 0;
    self.desLabel.text = _detailJJ.desc;
    [self.desLabel sizeToFit];

    [_panicBuyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];

    
    
    
}


#pragma mark - cycleScroll Delegate
- (SDCollectionViewCell *)collectionViewCell:(SDCollectionViewCell *)cell cellForItemAtIndexPath:(NSInteger)index {
    YSProductImage *image = _detail.images[index];
    if (image.type == 2) {
        cell.playMaskView.hidden = NO;
    }else {
        cell.playMaskView.hidden = YES;
    }
    
    return cell;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    YSProductImage *image = _detail.images[index];
    if (image.type == 2) {
        [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(3), @"model" : image}];
    }
}

#pragma mark - view

- (UIView *)infoBgView {
    if (!_infoBgView) {
        _infoBgView = [UIView new];
        _infoBgView.backgroundColor = [UIColor whiteColor];
    }
    return _infoBgView;
}

- (YSPanicBuyingView *)panicBuyView {
    if (!_panicBuyView) {
        _panicBuyView = [YSPanicBuyingView new];
    }
   
    return _panicBuyView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage: [UIImage imageNamed:@""]];
#warning 轮播图不自动滚动
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.autoScroll = NO;
    }
    return _cycleScrollView;
}

- (YSButton *)collectionButton {
    if (!_collectionButton) {
        _collectionButton = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
        _collectionButton.space = 5;
//        [_collectionButton setImage:[UIImage imageNamed:@"collect-normal"] forState:UIControlStateNormal];
//        [_collectionButton setImage:[UIImage imageNamed:@"collect-pressed"] forState:UIControlStateSelected];
        _collectionButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_collectionButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
//        [_collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
//        [_collectionButton setTitle:@"已收藏" forState:UIControlStateSelected];
//        WS(weakSelf);
        [_collectionButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_collectionButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
//            sender.selected = !sender.selected;
//            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(0)}];
//        }];

    }
    return _collectionButton;
}

- (void)collectAction:(UIButton *)sender
{
    self.changeState(sender.tag);
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;

}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _descLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        _marketPriceLabel = [UILabel new];
        _marketPriceLabel.font = [UIFont systemFontOfSize:11];
        _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _marketPriceLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _priceLabel;
}

- (UILabel *)discountPriceLabel {
    
    if (!_discountPriceLabel) {
        _discountPriceLabel = [UILabel new];
        _discountPriceLabel.font = [UIFont systemFontOfSize:13];
        _discountPriceLabel.textColor = [UIColor whiteColor];
        _discountPriceLabel.backgroundColor = MAIN_COLOR;
        _discountPriceLabel.textAlignment = NSTextAlignmentCenter;
        _discountPriceLabel.layer.cornerRadius = 1;
        _discountPriceLabel.clipsToBounds = YES;
    }
    return _discountPriceLabel;
}

- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [UILabel new];
        _salesLabel.font = [UIFont systemFontOfSize:13];
        _salesLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _salesLabel;
}

- (UILabel *)originLabel {
    if (!_originLabel) {
        _originLabel = [UILabel new];
        _originLabel.font = [UIFont systemFontOfSize:12];
        _originLabel.textColor = HEX_COLOR(@"#999999");
        _originLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _originLabel;
}

- (UILabel *)stockLabel {
    
    if (!_stockLabel) {
        _stockLabel = [UILabel new];
        _stockLabel.font = [UIFont systemFontOfSize:13];
        _stockLabel.textColor = HEX_COLOR(@"#999999");
        _stockLabel.textAlignment = NSTextAlignmentRight;
    }
    return _stockLabel;
}

- (UILabel *)desLabel {
    
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.textColor = HEX_COLOR(@"#999999");
        _desLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _desLabel;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = HEX_COLOR(@"#ffffff");
        _messageLabel.backgroundColor = GoldColor;
        _messageLabel.textAlignment =NSTextAlignmentCenter;
        _messageLabel.text = @"绑定说明";
    }
    return _messageLabel;
}

- (UIView *)vipEntryView {
    if (!_vipEntryView) {
        _vipEntryView = [UIView new];
        _vipEntryView.backgroundColor = [UIColor whiteColor];
    }
    return _vipEntryView;
}

- (YSCellView *)specCell {
    if (!_specCell) {
        _specCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
        _specCell.ys_contentFont = [UIFont systemFontOfSize:15];
        _specCell.ys_contentTextColor = HEX_COLOR(@"#333333");
        _specCell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
        _specCell.backgroundColor = [UIColor whiteColor];
        _specCell.ys_text = @"选择  规格";
        WS(weakSelf);
        [_specCell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1)}];
        }];
    }
    return _specCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
