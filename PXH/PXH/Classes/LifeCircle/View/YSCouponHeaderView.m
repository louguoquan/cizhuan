//
//  YSCouponHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCouponHeaderView.h"

@interface YSCouponHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView     *cycleScrollView;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *descLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@end

@implementation YSCouponHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:kPlaceholderImage];
    [self addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(kScreenWidth * 520.f / 750.f);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleScrollView.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = HEX_COLOR(@"#999999");
    _descLabel.numberOfLines = 0;
    [self addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *iconView = [UIImageView new];
    iconView.image = [UIImage imageNamed:@"address"];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(12);
        make.left.offset(10);
        make.top.equalTo(lineView.mas_bottom).offset(10);
    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(5);
        make.right.offset(-10);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(10);
        make.bottom.offset(0);
    }];
}

- (void)setDetail:(YSProductDetail *)detail {
    _detail = detail;
    
    [_cycleScrollView setImageURLStringsGroup:[_detail.images valueForKey:@"image"]];
    
    _nameLabel.text = _detail.productName;
    
    _descLabel.text = _detail.summary;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%@]", _detail.area] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR}];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", _detail.address]]];
    _addressLabel.attributedText = string;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
