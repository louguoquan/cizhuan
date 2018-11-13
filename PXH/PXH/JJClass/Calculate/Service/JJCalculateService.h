//
//  JJCalculateService.h
//  PXH
//
//  Created by louguoquan on 2018/7/30.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJCalculateBallModel.h"
#import "JJCalculateModel.h"
#import "JJBuyModel.h"
#import "JJBuyCoinListModel.h"
#import "JJBuyInfoModel.h"
#import "JJMineCalculateModel.h"
#import "JJInveterModel.h"
#import "JJTaskModel.h"

@interface JJCalculateService : NSObject

/** 算力小球*/
+ (void)dayRewardWithPage:(NSInteger )page Completion:(YSCompleteHandler)completion;

/** 算力排名*/
+ (void)counttRankingCompletion:(YSCompleteHandler)completion;


/** 我的算力*/
+ (void)myCountCompletion:(YSCompleteHandler)completion;


/** 算力秘籍*/
+ (void)JJSecretBooksCompletion:(YSCompleteHandler)completion;

/** 算力任务*/
+ (void)JJSafetyTaskCompletion:(YSCompleteHandler)completion;

/** 小球点击收取*/
+ (void)dianYiDianWithID:(NSString *)ID Completion:(YSCompleteHandler)completion;

/** 认购*/
+ (void)MobileMemberOrderBuyMag:(NSString *)payType buyNumber:(NSString *)buyNumber Completion:(YSCompleteHandler)completion;

/** 认购数据*/
+ (void)JJMobileMemberOrderResidualQuantityCompletion:(YSCompleteHandler)completion;


/** 确认支付*/
+ (void)JJMobileMemberOrderVerifyPageWithID:(NSString *)ID Completion:(YSCompleteHandler)completion;

/** 认购记录*/
+ (void)JJMobileMemberOrderOrderList:(NSString *)orderStatus page:(NSInteger )page Completion:(YSCompleteHandler)completion;


/** 显示图片*/
+ (void)JJImageCompletion:(YSCompleteHandler)completion;

/** 算力流水*/
+ (void)JJCountRecord:(NSInteger )page Completion:(YSCompleteHandler)completion;

/** 邀请列表*/
+ (void)JJMobileMemberMyTeam:(NSInteger )page Completion:(YSCompleteHandler)completion;

/** 兑换价格*/
+ (void)JJMobileMemberOrderEthNumber:(NSString *)buyNumber Completion:(YSCompleteHandler)completion;

/** 算力说明*/
+ (void)JJIntroduction:(NSString *)coinId Completion:(YSCompleteHandler)completion;

@end
