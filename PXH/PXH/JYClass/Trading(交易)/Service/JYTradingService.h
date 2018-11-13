//
//  JYTradingService.h
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYTradingOrderModel.h"
#import "JYTradingModel.h"
#import "JYBussinessModel.h"
#import "JYTradingBaseModel.h"
#import "JYKlineHeaderModel.h"




@interface JYTradingService : NSObject

/**
自选币种收藏或者解除
 
 type  //0收藏 1解除收藏
 sourceType  币种选择来源 0USDT 1BTC
 
 */
+ (void)fetchCollectCoinByID:(NSString *)ID type:(NSString *)type sourceType:(NSString *)sourceType completion:(YSCompleteHandler)completion;


/*
 挂单
 */
+ (void)matchTradeBuyType:(NSString *)type coinType:(NSString *)coinType coinNum:(NSString *)coinNum tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum completion:(YSCompleteHandler)completion;



/*
 撤销挂单
 */
+ (void)matchTradeCancelWithMatchId:(NSString *)matchId completion:(YSCompleteHandler)completion;

/*
 挂单列表
 */
+ (void)MatchTrademyListWithBuyCoinID:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

/*
 挂单买卖数据源列表
 */
+ (void)kMatchTradeGuadanList:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion;

/*
 我的历史委托
 */

+ (void)matchTradeMyHistoryList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;


/*
我的所有历史委托
 */

+ (void)matchTradeMyAllHistoryList:(NSDictionary *)parameter page:(NSInteger)page completion:(YSCompleteHandler)completion;



/*
 实时交易明细
 */

+ (void)matchTradeTradeDetails:(NSDictionary *)parameter page:(NSInteger)page completion:(YSCompleteHandler)completion;


/*
 挂单所需信息
 */

+ (void)matchTradeGuadaninfoWithcoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum coinNum:(NSString *)coinNum completion:(YSCompleteHandler)completion;


/*
 挂单所需信无token
 */

+ (void)matchGuaDanInfoNoTokenWithcoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum coinNum:(NSString *)coinNum completion:(YSCompleteHandler)completion;






/*
k线图
 */
+ (void)matchTradeKLineInfoWithType:(NSString *)type coinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion;



/*
 k线图头部数据
 */
+ (void)matchklineHeadCoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion;




@end
