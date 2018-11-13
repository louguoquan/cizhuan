//
//  YSProductService.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSProduct.h"
#import "YSProductDetail.h"
#import "YSStandardDetail.h"
#import "YSCartProduct.h"
#import "YSAdvertising.h"
#import "YSSeckillProduct.h"
#import "YSLimitBuyTime.h"
#import "YSBrands.h"
@interface YSProductService : NSObject


/**
 获取产品列表  带分页
 */
+ (void)fetchProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 获取产品详情
 */
+ (void)fetchProductDetail:(NSString *)productId completion:(YSCompleteHandler)completion;

/**
 根据规格获取详情
 */
+ (void)fetchStandardDetail:(NSString *)specValueId productId:(NSString *)productId completion:(YSCompleteHandler)completion;

/**
    获取品牌
 */
+ (void)fetchBrands:(NSString *)catId completion:(YSCompleteHandler)completion;

/**
 获取购物车产品
 */
+ (void)fetchCartProductList:(YSCompleteHandler)completion;


/**
 获取购物车数量
 */
+ (void)fetchCartProductNum:(YSCompleteHandler)completion;

+ (void)fetchMessageNum:(YSCompleteHandler)completion;


/**
 修改购物车产品数量
 */
+ (void)updateCartProductCount:(NSInteger)count carId:(NSString *)carId completion:(YSCompleteHandler)completion;

/**
 删除购物车产品
 */
+ (void)deleteCartProduct:(NSString *)carId completion:(YSCompleteHandler)completion;


/**
 获取首页数据
 */
+ (void)fetchIndexDataWithCompletion:(YSCompleteHandler)completion;

/**
 获取新首页数据
 */
+ (void)fetchIndexNewDataWithCompletion:(YSCompleteHandler)completion;

/**
 获取秒杀产品
 */
+ (void)fetchSeckillProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 获取抢购时间
 */
+ (void)fetchLimitBuyTimeWithCompletion:(YSCompleteHandler)completion;


/**
 获取限时抢购产品
 */
+ (void)fetchPanicBuyProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 获取产品评论
 */
+ (void)fetchProductCommentList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 收藏产品
 */
+ (void)collectionProduct:(NSString *)objId completion:(YSCompleteHandler)completion;


/**
 获取收藏产品列表
 */
+ (void)fetchCollectProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

@end
