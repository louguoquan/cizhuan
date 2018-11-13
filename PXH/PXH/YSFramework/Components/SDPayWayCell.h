//
//  SDPayWayView.h
//  QingTao
//
//  Created by yu on 16/5/26.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SDPayWay) {
    SDPayWayAliPay = 0,
    SDPayWayWechatPay,
    SDPayWayBalancePay,
    SDPayWayCashPay
};

typedef void(^TapHandel)(SDPayWay payway);

@interface SDPayWayCell : UIView

@property (nonatomic, assign, readonly) SDPayWay payWay;

@property (nonatomic, copy) TapHandel   block;

@property (nonatomic, assign) BOOL  selected;

- (instancetype)initWithPayWay:(SDPayWay)payWay tapBlock:(TapHandel)block;

@end
