//
//  YSPhoneView.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPhoneView.h"
#import "YSButton.h"
@interface YSPhoneView()

@property (nonatomic, strong) UIView    *actionView;

@end

@implementation YSPhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{

    [self addSubview:self.actionView];
    [_actionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
        make.height.mas_equalTo(45.f);
    }];

}

- (UIView *)actionView {
    if (!_actionView) {
        _actionView = [UIView new];
        _actionView.backgroundColor = BACKGROUND_COLOR;
        _actionView.clipsToBounds = YES;
        
        UIView *toplineView = [UIView new];
        toplineView.backgroundColor = LINE_COLOR;
        [_actionView addSubview:toplineView];
        [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset(0);
            make.height.mas_equalTo(1);
        }];
        
        YSButton *mobileButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
        mobileButton.backgroundColor = [UIColor whiteColor];
        mobileButton.space = 10;
        [mobileButton setTitle:@"拨打电话" forState:UIControlStateNormal];
        [mobileButton setImage:[UIImage imageNamed:@"telephone"] forState:UIControlStateNormal];
        mobileButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [mobileButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [mobileButton addTarget:self action:@selector(callphone) forControlEvents:UIControlEventTouchUpInside];
        [_actionView addSubview:mobileButton];
        [mobileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.left.offset(0);
            make.top.offset(1);
        }];
        
        YSButton *navButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
        navButton.backgroundColor = [UIColor whiteColor];
        navButton.space = 10;
        [navButton setTitle:@"去这里" forState:UIControlStateNormal];
        [navButton setImage:[UIImage imageNamed:@"navigation"] forState:UIControlStateNormal];
        navButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [navButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [navButton addTarget:self action:@selector(iOSNav) forControlEvents:UIControlEventTouchUpInside];
        [_actionView addSubview:navButton];
        [navButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.top.offset(1);
            make.right.offset(0);
            make.left.equalTo(mobileButton.mas_right);
            make.width.equalTo(mobileButton);
        }];
        
        WS(weakSelf);
        UIView *lineView = [UIView new];
        lineView.backgroundColor = LINE_COLOR;
        [_actionView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.centerX.equalTo(weakSelf.actionView);
            make.height.mas_equalTo(20);
            make.top.mas_offset(7.5);
        }];
        
    }
    return _actionView;
}

- (void)setShopDic:(YSLifeMerchants *)shopDic
{
    _shopDic = shopDic;
}

- (void)callphone
{
   [[NSNotificationCenter defaultCenter]postNotificationName:@"拨打电话" object:_shopDic.mobile];
}

- (void)iOSNav
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"导航" object:@{@"lng":_shopDic.lng, @"lat":_shopDic.lat}];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
