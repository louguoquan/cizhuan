//
//  YSTableView.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTableView.h"

@implementation YSTableView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && self.mj_offsetY <= 0) {
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
