//
//  JYPopupView.h
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewAnimationType) {
    ViewAnimationType_bottomToTop = 0,//自下向上滑动,默认
    ViewAnimationType_Center = 1,//中心弹出
};

@interface JYPopupView : UIView

/** 是否显示蒙层,默认YES显示 */
@property (nonatomic, assign,getter=isShowMask) BOOL  showMask;

/** 动画类型 */
@property (nonatomic, assign) ViewAnimationType       animationType;

/** 圆角半径， 默认5 */
@property (nonatomic, assign) CGFloat                 cornerRadius;

/** 内容View */
//@property (nonatomic, assign) UIView                 *contentView;

/** 弹出 */
- (void)show;

/** 隐藏 */
- (void)hide;

@end
