//
//  UINavigationBar+YSLucency.m
//  PXH
//
//  Created by yu on 2017/8/2.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "UINavigationBar+YSLucency.h"

@implementation UINavigationBar (YSLucency)

- (void)setYs_alpha:(CGFloat)ys_alpha
{
    UIView *view = [self.subviews firstObject];
    view.alpha = ys_alpha;
}

@end
