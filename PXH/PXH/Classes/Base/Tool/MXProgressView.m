//
//  MXProgressView.m
//  PXH
//
//  Created by futurearn on 2017/12/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "MXProgressView.h"

@interface MXProgressView()

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIView *progressView;

@end

@implementation MXProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)updateViewWith:(CGFloat)progress
{
//    UIView *bView = [[UIView alloc]initWithFrame:self.bounds];
//    bView.layer.masksToBounds = YES;
//    bView.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5;
//    bView.backgroundColor = HEX_COLOR(@"#ffc29a");
//    [self addSubview:bView];
//
//    UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bView.frame.size.width * (progress / 100.0f), bView.frame.size.width)];
//    tView.backgroundColor = HEX_COLOR(@"#f46b10");
//    tView.layer.masksToBounds = YES;
//    tView.layer.cornerRadius = CGRectGetHeight(bView.frame) * 0.5;
//    [bView addSubview:tView];
    
//    UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:self.bounds];
//    progressView.progress = progress;
//    [self addSubview:progressView];
}

- (UIView *)backGroundView
{
    if (!_backGroundView) {
        _backGroundView = [UIView new];
        _backGroundView.backgroundColor = HEX_COLOR(@"#ffc29a");
        _backGroundView.layer.masksToBounds = YES;
        _backGroundView.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5;
    }
    return _backGroundView;
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [UIView new];
        _progressView.backgroundColor = HEX_COLOR(@"#f46b10");
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5;
    }
    return _progressView;
}

- (void)setProgress:(CGFloat)progress
{
    self.backGroundView.frame = self.bounds;
    [self addSubview:self.backGroundView];
    
    self.progressView.frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
    [self.backGroundView addSubview:self.progressView];
}




@end
