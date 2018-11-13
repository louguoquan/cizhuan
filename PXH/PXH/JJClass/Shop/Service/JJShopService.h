//
//  JJShopService.h
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJShopModel.h"
#import "JJOrderBaseModel.h"
#import "JJCardListModel.h"
#import "JJGiftModel.h"

@interface JJShopService : NSObject

/** 商品列表 */
+ (void)JJMobileProductListCompletion:(YSCompleteHandler)completion;

/** 商品详情 */
+ (void)JJMobileProductGetOneById:(NSString *)Pid Completion:(YSCompleteHandler)completion;

/** 确认订单页面 */
+ (void)JJMobileCartConfirmOrder:(NSString *)productId num:(NSInteger )num Completion:(YSCompleteHandler)completion;

/** 创建订单 */
+ (void)JJMobileCartCreateOrder:(NSString *)productId num:(NSString *)num payPwd:(NSString *)payPwd msgCode:(NSString *)msgCode Completion:(YSCompleteHandler)completion;

/** 算力卡列表 */
+ (void)JJMobileCardList:(NSString *)type Completion:(YSCompleteHandler)completion;

/** 绑定算力卡 */
+ (void)JJMobileCardBind:(NSString *)ID Completion:(YSCompleteHandler)completion;

/** 解绑算力卡 */
+ (void)JJMobileCardUnbind:(NSString *)ID Completion:(YSCompleteHandler)completion;

/** 绑定所有算力卡 */
+ (void)JJMobileCardBindAllCompletion:(YSCompleteHandler)completion;

/** 赠送币列表*/
+ (void)JJMobileGiftGiftListCompletion:(YSCompleteHandler)completion;

/** 解锁赠送币*/
+ (void)JJMobileGiftUnlock:(NSString *)ID Completion:(YSCompleteHandler)completion;

@end
