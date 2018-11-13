//
//  YSPageVCManage.h
//  HouseDoctorMember
//
//  Created by yu on 2017/6/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSPageVCManage : NSObject

/**
 根据子视图滑动距离调整父视图滑动距离

 @param scrollView 当前scrollView
 @param superScrollView 父视图scrollView
 @param oldOffset 原始偏移量
 */
+ (void)adjustPageViewControllerWithScrollView:(UIScrollView *)scrollView superScrollView:(UIScrollView *)superScrollView oldOffset:(CGFloat)oldOffset;

@end
