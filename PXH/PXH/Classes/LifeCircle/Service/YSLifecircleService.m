
//
//  YSLifecircleService.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLifecircleService.h"

@implementation YSLifecircleService

+ (void)fetchLifeIndexData:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kLifeCircle_URL parameters:@{@"memberId":[YSAccount sharedAccount].ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSLifeCircleModel *model = [YSLifeCircleModel mj_objectWithKeyValues:result];
        NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result[@"shops"]];
        if (completion) {
            completion(model, merchants);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, nil);
        }
    }];
}

+ (void)fetchLifeSearch:(NSDictionary *)parameters completion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:kMerchantsList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(nil, merchants);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, nil);
        }
    }];
}


/**
 分页获取店铺
 */
+ (void)fetchMerchantsList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    [[SDDispatchingCenter sharedCenter] POST:kMerchantsList_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}

/**
 获取商户详情
 */
+ (void)fetchShopDetail:(NSString *)shopId completion:(YSCompleteHandler)completion {
 
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"shopId"] = shopId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kShopDetail_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSMerchantDetail *detail = [YSMerchantDetail mj_objectWithKeyValues:result];
        if (completion) {
            completion(detail, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取优惠券列表
 */
+ (void)fetchCouponsList:(NSDictionary *)param page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:param];
    parameters[@"page"] = @(page);
    parameters[@"rows"] = @(10);
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCouponsList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSCoupons mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        if (completion) {
            completion(nil, error);
        }
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/**
 使用电子券
 */
+ (void)fetchUseCoupon:(NSString *)couponId completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"memberCouponId"] = couponId;
    [[SDDispatchingCenter sharedCenter]POST:kCouponUse_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 兑换电子券
 */
+ (void)couponExchange:(NSString *)couponId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"couponId"] = couponId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCouponExchange_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}


/**
 优惠券评价
 */
+ (void)couponComment:(NSDictionary *)parameters completion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kCouponComment_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
    获取评价列表
 */
+ (void)fetchGetCouponCommentURL:(NSString *)url parameters:(NSDictionary *)parameters completion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *result = responseObject[@"result"];
//        YSProductComment *detail = [YSProductComment mj_objectWithKeyValues:result];
//        if (completion) {
//            completion(detail, nil);
//        }
        NSArray *result = responseObject[@"result"];
        NSMutableArray *resultArray = [NSMutableArray array];
        if (result.count != 0) {
            for (NSDictionary *dic in result) {
                YSProductComment *comment = [YSProductComment mj_objectWithKeyValues:dic];
                [resultArray addObject:comment];
            }
            if (completion) {
                completion(resultArray, nil);
            }
        } else {
            [MBProgressHUD showErrorMessage:@"暂无评价哟" toContainer:nil];
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取优惠券详情
 */
+ (void)fetchCouponDetail:(NSString *)couponId completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"couponId"] = couponId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCouponDetail_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSProductDetail *detail = [YSProductDetail mj_objectWithKeyValues:result];
        if (completion) {
            completion(detail, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


@end
