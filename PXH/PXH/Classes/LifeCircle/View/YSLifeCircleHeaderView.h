//
//  YSLifeCircleHeaderView.h
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSLifeCategory.h"

#import "UIView+YSRecalculate.h"

@interface YSLifeCircleHeaderView : UIView

@property (nonatomic, strong) NSMutableArray  *array;

@property (nonatomic, copy)void(^click)(YSLifeCategory *model);
@end
