//
//  YSCountDownView.h
//  PXH
//
//  Created by yu on 2017/8/16.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCountDownView : UIView

@property (nonatomic, copy) YSCompleteHandler block;

- (instancetype)initWithItemWidth:(CGFloat)width;

- (void)setTimerWithRemainingTime:(NSInteger)remainingTime;

@end
