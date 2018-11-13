//
//  YSPanicBuyingView.m
//  PXH
//
//  Created by yu on 2017/8/16.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPanicBuyingView.h"

#import "SDProgressView.h"
#import "YSCountDownView.h"

@interface YSPanicBuyingView ()

@property (nonatomic, strong) UILabel   *priceLabel;

@property (nonatomic, strong) UILabel   *marketPriceLabel;

@property (nonatomic, strong) UIView    *progressBgView;

@property (nonatomic, strong) UILabel   *progressLabel;

@property (nonatomic, strong) SDProgressView    *progressView;

@property (nonatomic, strong) UIView    *countdownBgView;

@property (nonatomic, strong) UILabel   *tipsLabel;

@property (nonatomic, strong) YSCountDownView   *countDownView;

@end

@implementation YSPanicBuyingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.clipsToBounds = YES;
    
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:20];
    _priceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(10);
    }];
    
//    _marketPriceLabel = [UILabel new];
//    _marketPriceLabel.font = [UIFont systemFontOfSize:12];
//    _marketPriceLabel.textColor = [UIColor whiteColor];
//    [self addSubview:_marketPriceLabel];
//    [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(_priceLabel.mas_right).offset(5);
//    }];

    _progressBgView = [self createProgressView];
    [self addSubview:_progressBgView];
    [_progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(60);
    }];
    
    _countdownBgView = [self createCountdownView];
    [self addSubview:_countdownBgView];
    [_countdownBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.bottom.offset(0);
    }];
}

- (void)setDetail:(YSProductDetail *)detail {
    _detail = detail;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _detail.salePrice];
//    _marketPriceLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"市价￥%.2f", _detail.costPrice] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSStrikethroughColorAttributeName:[UIColor whiteColor], NSBaselineOffsetAttributeName:@(0)}];

    if (_detail.type == 2) {    //限量
        self.backgroundColor = HEX_COLOR(@"#f46b10");
        _progressBgView.hidden = NO;
        _countdownBgView.hidden = YES;
        
        NSInteger perc = 0;
        if (_detail.percent > 100) {
            perc = 100;
        } else {
            perc = _detail.percent;
        }
//        self.progressLabel.text = [NSString stringWithFormat:@"已抢购%zd%%", _detail.percent];
        self.progressLabel.text = [NSString stringWithFormat:@"已抢购%zd%%", perc];
        
        [self.progressView updatePercent:_detail.percent animated:YES progress:nil];
        
    }else if (_detail.type == 3) {     //限时
        
        self.backgroundColor = MAIN_COLOR;
        _progressBgView.hidden = YES;
        _countdownBgView.hidden = NO;

        [_countDownView setTimerWithRemainingTime:_detail.time];
        
        if (_detail.status == 1) {
            //
            _tipsLabel.text = @"距离本场开始";
        }else {
            _tipsLabel.text = @"距离本场结束";
        }
    }
    
    if ((_detail.type == 3 && _detail.status != 3) || _detail.type == 2) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
        }];
    }else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    
    
}

#pragma mark - view

- (UIView *)createProgressView {
    UIView *view = [UIView new];
    
    _progressView = [SDProgressView new];
    _progressView.style = SDProgressLineStyle;
    //    _progressView.animationDuration =
    _progressView.lineWidth = 10;
    _progressView.trackColor = HEX_COLOR(@"#fbc49f");
    _progressView.progressColor = [UIColor whiteColor];
    //    _progressView.layer.borderColor = HEX_COLOR(@"#709cc9").CGColor;
    //    _progressView.layer.borderWidth = 1;
    _progressView.layer.cornerRadius = 10 / 2.0;
    _progressView.clipsToBounds = YES;
    [view addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(60);
        make.right.offset(0);
        make.bottom.offset(-10);
    }];
    
    _progressLabel = [UILabel new];
    _progressLabel.font = [UIFont systemFontOfSize:12];
    _progressLabel.textColor = [UIColor whiteColor];
    _progressLabel.text = @"已抢购";
    [view addSubview:_progressLabel];
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(0);
    }];
    
    return view;
}

- (UIView *)createCountdownView {
    UIView *view = [UIView new];
    
    _countDownView = [[YSCountDownView alloc] initWithItemWidth:20];
    [view addSubview:_countDownView];
    [_countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.right.centerY.offset(0);
    }];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.text = @"距离本场结束";
    _tipsLabel.font = [UIFont systemFontOfSize:12];
    _tipsLabel.textColor = [UIColor whiteColor];
    [view addSubview:_tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.offset(0);
        make.right.equalTo(_countDownView.mas_left).offset(-5);
    }];
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
