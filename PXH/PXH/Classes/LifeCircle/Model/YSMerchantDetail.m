//
//  YSMerchantDetail.m
//  PXH
//
//  Created by yu on 2017/8/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantDetail.h"

@implementation YSLifeCoupons

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end

@implementation YSMerchantDetail

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"coupons" : [YSLifeCoupons class]};
}

@end
