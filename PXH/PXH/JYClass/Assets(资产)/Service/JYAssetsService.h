//
//  JYAssetsService.h
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBuyOrderListModel.h"
#import "JYBankModel.h"
#import "JYUSDTModel.h"
#import "JYCoinInfoModel.h"
#import "JYExchangeModel.h"
#import "JYRechargeModel.h"
#import "JYWithdrawNoticeModel.h"
#import "JYC2CRecordListModel.h"


@interface JYAssetsService : NSObject

/**
新建充值订单
 */
+ (void)fetchCreateRechargeOrder:(NSString *)num completion:(YSCompleteHandler)completion;


/**
订单列表
 */
+ (void)fetchOrderListWithType:(NSString *)type status:(NSInteger )status completion:(YSCompleteHandler)completion;


/**
 取消订单
 */

+ (void)fetchCancelOrderWithOrderId:(NSString *)OrderId completion:(YSCompleteHandler)completion;

/**
 确认支付状态订单
 */

+ (void)fetchPayOrderWithOrderId:(NSString *)OrderId completion:(YSCompleteHandler)completion;


/**
 我的币种账户
 */

+ (void)fetchMyCoins:(NSInteger)isHidden page:(NSInteger)page completion:(YSCompleteHandler)completion;



/**
 提现须知
 */

+ (void)fetchWithdrawNoticeCompletion:(YSCompleteHandler)completion;



/**
 提现转账手续费
 
 @param Id 币种主键
 @param num 转账数量
 */
+ (void)transferFees:(NSString *)Id num:(NSString *)num completion:(YSCompleteHandler)completion;


/**
 提交转账申请
 
 @param Id          币种主键
 @param num         转账数量
 @param myBankId    银行卡号id(收款账户id)
 @param accountNo   对方账户（注册邮箱)
 @param payPassword 资金密码
 @param yzm         验证码
 */
+ (void)commitTransferAsk:(NSString *)Id
                      num:(NSString *)num
                 myBankId:(NSString *)myBankId
                accountNo:(NSString *)accountNo
              payPassword:(NSString *)payPassword
                      yzm:(NSString *)yzm
               completion:(YSCompleteHandler)completion;



/**
银行卡信息
 */
+ (void)mobileCmsBankCardCcompletion:(YSCompleteHandler)completion;


/**
 USDT价格
 */
+ (void)matchTradeGetUsdtCcompletion:(YSCompleteHandler)completion;


/**
 根据币种id获取币种信息

 @param Id 币种主键
 */
+ (void)getCoinById:(NSString *)Id completion:(YSCompleteHandler)completion;


/**
 提交提币/提现

 @param address     提币地址
 @param num         数量
 @param coinId      币主键
 @param password    资金密码
 @param msgCode     验证码
 */
+ (void)submintCoinExchangeWithAddress:(NSString *)address
                                   num:(NSString *)num
                                coinId:(NSString *)coinId
                              password:(NSString *)password
                               msgCode:(NSString *)msgCode
                            completion:(YSCompleteHandler)completion;

/**
 提币记录

 @param coinId   币种主键
 @param page     页码
 */
+ (void)coinExchangeRecordWithCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 充币记录

 @param coinId   币种主键
 @param page     页码
 */
+ (void)currencyRecordWithCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 充值提现记录
 */
+ (void)withdrawRecordWithPage:(NSInteger)page completion:(YSCompleteHandler)completion;


@end
