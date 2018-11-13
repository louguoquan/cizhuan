//
//  JJWalletService.m
//  PXH
//
//  Created by louguoquan on 2018/7/31.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJWalletService.h"


static NSString *JJMobileMemberOrderTransferAccounts = @"/mobile/member/order/transferAccounts";

static NSString *JJMyCoins = @"/myCoins";
static NSString *JJPutForward = @"/putForward";
static NSString *JJPutForwardList = @"/putForwardList";


static NSString *JJMyAccount = @"/myAccount";

static NSString *JJMobileMemberOrderTransferlist = @"/mobile/member/order/transferlist";

static NSString *JJMobileMemberOrderTurnRecord = @"/mobile/member/order/turnRecord";

static NSString *JJRefreshCoin = @"/refreshCoin";

static NSString *JJMobileMemberOrderBalancePay = @"/mobile/member/order/balancePay";



@implementation JJWalletService

/** 转账 */
+ (void)requestMobileMemberOrderTransferAccounts:(NSString *)mobile money:(NSString *)money msgCode:(NSString *)msgCode password:(NSString *)password Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"mobile"] = mobile;
    parameters[@"money"] = money;
    parameters[@"msgCode"] = msgCode;
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderTransferAccounts parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**  币种账户列表*/
+ (void)JJMyCoinsWithPage:(NSInteger)page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"pageSize"] = @"20";
    
    [[SDDispatchingCenter sharedCenter] GET:JJMyCoins parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJWalletBaseModel *model = [JJWalletBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**  某个币种账户*/
+ (void)JJMyAccountWithCoinId:(NSString *)coinId Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"coinId"] = coinId;

    [[SDDispatchingCenter sharedCenter] GET:JJMyAccount parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJWalletModel *model = [JJWalletModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}




/**  币种提现*/
+ (void)JJPutForwardWithCoinId:(NSString *)coinId number:(NSString *)number toAddress:(NSString *)toAddress password:(NSString *)password Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"coinId"] = coinId;
    param[@"amount"] = number;
    param[@"toAddress"] = toAddress;
    param[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] GET:JJPutForward parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
           !completion?:completion(nil, error);
    }];
}


/**  交易记录*/
+ (void)JJPutForwardListWithType:(NSString *)type page:(NSInteger)page  Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    param[@"page"] = @(page);
    param[@"pageSize"] = @"20";
    [[SDDispatchingCenter sharedCenter] GET:JJPutForwardList parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJWalletBussinessModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}



/**  站内互转币种列表*/
+ (void)JJMobileMemberOrderTransferlistCompletion:(YSCompleteHandler)completion{
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderTransferlist parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JJTransformModel *array = [JJTransformModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**  转账记录*/
+ (void)JJMobileMemberOrderTurnRecordWithType:(NSString *)type page:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    param[@"page"] = @(page);
    param[@"pageSize"] = @(20);
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderTurnRecord parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJCoinInOrOutModel *array = [JJCoinInOrOutModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}



/**  刷新余额*/
+ (void)JJRefreshCoin:(NSString *)coinId Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"coinId"] = coinId;
    [[SDDispatchingCenter sharedCenter] GET:JJRefreshCoin parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:[UIApplication sharedApplication].keyWindow];
         !completion?:completion(nil, error);
    }];
}



/** 余额支付*/
+ (void)JJMobileMemberOrderBalancePay:(NSString *)payType  buyNumber:(NSString *)buyNumber payPassword:(NSString *)payPassword Completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"payType"] = payType;
    param[@"buyNumber"] = buyNumber;
    param[@"payPassword"] = [payPassword md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderBalancePay parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}




@end
