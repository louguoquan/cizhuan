//
//  YSOrderSettleModel.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSAddress.h"

#import "YSServiceStation.h"

@interface YSSettleProduct : NSObject

@property (nonatomic, strong) NSString  *normal;

@property (nonatomic, strong) NSString  *normalId;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *productImage;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, assign) NSInteger type;

@end

@interface YSOrderSettleModel : NSObject

@property (nonatomic, assign) CGFloat   amount;

@property (nonatomic, strong) NSString  *canGetScore;

@property (nonatomic, assign) CGFloat   expressFee;

@property (nonatomic, assign) NSInteger isFreePost;      //是否包邮

@property (nonatomic, assign) NSInteger isTotalFreePost; //总订单是否包邮

@property (nonatomic, strong) NSString  *memberId;

@property (nonatomic, assign) CGFloat   payTotalFee;

@property (nonatomic, copy)   NSArray<YSSettleProduct *>  *productDetails;

@property (nonatomic, strong) YSAddress *receiveAddress;

@property (nonatomic, strong) YSServiceStation *servicePointDto;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, assign) CGFloat   scoreAmount;

@property (nonatomic, assign) CGFloat   serviceFee;

@property (nonatomic, assign) CGFloat   sinceFee;

@property (nonatomic, assign) CGFloat specialExpressFee;  //特殊运费

@property (nonatomic, assign) CGFloat   totalFee;

@property (nonatomic, strong) NSString  *totalNum;


@end
