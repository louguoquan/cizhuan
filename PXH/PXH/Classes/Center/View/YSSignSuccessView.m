//
//  YSSignSuccessView.m
//  ZSMMember
//
//  Created by yu on 2016/10/20.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSSignSuccessView.h"

@interface YSSignSuccessView ()

@property (nonatomic, strong) NSString  *todayIntegral;

@property (nonatomic, strong) UIImageView   *bgImageView;

@end

@implementation YSSignSuccessView

- (instancetype)initWithTodayIntegral:(NSString *)todayIntegral
{
    self = [super init];
    if (self) {
        _todayIntegral = todayIntegral;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [HEX_COLOR(@"#000000") colorWithAlphaComponent:0.5];
    
    WS(weakSelf);
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageNamed:@"signinSuccess_bg"];
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(_bgImageView.image.size);
    }];
    _bgImageView.userInteractionEnabled = YES;
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitButton setImage:[UIImage imageNamed:@"signin_cancel"] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exitButton];
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bgImageView.mas_top).offset(-30);
        make.right.equalTo(_bgImageView);
        make.height.width.equalTo(@30);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = HEX_COLOR(@"#333333");
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"签到领取积分%@分", _todayIntegral];
    [_bgImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgImageView);
        make.top.offset(70);
    }];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"signinSuccess_icon"];
    [_bgImageView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(label.mas_bottom).offset(15);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = HEX_COLOR(@"#333333");
    label1.textAlignment = NSTextAlignmentCenter;
    label1.numberOfLines = 0;
    label1.text = @"签到就送积分!\n今日领取签到积分";
    [_bgImageView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.bgImageView);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.font = [UIFont systemFontOfSize:24];
    label2.textColor = MAIN_COLOR;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"+%@", _todayIntegral];
    [_bgImageView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.centerX.offset(0);
    }];
}

- (void)exit
{
    [self removeFromSuperview];
}

- (void)show
{
    _bgImageView.layer.affineTransform = CGAffineTransformMakeScale(0, 0);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    WS(weakSelf);
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.bgImageView.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
