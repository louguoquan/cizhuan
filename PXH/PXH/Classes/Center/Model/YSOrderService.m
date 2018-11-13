//
//  YSOrderService.m
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderService.h"

@implementation YSOrderService

/**
    立即购买
 */
+ (void)commitOrderFromProduct:(NSString *)productId
                      normalId:(NSString *)normalId
                        number:(NSInteger)num
                    completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:4];
    parameters[@"productId"] = productId;
    parameters[@"num"] = @(num);
    parameters[@"memberId"] = USER_ID;
    parameters[@"normalId"] = normalId;
    [[SDDispatchingCenter sharedCenter] POST:kBuyNow_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSOrderSettleModel *model = [YSOrderSettleModel mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
       
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 购物车结算
 */
+ (void)commitOrderFromCart:(NSString *)carIds completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"carIds"] = carIds;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kCartSettle_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSOrderSettleModel *model = [YSOrderSettleModel mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
           [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}


/**
 加入购物车
 */
+ (void)addProductToShoppingCart:(NSString *)productId
                      standardId:(NSString *)standardId
                          number:(NSInteger)number
                      completion:(YSCompleteHandler)completion {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:4];
    parameters[@"productId"] = productId;
    parameters[@"num"] = @(number);
    parameters[@"memberId"] = USER_ID;
    parameters[@"normalId"] = standardId;
    [[SDDispatchingCenter sharedCenter] POST:kAddToCart_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(nil, nil);
        }

    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}

/**
 根据收货地址获取服务点
 */
+ (void)fetchServiceStationList:(NSDictionary *)parameters
                           page:(NSInteger)page
                     completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    [[SDDispatchingCenter sharedCenter] POST:kServiceStationByAddress_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSServiceStation mj_objectArrayWithKeyValuesArray:result];
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
 立即购买创建订单
 */
+ (void)buyNowCreateOrderWithProductId:(NSString *)productId
                                   num:(NSInteger)num
                             serviceId:(NSString *)serviceId
                               isSince:(BOOL)isSince
                              normalId:(NSString *)normalId
                             addressId:(NSString *)addressId
                          pledgeMethod:(BOOL)pledgeMethod
                              couponId:(NSString *)couponId
                                  memo:(NSString *)memo
                            completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"productId"] = productId;
    parameters[@"num"] = @(num);
    parameters[@"serviceId"] = serviceId;
    parameters[@"isSince"] = @(isSince);
    parameters[@"normalId"] = normalId;
    parameters[@"memberId"] = USER_ID;
    parameters[@"addressId"] = addressId;
    parameters[@"pledgeMethod"] = pledgeMethod ? @(1) : nil;
    parameters[@"couponId"] = couponId;
    parameters[@"memo"] = memo;
    [[SDDispatchingCenter sharedCenter] POST:kBuyNowCreateOrder_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        if (completion) {
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 购物车创建订单
 */
+ (void)shoppingCartCreateOrderWithCarIds:(NSString *)carIds
                                serviceId:(NSString *)serviceId
                                  isSince:(BOOL)isSince
                                addressId:(NSString *)addressId
                             pledgeMethod:(BOOL)pledgeMethod
                                 couponId:(NSString *)couponId
                                     memo:(NSString *)memo
                               completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"carIds"] = carIds;
    parameters[@"serviceId"] = serviceId;
    parameters[@"isSince"] = @(isSince);
    parameters[@"memberId"] = USER_ID;
    parameters[@"addressId"] = addressId;
    parameters[@"pledgeMethod"] = pledgeMethod ? @(1) : nil;
    parameters[@"couponId"] = couponId;
    parameters[@"memos"] = memo;
    [[SDDispatchingCenter sharedCenter] POST:kCartCreateOrder_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        if (completion) {
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取订单列表
 */
+ (void)fetchOrderList:(NSDictionary *)param page:(NSInteger)page completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:param];
    parameters[@"page"] = @(page);
    parameters[@"rows"] = @(10);
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kOrderList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSOrder mj_objectArrayWithKeyValuesArray:result];
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
 获取订单详情
 */
+ (void)fetchOrderDetail:(NSString *)orderId completion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kOrderDetail_URL parameters:@{@"orderId" : orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSOrder *order = [YSOrder mj_objectWithKeyValues:result];
        if (order.orderId && completion) {
            completion(order, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}
/**
    获取自提详情
 */
+ (void)fetchDeliverDetail:(NSString *)orderId completion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kDeliverDetail_URL parameters:@{@"orderId" : orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSDeliver mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 发起支付
 */
+ (void)orderPay:(NSString *)orderId payMethod:(NSInteger)payMethod payPassword:(NSString *)payPassword completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"orderId"] = orderId;
    parameters[@"payMethod"] = @(payMethod);
    parameters[@"payPassword"] = payPassword;
    [[SDDispatchingCenter sharedCenter] POST:kOrderPay_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject[@"result"], nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


/**
 充值
 */
+ (void)recharge:(NSString *)amount payMethod:(NSInteger)payMethod completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"amount"] = amount;
    parameters[@"payMethod"] = @(payMethod);
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kRecharge_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject[@"result"], nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 更新订单状态
 */
+ (void)updateOrderStatus:(NSString *)urlString parameters:(NSMutableDictionary *)parameters completion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 发布订单评价
 */
+ (void)orderComment:(NSString *)orderId json:(NSString *)json completion:(YSCompleteHandler)completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = USER_ID;
    params[@"orderId"] = orderId;
    params[@"json"] = json;
    [[SDDispatchingCenter sharedCenter] POST:kOrderComment_URL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}


/**
 申请退货
 */
+ (void)refundsApply:(NSString *)orderId
                type:(NSInteger)type
              reason:(NSString *)reason
              mobile:(NSString *)mobile
                desc:(NSString *)desc
              amount:(NSString *)amount
              images:(NSString *)images
          completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"orderId"] = orderId;
    parameters[@"type"] = @(type);
    parameters[@"reason"] = reason;
    parameters[@"mobile"] = mobile;
    parameters[@"desc"] = desc;
    parameters[@"amount"] = amount;
    parameters[@"images"] = images;
    [[SDDispatchingCenter sharedCenter] POST:kRefundsApply_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取售后详情
 */
+ (void)fetchOrderRefundsDetail:(NSString *)orderId completion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kRefundsDetail_URL parameters:@{@"orderId" : orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSRefundsDetail *detail = [YSRefundsDetail mj_objectWithKeyValues:result];
        if (completion) {
            completion(detail, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}
/**
 撤销退款
 */
+ (void)fetchOrderCancelRefunds:(NSString *)orderId completion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:kCancelRefunds_URL parameters:@{@"customerServiceId" : orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取订单数量
 */
+ (void)fetchOrderCountWithCompletion:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kOrderCount_URL parameters:@{@"memberId" : USER_ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        if (completion) {
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


@end
