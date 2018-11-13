//
//  JJShopService.m
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJShopService.h"


static NSString *JJMobileProductList = @"/mobile/product/list";
static NSString *JJMobileProductGetOneById = @"/mobile/product/getOneById";

static NSString *JJMobileCartConfirmOrder = @"/mobile/cart/confirmOrder";
static NSString *JJMobileCartCreateOrder = @"/mobile/cart/createOrder";

static NSString *JJMobileCardList = @"/mobile/card/list";

static NSString *JJMobileCardBind = @"/mobile/card/bind";
static NSString *JJMobileCardUnbind = @"/mobile/card/unbind";
static NSString *JJMobileCardBindAll = @"/mobile/card/bindAll";
static NSString *JJMobileGiftGiftList = @"/mobile/gift/giftList";
static NSString *JJMobileGiftUnlock = @"/mobile/gift/unlock";




@implementation JJShopService

/** 商品列表 */
+ (void)JJMobileProductListCompletion:(YSCompleteHandler)completion{
    
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileProductList parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJShopModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 商品详情 */
+ (void)JJMobileProductGetOneById:(NSString *)Pid Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = Pid;
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileProductGetOneById parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJShopModel *array = [JJShopModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 确认订单页面 */
+ (void)JJMobileCartConfirmOrder:(NSString *)productId num:(NSInteger )num Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = productId;
    param[@"num"] = @(num);
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCartConfirmOrder parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJOrderBaseModel *array = [JJOrderBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 创建订单 */
+ (void)JJMobileCartCreateOrder:(NSString *)productId num:(NSString *)num payPwd:(NSString *)payPwd msgCode:(NSString *)msgCode Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"productId"] = productId;
    param[@"num"] = num;
    param[@"payPwd"] = payPwd;
    param[@"msgCode"] = msgCode;
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCartCreateOrder parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJOrderBaseModel *array = [JJOrderBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 算力卡列表 */
+ (void)JJMobileCardList:(NSString *)type Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCardList parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJCardListModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 绑定算力卡 */
+ (void)JJMobileCardBind:(NSString *)ID Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = ID;
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCardBind parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 解绑算力卡 */
+ (void)JJMobileCardUnbind:(NSString *)ID Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = ID;
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCardUnbind parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {

        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 绑定所有算力卡 */
+ (void)JJMobileCardBindAllCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCardBindAll parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 赠送币列表*/
+ (void)JJMobileGiftGiftListCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileGiftGiftList parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JJGiftModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 解锁赠送币*/
+ (void)JJMobileGiftUnlock:(NSString *)ID Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"giftId"] = ID;
    [[SDDispatchingCenter sharedCenter] GET:JJMobileGiftUnlock parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}













@end
