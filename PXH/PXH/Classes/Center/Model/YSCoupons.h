//
//  YSCoupons.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCoupons : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *title;           //标题

@property (nonatomic, assign) CGFloat   money;       //卡券金额

@property (nonatomic, assign) CGFloat   conditonMoney; //满足金额

@property (nonatomic, strong) NSString  *endDate;       //截止日期

@property (nonatomic, assign) NSInteger isExchange;

@property (nonatomic, strong) NSString  *productId;

    //0未评价
@property (nonatomic, assign) NSInteger isComment;

/**
 1优惠券  2电子券
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString  *from;       //来源

@property (nonatomic, strong) NSString  *shopLogo;   //店铺logo

@property (nonatomic, strong) NSString  *shopName;   //店铺名称

/**
 状态  0-待使用  1-已使用 2-已过期
 */
@property (nonatomic, assign) NSInteger status;

@end
