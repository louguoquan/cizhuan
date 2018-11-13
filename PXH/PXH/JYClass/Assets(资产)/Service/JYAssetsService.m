//
//  JYAssetsService.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAssetsService.h"

@implementation JYAssetsService


/**
 新建充值订单
 */
+ (void)fetchCreateRechargeOrder:(NSString *)num completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"num"] = num;
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kCreateRechargeOrder parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        JYBuyOrderListModel *model = [JYBuyOrderListModel mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}

/**
 订单列表
 */
+ (void)fetchOrderListWithType:(NSString *)type status:(NSInteger )status completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    param[@"status"] = @(status);
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kOrderList parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *array = [JYBuyOrderListModel mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}


/**
 取消订单
 */

+ (void)fetchCancelOrderWithOrderId:(NSString *)OrderId completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"orderId"] = OrderId;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kCancelOrder parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}


/**
 确认支付状态订单
 */

+ (void)fetchPayOrderWithOrderId:(NSString *)OrderId completion:(YSCompleteHandler)completion{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"orderId"] = OrderId;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kPayOrder parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 
 我的币种账户
 
 */

+ (void)fetchMyCoins:(NSInteger)isHidden page:(NSInteger)page completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (isHidden) {
        param[@"isHidden"] = @(isHidden);
    }
    param[@"page"] = @(page);
    param[@"pageSize"] = @(20);
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:kMyCoins parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}



/**
 
提现须知
 
 */

+ (void)fetchWithdrawNoticeCompletion:(YSCompleteHandler)completion{

    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kWithdrawNotice parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JYWithdrawNoticeModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 提现转账手续费
 
 */
+ (void)transferFees:(NSString *)Id num:(NSString *)num completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = Id;
    param[@"num"] = num;
    
    [[SDDispatchingCenter sharedCenter] POST:kWithdrawFee parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            NSString *fees = responseObject[@"result"];
            completion(fees, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 提交转账申请
 
 */
+ (void)commitTransferAsk:(NSString *)Id num:(NSString *)num myBankId:(NSString *)myBankId accountNo:(NSString *)accountNo payPassword:(NSString *)payPassword yzm:(NSString *)yzm completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = Id;
    param[@"num"] = num;
    param[@"myBankId"] = myBankId;
    param[@"accountNo"] = accountNo;
    param[@"payPassword"] = [payPassword md5String];//
    param[@"yzm"] = yzm;
    
    [[SDDispatchingCenter sharedCenter] POST:kWithdrawSub parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 银行卡信息
 */
+ (void)mobileCmsBankCardCcompletion:(YSCompleteHandler)completion{
    
    
    [[SDDispatchingCenter sharedCenter] GET:kMobileCmsBankCard parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JYBankModel *model = [JYBankModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

    
}


/**
 USDT价格
 */
+ (void)matchTradeGetUsdtCcompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeGetUsdt parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JYUSDTModel *model = [JYUSDTModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)getCoinById:(NSString *)Id completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    param[@"id"] = Id;
    
    [[SDDispatchingCenter sharedCenter] GET:JYGetCoinById parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JYCoinInfoModel *model = [JYCoinInfoModel mj_objectWithKeyValues:responseObject[@"result"]];
        
        !completion?:completion(model, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)submintCoinExchangeWithAddress:(NSString *)address
                                   num:(NSString *)num
                                coinId:(NSString *)coinId
                              password:(NSString *)password
                               msgCode:(NSString *)msgCode
                            completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    param[@"address"] = address;
    param[@"num"] = num;
    param[@"coinId"] = coinId;
    param[@"password"] = [password md5String];//
    param[@"msgCode"] = msgCode;
    
    [[SDDispatchingCenter sharedCenter] POST:JYSubmintCoinExc parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject[@"result"], nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)coinExchangeRecordWithCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    param[@"coinId"] = coinId;
    param[@"page"] = @(page);
    param[@"pageSize"] = @(20);
    
    [[SDDispatchingCenter sharedCenter] GET:JYCoinExchangeRecord parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [JYExchangeModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(arr, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)currencyRecordWithCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    param[@"coinId"] = coinId;
    param[@"page"] = @(page);
    param[@"pageSize"] = @(20);
    
    [[SDDispatchingCenter sharedCenter] GET:JYCurrencyRecord parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *arr = [JYRechargeModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(arr, nil);

    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)withdrawRecordWithPage:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    param[@"page"] = @(page);
    param[@"pageSize"] = @(20);
    
    [[SDDispatchingCenter sharedCenter] POST:JYOrderRecord parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [JYC2CRecordListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(arr, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

@end
