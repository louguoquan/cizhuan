//
//  YSOrderFooterView.h
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+YSRecalculate.h"

#import "YSOrder.h"

@interface YSOrderFooterView : UIView

@property (nonatomic, strong) YSOrder   *order;

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type;

@end
