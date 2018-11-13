//
//  JYTradingService.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingService.h"

@implementation JYTradingService


/**
 自选币种收藏或者解除
 */
+ (void)fetchCollectCoinByID:(NSString *)ID type:(NSString *)type sourceType:(NSString *)sourceType completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = ID;
    param[@"type"] = type;
    param[@"sourceType"] = sourceType;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kCollectCoin parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/*
 挂单
 */
+ (void)matchTradeBuyType:(NSString *)type coinType:(NSString *)coinType coinNum:(NSString *)coinNum tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    param[@"coinType"] = coinType;
    param[@"coinNum"] = coinNum;
    param[@"tradeCoinId"] = tradeCoinId;
    param[@"tradeCoinNum"] = tradeCoinNum;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeBuy parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/*
 撤销挂单
 */
+ (void)matchTradeCancelWithMatchId:(NSString *)matchId completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"matchId"] = matchId;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeCancel parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/*
 挂单列表
 */
+ (void)MatchTrademyListWithBuyCoinID:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTrademyList parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JYTradingOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}



/*
 挂单买卖数据源列表
 */
+ (void)kMatchTradeGuadanList:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"coinType"] = coinType;
    parameters[@"tradeCoinId"] = tradeCoinId;
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeGuadanList parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        JYTradingModel *model = [JYTradingModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StopTimer" object:nil];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/*
 我的历史委托
 */

+ (void)matchTradeMyHistoryList:(NSDictionary *)parameter page:(NSInteger)page completion:(YSCompleteHandler)completion;{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeMyHistoryList parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JYTradingOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/*
 我的所有历史委托
 */

+ (void)matchTradeMyAllHistoryList:(NSDictionary *)parameter page:(NSInteger)page completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeMyAllHistoryList parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JYTradingOrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}



/*
 实时交易明细
 */

+ (void)matchTradeTradeDetails:(NSDictionary *)parameter page:(NSInteger)page completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:parameter];
    parameters[@"page"] = @(page);
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeTradeDetails parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JYBussinessModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StopTimer2" object:nil];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/*
 挂单所需信息
 */

+ (void)matchTradeGuadaninfoWithcoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum coinNum:(NSString *)coinNum completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"coinType"] = coinType;
    parameters[@"tradeCoinId"] = tradeCoinId;
    if (tradeCoinNum.length>0) {
        parameters[@"tradeCoinNum"] = tradeCoinNum;
    }
    if (coinNum.length>0) {
        parameters[@"coinNum"] = coinNum;
    }
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeGuadaninfo parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        JYTradingBaseModel *model = [JYTradingBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}


/*
 挂单所需信无token
 */

+ (void)matchGuaDanInfoNoTokenWithcoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId tradeCoinNum:(NSString *)tradeCoinNum coinNum:(NSString *)coinNum completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"coinType"] = coinType;
    parameters[@"tradeCoinId"] = tradeCoinId;
    if (tradeCoinNum.length>0) {
        parameters[@"tradeCoinNum"] = tradeCoinNum;
    }
    if (coinNum.length>0) {
        parameters[@"coinNum"] = coinNum;
    }
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kMatchTradeGuaDanInfoNoToken parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        JYTradingBaseModel *model = [JYTradingBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}




/*
 k线图
 */

+ (void)matchTradeKLineInfoWithType:(NSString *)type coinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = type;
    parameters[@"coinId"] = coinType;
    parameters[@"tradeCoinId"] = tradeCoinId;
    
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:kMatchTradekLineInfo parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //        NSArray *array = [JYBussinessModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/*
 k线图头部数据
 */
+ (void)matchklineHeadCoinType:(NSString *)coinType tradeCoinId:(NSString *)tradeCoinId completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"coinId"] = coinType;
    parameters[@"tradeCoinId"] = tradeCoinId;
    
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:kMatchKlineHead parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        JYKlineHeaderModel *model = [JYKlineHeaderModel mj_objectWithKeyValues:responseObject[@"result"]];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


@end
