//
//  YSConfirmOrderViewController.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGroupedTableViewController.h"

#import "YSOrderSettleModel.h"

typedef NS_ENUM(NSUInteger, YSCreateOrderType) {
    YSCreateOrderTypeBuyNow,
    YSCreateOrderTypeShoppingCart,
};

@interface YSConfirmOrderViewController : YSGroupedTableViewController

@property (nonatomic, strong) YSOrderSettleModel    *model;

@property (nonatomic, strong) NSString      *cartIds;

@property (nonatomic, assign) YSCreateOrderType     type;

@end
