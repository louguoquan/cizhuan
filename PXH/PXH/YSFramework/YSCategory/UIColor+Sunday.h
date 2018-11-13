//
//  UIColor+Sunday.h
//  QingTao
//
//  Created by 管振东 on 16/2/23.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Sunday)

+ (UIColor *)sd_colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)sd_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;



@end
