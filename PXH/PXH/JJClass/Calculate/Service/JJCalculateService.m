//
//  JJCalculateService.m
//  PXH
//
//  Created by louguoquan on 2018/7/30.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateService.h"


static NSString *JJDayReward = @"/dayReward";
static NSString *JJCounttRanking = @"/counttRanking";
static NSString *JJDianYiDian = @"/dianYiDian";
static NSString *JJMyCount = @"/myCount";
static NSString *JJMobileMemberOrderBuyMag = @"/mobile/member/order/buyMach";
static NSString *JJMobileMemberOrderOrderList = @"/mobile/member/order/orderList";
static NSString *JJMobileMemberOrderResidualQuantity = @"/mobile/member/order/residualQuantity";
static NSString *JJMobileMemberOrderVerifyPage = @"/mobile/member/order/verifyPage";
static NSString *JJSecretBooks = @"/secretBooks";
static NSString *JJCountRecord = @"/countRecord";
static NSString *JJMobileMemberMyTeam = @"/mobile/member/myTeam";

static NSString *JJSafetyTask = @"/safetyTask";

static NSString *JJMobileMemberOrderEthNumber = @"/mobile/member/order/ethNumber";

static NSString *JJIntroduction = @"/introduction";
static NSString *JJImage = @"/image";








@implementation JJCalculateService

/** 算力小球*/
+ (void)dayRewardWithPage:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"page"] = @(page);
    parma[@"pageSize"] = @"10";
  
    [[SDDispatchingCenter sharedCenter] GET:JJDayReward parameters:parma success:^(NSURLSessionDataTask *task, id responseObject) {
        
       JJCalculateBallBaseModel *model = [JJCalculateBallBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}

/** 算力排行*/
+ (void)counttRankingCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJCounttRanking parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJCalculateModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/** 我的算力*/
+ (void)myCountCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJMyCount parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}


/** 显示图片*/
+ (void)JJImageCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJImage parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}




/** 小球点击收取*/
+ (void)dianYiDianWithID:(NSString *)ID Completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = ID;
    [[SDDispatchingCenter sharedCenter] GET:JJDianYiDian parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/** 认购*/
+ (void)MobileMemberOrderBuyMag:(NSString *)payType buyNumber:(NSString *)buyNumber Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"payType"] = payType;
    parameters[@"buyNumber"] = buyNumber;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderBuyMag parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJBuyModel *model = [JJBuyModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
         !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 认购数据*/
+ (void)JJMobileMemberOrderResidualQuantityCompletion:(YSCompleteHandler)completion{
    
 
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderResidualQuantity parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJBuyInfoModel *model = [JJBuyInfoModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 确认支付*/
+ (void)JJMobileMemberOrderVerifyPageWithID:(NSString *)ID Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = ID;
    [[SDDispatchingCenter sharedCenter] GET:JJMobileMemberOrderVerifyPage parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 算力秘籍*/
+ (void)JJSecretBooksCompletion:(YSCompleteHandler)completion{
    

    [[SDDispatchingCenter sharedCenter] GET:JJSecretBooks parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 算力任务*/
+ (void)JJSafetyTaskCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJSafetyTask parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJTaskModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}







/** 认购记录*/
+ (void)JJMobileMemberOrderOrderList:(NSString *)orderStatus page:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(page);
    parameters[@"pageSize"] = @"10";
    parameters[@"orderStatus"] = orderStatus;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderOrderList parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *model = [JJBuyCoinListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}



/** 算力流水*/
+ (void)JJCountRecord:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(page);
    parameters[@"pageSize"] = @"10";
    [[SDDispatchingCenter sharedCenter] GET:JJCountRecord parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *model = [JJMineCalculateModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 邀请列表*/
+ (void)JJMobileMemberMyTeam:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(page);
    parameters[@"pageSize"] = @"10";
    [[SDDispatchingCenter sharedCenter] GET:JJMobileMemberMyTeam parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *model = [JJInveterModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"xiangqing"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 兑换价格*/
+ (void)JJMobileMemberOrderEthNumber:(NSString *)buyNumber Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"buyNumber"] = buyNumber;

    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOrderEthNumber parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 算力说明*/
+ (void)JJIntroduction:(NSString *)coinId Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"coinId"] = coinId;
    
    [[SDDispatchingCenter sharedCenter] GET:JJIntroduction parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}







@end
