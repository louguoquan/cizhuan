//
//  YSPageVCManage.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPageVCManage.h"

@implementation YSPageVCManage

+ (void)adjustPageViewControllerWithScrollView:(UIScrollView *)scrollView superScrollView:(UIScrollView *)superScrollView oldOffset:(CGFloat)oldOffset
{
    CGFloat newOffset = scrollView.mj_offsetY;
    CGFloat offset = newOffset - oldOffset;
    
    //小于0 就归0
    if (scrollView.mj_offsetY <= 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    /*上滑 view不在原点 上传位置  且保持原位置不变*/
    if (offset > 0) {
        if ((superScrollView.mj_offsetY + superScrollView.height) < superScrollView.mj_contentH) {
            //如果父视图没滑到最底部 子视图保持不动
            scrollView.contentOffset = CGPointMake(0, MAX(oldOffset, 0));
            
            //调整父视图位置
            superScrollView.contentOffset = CGPointMake(0, MIN(superScrollView.mj_offsetY + offset, superScrollView.mj_contentH - superScrollView.height));
        }
    }
    
    /*下滑、手动滑动、scroll在原点  上传滑动事件 且将scroll Offset 归0*/
    if (offset < 0 && scrollView.isDragging && oldOffset <= 0) {
        if (superScrollView.mj_offsetY >= 0) {
            superScrollView.contentOffset = CGPointMake(0, MAX(superScrollView.mj_offsetY + offset, 0));
        }
    }
}

@end
