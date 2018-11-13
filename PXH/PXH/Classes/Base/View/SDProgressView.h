//
//  SDProgressView.h
//  yzr
//
//  Created by 管振东 on 2017/3/2.
//  Copyright © 2017年 guanzd. All rights reserved.
//

//#import "SDView.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SDProgressStyle) {
    SDProgressCircleStyle,
    SDProgressLineStyle
};

typedef void(^progressHandler)(CGFloat progress);

@interface SDProgressView : UIView

@property (nonatomic, assign) SDProgressStyle style;

@property (nonatomic, strong) UIColor *trackColor;

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIImage *gradientImage;

@property (nonatomic, copy)   NSArray *gradientColors;

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign, readonly) BOOL isAnimating;

/**
 @param percent 0 ~ 100
 */
- (void)updatePercent:(CGFloat)percent animated:(BOOL)animated progress:(progressHandler)handler;

@end
