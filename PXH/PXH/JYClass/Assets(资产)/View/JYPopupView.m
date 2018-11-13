//
//  JYPopupView.m
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPopupView.h"

@interface JYPopupView ()

/// 蒙版View
@property (nonatomic, strong) UIControl         *maskView;

@end


@implementation JYPopupView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        _showMask = YES;
        _animationType = ViewAnimationType_bottomToTop;
        _cornerRadius = 0.f;
        
//        [self setUpUI];
    }
    return self;
}

- (void)show
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;
    
    UIWindow *kWindow = [[UIApplication sharedApplication] keyWindow];
    if (self.showMask) [kWindow addSubview:self.maskView];
    [kWindow addSubview:self];
    
    if (self.animationType == ViewAnimationType_bottomToTop) {
        [self bottomToTopAnimatetion:NO];
    }
    else if (self.animationType == ViewAnimationType_Center) {
        [self centerAnimatetion:NO];
    }
}

- (void)hide
{
    [self endEditing:YES];
    
    if (self.animationType == ViewAnimationType_bottomToTop) {
        [self bottomToTopAnimatetion:YES];
    }
    else if (self.animationType == ViewAnimationType_Center) {
        [self centerAnimatetion:YES];
    }
}


/**
 自下向上滑出动画
 
 @param isHide 判断显示（NO）或 隐藏（YES）
 */
- (void)bottomToTopAnimatetion:(BOOL)isHide
{
    __weak typeof(self) weakSelf = self;
    
    if (isHide) {
        //动画（向下滑出）
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.transform = CGAffineTransformMakeTranslation(0.0, [UIScreen mainScreen].bounds.size.height);
            weakSelf.alpha = 0;
            weakSelf.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            if (finished) {
                [weakSelf removeFromSuperview];
                [weakSelf.maskView removeFromSuperview];
            }
        }];
    }
    else{
        //设置view动画后的位置
//        CGRect frames = self.frame;
//        frames.origin.y = [UIScreen mainScreen].bounds.size.height - frames.size.height;
//        self.frame = frames;
        
        //动画(底部向上滑出)
        self.transform = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.alpha = 1.0f;
            weakSelf.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
            weakSelf.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        }];
    }
}

/**
 中心弹出
 
 @param isHide 判断显示（NO）或 隐藏（YES）
 */
- (void)centerAnimatetion:(BOOL)isHide
{
    __weak typeof(self) weakSelf = self;
    
    if (isHide) {
        [UIView animateWithDuration:.35 animations:^{
            weakSelf.transform = CGAffineTransformMakeScale(1.3, 1.3);
            weakSelf.alpha = 0.0;
            weakSelf.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            if (finished) {
                [weakSelf removeFromSuperview];
                [weakSelf.maskView removeFromSuperview];
            }
        }];
    }
    else{
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0f,
                                           [UIScreen mainScreen].bounds.size.height/2.0f-50);
        
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [UIView animateWithDuration:.35 animations:^{
            weakSelf.alpha = 1;
            weakSelf.transform = CGAffineTransformMakeScale(1, 1);
            weakSelf.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        }completion:^(BOOL finished) {
        }];
    }
}


-(void)setShowMask:(BOOL)showMask
{
    _showMask = showMask;
}

-(void)setAnimationType:(ViewAnimationType)animationType
{
    _animationType = animationType;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
}


-(UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_maskView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }

    return _maskView;
}


@end
