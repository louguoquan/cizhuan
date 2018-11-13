//
//  YSTicketTableViewCell.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSMerchantDetail.h"

@interface YSTicketTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) YSLifeCoupons     *coupon;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, copy) void(^couponClick)(NSInteger row, YSLifeCoupons *coupon);

@end
