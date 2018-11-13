//
//  YSProductService.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductService.h"

@implementation YSProductService

/**
 获取产品列表  带分页
 */
+ (void)fetchProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kSearchProduct_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSProduct mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}

/**
 获取品牌
 */
+ (void)fetchBrands:(NSString *)catId completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"catId"] = catId;
    [[SDDispatchingCenter sharedCenter] POST:kBrands_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSBrands mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];

    }];
}


/**
 获取产品详情
 */
+ (void)fetchProductDetail:(NSString *)productId completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];

    parameters[@"memberId"] = USER_ID;
    parameters[@"productId"] = productId;
//    [[SDDispatchingCenter sharedCenter] POST:kProductDetail_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *result = responseObject[@"result"];
//        YSProductDetail *detail = [YSProductDetail mj_objectWithKeyValues:result];
//        if (completion) {
//            completion(detail, nil);
//        }
//    } failure:^(NSURLSessionDataTask *task, SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//    }];
    
    [[SDDispatchingCenter sharedCenter] GET:kProductDetail_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *result = responseObject[@"result"];
        YSProductDetail *detail = [YSProductDetail mj_objectWithKeyValues:result];
        if (completion) {
            completion(detail, nil);
        }        

    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 根据规格获取详情
 */
+ (void)fetchStandardDetail:(NSString *)specValueId productId:(NSString *)productId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"valueIds"] = specValueId;
    parameters[@"productId"] = productId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kStandardDetail_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSStandardDetail *detail = [YSStandardDetail mj_objectWithKeyValues:result];
        if (completion) {
            completion(detail, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取购物车产品
 */
+ (void)fetchCartProductList:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCartProductList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *result = responseObject[@"result"];
        NSArray *models = [YSCartProduct mj_objectArrayWithKeyValuesArray:result];
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
 获取购物车数量
 */
+ (void)fetchCartProductNum:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCartProductNum_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            NSDictionary *dic = [responseObject objectForKey:@"result"];
            completion(dic[@"num"], nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}

+ (void)fetchMessageNum:(YSCompleteHandler)completion
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter]POST:kMessageTotle_URL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (completion) {
            NSDictionary *dic = [responseObject objectForKey:@"result"];
            completion(dic[@"num"], nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}


/**
 修改购物车产品数量
 */
+ (void)updateCartProductCount:(NSInteger)count carId:(NSString *)carId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"carId"] = carId;
    parameters[@"num"] = @(count);
    [[SDDispatchingCenter sharedCenter] POST:kChangeProductCount_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}


/**
 删除购物车产品
 */
+ (void)deleteCartProduct:(NSString *)carId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"carIds"] = carId;
    [[SDDispatchingCenter sharedCenter] POST:kDeleteCartProduct_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 获取首页数据
 */
+ (void)fetchIndexDataWithCompletion:(YSCompleteHandler)completion {
    [[SDDispatchingCenter sharedCenter] POST:kIndexData_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        NSArray *advArray = [YSAdvertising mj_objectArrayWithKeyValuesArray:result[@"banners"]];
        NSArray *productArray = [YSSeckillProduct mj_objectArrayWithKeyValuesArray:result[@"limitCountProducts"]];
        if (completion) {
            completion(advArray, productArray);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
    }];
}

/**
 获取新首页数据
 */
+ (void)fetchIndexNewDataWithCompletion:(YSCompleteHandler)completion {
    [[SDDispatchingCenter sharedCenter] POST:kIndexData_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
//        NSArray *advArray = [YSAdvertising mj_objectArrayWithKeyValuesArray:result[@"banners"]];
//        NSArray *productArray = [YSSeckillProduct mj_objectArrayWithKeyValuesArray:result[@"limitCountProducts"]];
        if (completion) {
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
    }];
}


/**
 秒杀商品列表
 */
+ (void)fetchSeckillProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    [[SDDispatchingCenter sharedCenter] POST:kSeckillProduct_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSSeckillProduct mj_objectArrayWithKeyValuesArray:result];
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
 获取抢购时间
 */
+ (void)fetchLimitBuyTimeWithCompletion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kLimitBuyTime_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSLimitBuyTime mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


/**
 获取限时购产品列表
 */
+ (void)fetchPanicBuyProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    param[@"isIndex"] = @(1);
    [[SDDispatchingCenter sharedCenter] POST:kPanicBuyProduct_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSSeckillProduct mj_objectArrayWithKeyValuesArray:result];
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
 获取产品评论
 */
+ (void)fetchProductCommentList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    [[SDDispatchingCenter sharedCenter] POST:kProductCommentList_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSProductComment mj_objectArrayWithKeyValuesArray:result];
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
 收藏产品
 */
+ (void)collectionProduct:(NSString *)objId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"objId"] = objId;
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCollect_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}

/**
 获取收藏产品列表
 */
+ (void)fetchCollectProductList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
//    param[@"memberId"] = USER_ID;
    
    [[SDDispatchingCenter sharedCenter] POST:kCollectList_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSProduct mj_objectArrayWithKeyValuesArray:result];
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


@end
