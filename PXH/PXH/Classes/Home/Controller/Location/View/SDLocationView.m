//
//  SDLocationView.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "SDLocationView.h"

@interface SDLocationView()

@end

@implementation SDLocationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSubView];
    }
    return self;
}

- (void)initWithSubView
{
    UIView *locationLine = [UIView new];
    locationLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:locationLine];
    [locationLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
        make.height.equalTo(@60.f);
    }];
    
    _currentButton = [[UIButton alloc] init];
    _currentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_currentButton setTitleColor:HexColor(0x292929) forState:0];
    [_currentButton addTarget:self action:@selector(clickCurrentCity:) forControlEvents:UIControlEventTouchUpInside];
    [locationLine addSubview:_currentButton];
    [_currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(locationLine).offset(13.f);
    }];
    
    UIButton *location = [UIButton buttonWithType:UIButtonTypeSystem]; //
    [location setTitleColor:HexColor(0x5e93f9) forState:0];
    [location setTitle:@" 重新定位" forState:0];
    [location setImage:[UIImage imageNamed:@"location_icon"] forState:0];
    location.titleLabel.font = [UIFont systemFontOfSize:15];
    [location addTarget:self action:@selector(retLocation) forControlEvents:UIControlEventTouchUpInside];
    [locationLine addSubview:location];
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(locationLine).offset(-23.f);
        make.centerY.equalTo(locationLine);
    }];
}

- (void)updateCurrentCity:(NSString *)city {
    NSString *text = [NSString stringWithFormat:@"当前：%@",city];
    [_currentButton setTitle:text forState:0];
}

#pragma mark - 点击返回
- (void)clickCurrentCity:(id)sender
{
//    [self.delegate headerViewReturnBack];
}

#pragma mark - 重新定位
- (void)retLocation
{
    [self.delegate headerViewDidClickLocationButton:self];
}


@end
