//
//  YSSeckillView.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSeckillView.h"
#import "SDProgressView.h"
#import "MXProgressView.h"
@interface YSSeckillView ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel       *nameLabel;

@property (nonatomic, strong) UILabel       *originLabel;

@property (nonatomic, strong) UILabel       *priceLabel;

@property (nonatomic, strong) UILabel       *marketPriceLabel;

@property (nonatomic, strong) UILabel       *salesLabel;

@property (nonatomic, strong) UILabel       *progressLabel;

@property (nonatomic, strong) SDProgressView    *progressView;

@property (nonatomic, strong) MXProgressView *MXProgress;

@property (nonatomic, strong) UIButton *button;

@end

@implementation YSSeckillView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    _logo = [UIImageView new];
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.layer.cornerRadius = 5;
    _logo.clipsToBounds = YES;
    [self addSubview:_logo];
    if (kScreenWidth == 320) {
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(10);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(120);
        }];
    } else {
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.offset(10);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(150);
        }];
    }
    
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo);
        make.left.equalTo(self.logo.mas_right).offset(13);
        make.right.offset(-10);
    }];
    
    _originLabel = [[UILabel alloc] init];
    _originLabel.font = [UIFont systemFontOfSize:12];
    _originLabel.textColor = HEX_COLOR(@"#999999");
    [self addSubview:_originLabel];
    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.logo.mas_right).offset(13);
        make.right.offset(-10);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button setTitle:@"马上抢" forState:UIControlStateNormal];
    _button.layer.cornerRadius = 2;
    _button.backgroundColor = HEX_COLOR(@"#f46b10");
    _button.clipsToBounds = YES;
    _button.userInteractionEnabled = NO;
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.logo);
        make.right.offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = HEX_COLOR(@"#f46b10");
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_button);
        make.left.equalTo(self.logo.mas_right).offset(10);
    }];
    
//    _marketPriceLabel = [UILabel new];
//    _marketPriceLabel.font = [UIFont systemFontOfSize:12];
//    _marketPriceLabel.textColor = HEX_COLOR(@"#999999");
//    [self addSubview:_marketPriceLabel];
//    [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_priceLabel.mas_right).offset(3);
////        make.right.lessThanOrEqualTo(button.mas_right).offset(-10);
//        make.bottom.equalTo(_priceLabel);
//    }];
    
    _salesLabel = [UILabel new];
    _salesLabel.textAlignment = NSTextAlignmentRight;
    _salesLabel.font = [UIFont systemFontOfSize:12];
    _salesLabel.textColor = HEX_COLOR(@"#666666");
    [self addSubview:_salesLabel];
    [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_button.mas_top).offset(-10);
        make.height.mas_equalTo(16);
        make.right.offset(-10);
    }];
    
    
    _progressView = [SDProgressView new];
    _progressView.style = SDProgressLineStyle;
    _progressView.lineWidth = 16;
    _progressView.trackColor = HEX_COLOR(@"#ffc29a");
    _progressView.progressColor = HEX_COLOR(@"#f46b10");
    _progressView.layer.cornerRadius = 16 / 2.0;
    _progressView.clipsToBounds = YES;
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        if (ScreenWidth == 320) {
            make.width.mas_equalTo(100);
        } else {
            make.width.mas_equalTo(115);
        }

        make.bottom.equalTo(_button.mas_top).offset(-10);
        make.left.equalTo(self.logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.salesLabel.mas_left).offset(-10);
    }];




    _progressLabel = [UILabel new];
    _progressLabel.font = [UIFont systemFontOfSize:12];
    _progressLabel.textColor = [UIColor whiteColor];

    [_progressView addSubview:_progressLabel];

    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.offset(0);
    }];
    
}

- (void)setSeckillProduct:(YSSeckillProduct *)seckillProduct {
    _seckillProduct = seckillProduct;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_seckillProduct.image] placeholderImage:kPlaceholderImage];
    _nameLabel.text = _seckillProduct.productName;
    
    _originLabel.text = _seckillProduct.summary;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _seckillProduct.price];

//    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", _seckillProduct.costPrice] attributes:@{NSStrikethroughColorAttributeName:HEX_COLOR(@"#999999"), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSBaselineOffsetAttributeName:@(0)}];
//    _marketPriceLabel.attributedText = priceAttr;
    
    if (_seckillProduct.buyCount < 0) {
        _salesLabel.text = @"已抢0件";
    } else {
        _salesLabel.text = [NSString stringWithFormat:@"已抢%zd件", _seckillProduct.buyCount];
    }

    CGFloat percent = ((CGFloat)_seckillProduct.buyCount) / _seckillProduct.limitCount;
    if (percent > 1.0) {
        percent = 1.0;
    }
    NSString *percentStr = _seckillProduct.percent;
    NSString *pStr = [percentStr componentsSeparatedByString:@"%"].firstObject;
    CGFloat lastPer = [pStr floatValue];
    if (self.type != 0) {
        percent = lastPer / 100.0f;
    }
    if (percentStr.integerValue > 100) {
        percentStr = @"100%";
    }
    if (percentStr.integerValue < 0) {
        percentStr = @"0%";
    }
    _progressLabel.text = percentStr;

    [_progressView updatePercent:percent * 100.f animated:YES progress:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
