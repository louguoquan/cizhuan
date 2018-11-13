//
//  UIBarButtonItem+Sunday.m
//  QingTao
//
//  Created by 管振东 on 16/2/23.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "UIBarButtonItem+Sunday.h"

@implementation UIBarButtonItem (Sunday)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateSelected];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
