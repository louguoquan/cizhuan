//
//  YSScrollView.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSScrollView.h"

@implementation YSScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && self.contentOffset.x <= 0) {
        return YES;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
