//
//  YSConfirmOrderFooterView.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSOrderSettleModel.h"
#import "YSServiceStation.h"
#import "YSCoupons.h"

@interface YSConfirmOrderFooterView : UIView

@property (nonatomic, strong) YSOrderSettleModel    *model;

@property (nonatomic, strong) YSCoupons     *coupons;

@property (nonatomic, strong) YSServiceStation  *station;

@property (nonatomic, strong, readonly) NSString      *memo;

@property (nonatomic, assign, readonly) BOOL    integralUsed;

@property (nonatomic, strong) UIView        *stationView;

@property (nonatomic, strong) MASConstraint *stationHeight;

@property (nonatomic, strong) YSCellView    *remarkCell;

@property (nonatomic, copy) dispatch_block_t checkStation;


@property (nonatomic, copy) dispatch_block_t uncheckStation;

@end
