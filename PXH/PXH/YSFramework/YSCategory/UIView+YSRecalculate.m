//
//  UIView+YSRecalculate.m
//  ZSMMember
//
//  Created by yu on 16/7/25.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "UIView+YSRecalculate.h"

@implementation UIView (YSRecalculate)

- (void)recalculateHeight
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.height = height;
}

@end
