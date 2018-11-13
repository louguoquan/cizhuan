//
//  JYMarketService.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMarketService.h"

@implementation JYMarketService

/**
 获取币种列表  带分页
 */
+ (void)fetchCoinList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"pageSize"] = @(10);
    
//    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:kSearchProduct_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [JYMarketModel mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"StopTimer1" object:nil];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 
 自选币种重新排序
 
 */

+ (void)UpdateCoinSortWithID:(NSString *)ID sort:(NSInteger)sort completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = ID;
    param[@"sort"] = @(sort);
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kUpdateSort parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 检查版本
 */
+ (void)UpdateCheck:(NSString *)ID completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"apptype"] = ID;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:kVersionCheck parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        
    }];
    
}


/**
 获取系统时间
 */
+ (void)UpdateGetSystemTime:(NSString *)ID completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = @"1";
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:kSystemTime parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}





@end
