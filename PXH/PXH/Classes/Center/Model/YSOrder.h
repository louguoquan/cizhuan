//
//  YSOrder.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSOrderProduct.h"
#import "YSAddress.h"
#import "YSServiceStation.h"

@interface YSOrder : NSObject

@property (nonatomic, strong) NSString  *orderNo;

@property (nonatomic, strong) NSString  *orderId;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString  *memberId;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger expressStatus;

@property (nonatomic, strong) NSString  *sellerId;

@property (nonatomic, strong) NSString  *sellerName;

@property (nonatomic, strong) NSString  *num;

@property (nonatomic, assign) CGFloat   totalFee;

@property (nonatomic, strong) NSString  *name;

@property (nonatomic, strong) NSString  *mobile;

@property (nonatomic, strong) YSAddress *address;

@property (nonatomic, strong) NSString  *payMethod;

@property (nonatomic, assign) CGFloat   amountFee;

@property (nonatomic, assign) CGFloat   amount;

@property (nonatomic, assign) CGFloat   score;

@property (nonatomic, assign) CGFloat   coupon;

@property (nonatomic, strong) NSString  *coffers;

@property (nonatomic, strong) NSString  *totalCommission;

@property (nonatomic, assign) CGFloat   expressFee;

@property (nonatomic, strong) NSString  *memo;

@property (nonatomic, strong) NSString  *express;

    //快递公司英文编号
@property (nonatomic, strong) NSString  *expressCode;

@property (nonatomic, strong) NSString  *expressNo;

@property (nonatomic, strong) NSString  *sendTime;

/**
 配送方式  1平台配送  2自提  3快递
 */
@property (nonatomic, assign) NSInteger sendMethod;

@property (nonatomic, strong) NSString  *receiveTime;

@property (nonatomic, strong) NSString  *createTime;

@property (nonatomic, strong) NSString  *finishedTime;

@property (nonatomic, strong) NSString  *payTime;

@property (nonatomic, strong) NSString  *refundTime;

@property (nonatomic, strong) NSString  *refundFinishTime;

@property (nonatomic, strong) NSString  *plusTime;

@property (nonatomic, strong) NSString  *refundType;

@property (nonatomic, strong) NSString  *oldPayStatus;

@property (nonatomic, strong) NSString  *oldShipStatus;

@property (nonatomic, strong) NSString  *oldReceiveStatus;

@property (nonatomic, strong) YSServiceStation  *service;

@property (nonatomic, copy)   NSArray<YSOrderProduct *>   *items;

+ (NSString *)statusStringForStatus:(NSInteger)status;

@end
