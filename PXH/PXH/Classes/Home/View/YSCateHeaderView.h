//
//  YSCateHeaderView.h
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+YSRecalculate.h"

typedef void(^CateClickHandler)(NSInteger tag);

@interface YSCateHeaderView : UIView

@property (nonatomic, copy) NSArray     *cateArray;

@property (nonatomic, copy) CateClickHandler    block;

@end
