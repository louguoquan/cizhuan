//
//  YSAddressService.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSAddress.h"

@interface YSAddressService : NSObject


/**
 保存收货地址
 */
+ (void)saveAddressWithProvinceId:(NSString *)provinceId
                           cityId:(NSString *)cityId
                       districtId:(NSString *)districtId
                         streetId:(NSString *)streetId
                          address:(NSString *)address
                             name:(NSString *)name
                           mobile:(NSString *)mobile
                        addressId:(NSString *)addressId
                       completion:(YSCompleteHandler)completion;



/**
 获取收货地址列表
 */
+ (void)fetchAddressListCompletion:(YSCompleteHandler)completion;

/**
 设置收货地址
 */
+ (void)setDefaultAddress:(NSString *)addressId completion:(YSCompleteHandler)completion;


/**
 删除地址
 */
+ (void)deleteAddress:(NSString *)addressId completion:(YSCompleteHandler)completion;

@end
