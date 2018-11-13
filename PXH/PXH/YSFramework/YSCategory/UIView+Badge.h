//
//  UIView+Badge.h
//  QingTao
//
//  Created by 管振东 on 16/2/23.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Badge)

@property (nonatomic, weak) UILabel *badge;

- (void)setBadgeValue:(NSInteger)value;

- (void)setBadgeValue:(NSInteger)value color:(UIColor *)badgeColor;

- (void)setBadgeValue:(NSInteger)value bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor;

- (void)clearBadge;

- (void)setOffsets:(CGPoint)offsets;

@end
