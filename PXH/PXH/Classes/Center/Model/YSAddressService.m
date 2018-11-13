//
//  YSAddressService.m
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAddressService.h"

@implementation YSAddressService

+ (void)saveAddressWithProvinceId:(NSString *)provinceId
                           cityId:(NSString *)cityId
                       districtId:(NSString *)districtId
                         streetId:(NSString *)streetId
                          address:(NSString *)address
                             name:(NSString *)name
                           mobile:(NSString *)mobile
                        addressId:(NSString *)addressId
                       completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"provinceId"] = provinceId;
    parameters[@"cityId"] = cityId;
    parameters[@"districtId"] = districtId;
    parameters[@"streetId"] = streetId;
    parameters[@"address"] = address;
    parameters[@"name"] = name;
    parameters[@"mobile"] = mobile;
    parameters[@"addressId"] = addressId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kSaveAddress_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            NSDictionary *result = responseObject[@"result"];
            YSAddress *address = [YSAddress mj_objectWithKeyValues:result];
            completion(address, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 获取收货地址列表
 */
+ (void)fetchAddressListCompletion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kAddressList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSAddress mj_objectArrayWithKeyValuesArray:result];
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
 设置收货地址
 */
+ (void)setDefaultAddress:(NSString *)addressId completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"addressId"] = addressId;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kSetDefaultAddress_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 删除地址
 */
+ (void)deleteAddress:(NSString *)addressId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"addressId"] = addressId;
    [[SDDispatchingCenter sharedCenter] POST:kDeleteAddress_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

@end

