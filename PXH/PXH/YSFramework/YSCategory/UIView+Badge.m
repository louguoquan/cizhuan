//
//  UIView+Badge.m
//  QingTao
//
//  Created by 管振东 on 16/2/23.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>

NSString const *UIView_BadgeKey = @"UIView_BadgeKey";

@implementation UIView (Badge)

- (void)setBadgeValue:(NSInteger)value bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor {
    
    if (value == 0) {
        [self clearBadge];
    }

    if (!self.badge) {
        UILabel *badge = [UILabel new];
        self.badge = badge;
    }
    
    CGSize badgeSize = [self sizeForString:[NSString stringWithFormat:@"%zd", value] font:[UIFont systemFontOfSize:11.0] size:CGSizeMake(30, 30) mode:NSLineBreakByTruncatingTail];
    CGSize selfSize = self.frame.size;
    if (badgeSize.height > badgeSize.width) {
        self.badge.frame = CGRectMake(selfSize.width - badgeSize.height * 0.5, -badgeSize.height * 0.5, badgeSize.height, badgeSize.height);
    } else {
        self.badge.frame = CGRectMake(selfSize.width - badgeSize.width * 0.5, -badgeSize.height * 0.5, badgeSize.width + 4, badgeSize.height);
    }
    
    self.badge.text = [NSString stringWithFormat:@"%zd", value];
    self.badge.textColor = titleColor;
    self.badge.textAlignment = NSTextAlignmentCenter;
    self.badge.font = [UIFont systemFontOfSize:9.0];
    self.badge.backgroundColor = bgColor;
    
    if (titleColor != [UIColor whiteColor]) {
        self.badge.layer.borderColor = titleColor.CGColor;
        self.badge.layer.borderWidth = 1;
    }
    self.badge.layer.cornerRadius = badgeSize.height * 0.5;
    self.badge.layer.masksToBounds = YES;
    
    [self addSubview:self.badge];
    
}

- (void)setBadgeValue:(NSInteger)value color:(UIColor *)badgeColor {
    
    [self setBadgeValue:value bgColor:badgeColor titleColor:[UIColor whiteColor]];
}

- (void)setBadgeValue:(NSInteger)value {
    
    if (value > 0) {
        [self setBadgeValue:value color:[UIColor redColor]];
    } else {
        [self setBadgeValue:value color:[UIColor clearColor]];
    }
}


- (void)setOffsets:(CGPoint)offsets {
    
    self.badge.x += offsets.x;
    self.badge.y += offsets.y;
}

- (void)clearBadge {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [string boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [string sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

#pragma mark - getters/setters

- (UILabel *)badge {
    
    return objc_getAssociatedObject(self, &UIView_BadgeKey);
}

- (void)setBadge:(UILabel *)badge {
    
    objc_setAssociatedObject(self, &UIView_BadgeKey, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
