//
//  YSOrderService.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSOrderSettleModel.h"
#import "YSServiceStation.h"
#import "YSOrder.h"
#import "YSDeliver.h"
#import "YSRefundsDetail.h"

@interface YSOrderService : NSObject


/**
 立即购买
 */
+ (void)commitOrderFromProduct:(NSString *)productId
                      normalId:(NSString *)normalId
                        number:(NSInteger)num
                    completion:(YSCompleteHandler)completion;


/**
 购物车结算
 */
+ (void)commitOrderFromCart:(NSString *)carIds completion:(YSCompleteHandler)completion;

/**
 加入购物车
 */
+ (void)addProductToShoppingCart:(NSString *)productId
                      standardId:(NSString *)standardId
                          number:(NSInteger)number
                      completion:(YSCompleteHandler)completion;

/**
 根据收货地址获取服务点
 */
+ (void)fetchServiceStationList:(NSDictionary *)parameters
                           page:(NSInteger)page
                     completion:(YSCompleteHandler)completion;
/**
 立即购买生成订单
 */
+ (void)buyNowCreateOrderWithProductId:(NSString *)productId
                                   num:(NSInteger)num
                             serviceId:(NSString *)serviceId
                               isSince:(BOOL)isSince
                              normalId:(NSString *)normalId
                             addressId:(NSString *)addressId
                          pledgeMethod:(BOOL)pledgeMethod
                              couponId:(NSString *)couponId
                                  memo:(NSString *)memo
                            completion:(YSCompleteHandler)completion;

/**
 购物车创建订单
 */
+ (void)shoppingCartCreateOrderWithCarIds:(NSString *)carIds
                                serviceId:(NSString *)serviceId
                                  isSince:(BOOL)isSince
                                addressId:(NSString *)addressId
                             pledgeMethod:(BOOL)pledgeMethod
                                 couponId:(NSString *)couponId
                                     memo:(NSString *)memo
                               completion:(YSCompleteHandler)completion;

/**
 获取订单列表
 */
+ (void)fetchOrderList:(NSDictionary *)param page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 获取订单详情
 */
+ (void)fetchOrderDetail:(NSString *)orderId completion:(YSCompleteHandler)completion;

/**
 获取自提详情
 */
+ (void)fetchDeliverDetail:(NSString *)orderId completion:(YSCompleteHandler)completion;

/**
 发起支付
 */
+ (void)orderPay:(NSString *)orderId payMethod:(NSInteger)payMethod payPassword:(NSString *)payPassword completion:(YSCompleteHandler)completion;

/**
 充值
 */
+ (void)recharge:(NSString *)amount payMethod:(NSInteger)payMethod completion:(YSCompleteHandler)completion;

/**
 修改订单状态
 */
+ (void)updateOrderStatus:(NSString *)urlString parameters:(NSMutableDictionary *)parameters completion:(YSCompleteHandler)completion;


/**
 发布订单评论
 */
+ (void)orderComment:(NSString *)orderId json:(NSString *)json completion:(YSCompleteHandler)completion;

/**
 申请退货
 */
+ (void)refundsApply:(NSString *)orderId
                type:(NSInteger)type
              reason:(NSString *)reason
              mobile:(NSString *)mobile
                desc:(NSString *)desc
              amount:(NSString *)amount
              images:(NSString *)images
          completion:(YSCompleteHandler)completion;

/**
 获取售后详情
 */
+ (void)fetchOrderRefundsDetail:(NSString *)orderId completion:(YSCompleteHandler)completion;

/**
 撤销退款
 */
+ (void)fetchOrderCancelRefunds:(NSString *)orderId completion:(YSCompleteHandler)completion;

/**
 获取订单数量
 */
+ (void)fetchOrderCountWithCompletion:(YSCompleteHandler)completion;

@end
