//
//  JJWalletService.h
//  PXH
//
//  Created by louguoquan on 2018/7/31.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJWalletBaseModel.h"
#import "JJTransformModel.h"
#import "JJCoinInOrOutModel.h"
#import "JJWalletBussinessModel.h"


@interface JJWalletService : NSObject

/** 转账 */
+ (void)requestMobileMemberOrderTransferAccounts:(NSString *)mobile money:(NSString *)money msgCode:(NSString *)msgCode password:(NSString *)password Completion:(YSCompleteHandler)completion;

/**  币种账户列表*/
+ (void)JJMyCoinsWithPage:(NSInteger)page Completion:(YSCompleteHandler)completion;

/**  币种提现*/
+ (void)JJPutForwardWithCoinId:(NSString *)coinId number:(NSString *)number toAddress:(NSString *)toAddress password:(NSString *)password Completion:(YSCompleteHandler)completion;

/**  某个币种账户*/
+ (void)JJMyAccountWithCoinId:(NSString *)coinId Completion:(YSCompleteHandler)completion;

/**  站内互转币种列表*/
+ (void)JJMobileMemberOrderTransferlistCompletion:(YSCompleteHandler)completion;

/**  转账记录*/
+ (void)JJMobileMemberOrderTurnRecordWithType:(NSString *)type page:(NSInteger )page Completion:(YSCompleteHandler)completion;


/**  交易记录*/
+ (void)JJPutForwardListWithType:(NSString *)type page:(NSInteger)page  Completion:(YSCompleteHandler)completion;

/**  刷新余额*/
+ (void)JJRefreshCoin:(NSString *)coinId Completion:(YSCompleteHandler)completion;

/** 余额支付*/
+ (void)JJMobileMemberOrderBalancePay:(NSString *)payType  buyNumber:(NSString *)buyNumber payPassword:(NSString *)payPassword Completion:(YSCompleteHandler)completion;



@end
