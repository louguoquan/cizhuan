//
//  YSLifecircleService.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSLifeCircleModel.h"
#import "YSLifeMerchants.h"
#import "YSMerchantDetail.h"
#import "YSCoupons.h"
#import "YSProductDetail.h"

@interface YSLifecircleService : NSObject


/**
 获取生活圈首页数据
 */
+ (void)fetchLifeIndexData:(YSCompleteHandler)completion;

+ (void)fetchLifeSearch:(NSDictionary *)parameters completion:(YSCompleteHandler)completion;

/**
 分页获取店铺
 */
+ (void)fetchMerchantsList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 获取商户详情
 */
+ (void)fetchShopDetail:(NSString *)shopId completion:(YSCompleteHandler)completion;

/**
    使用电子券
 */
+ (void)fetchUseCoupon:(NSString *)couponId completion:(YSCompleteHandler)completion;

/**
 获取优惠券
 */
+ (void)fetchCouponsList:(NSDictionary *)param page:(NSInteger)page completion:(YSCompleteHandler)completion;



/**
 兑换电子券
 */
+ (void)couponExchange:(NSString *)couponId completion:(YSCompleteHandler)completion;

/**
 优惠券评价
 */
+ (void)couponComment:(NSDictionary *)parameters completion:(YSCompleteHandler)completion;

/**
 获取电子券评价列表
 */
+ (void)fetchGetCouponCommentURL:(NSString *)url parameters:(NSDictionary *)parameters completion:(YSCompleteHandler)completion;

/**
 获取优惠券详情
 */
+ (void)fetchCouponDetail:(NSString *)couponId completion:(YSCompleteHandler)completion;

@end
