//
//  YSCategory.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCategory.h"

@implementation YSCategory

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"children" : [YSCategory class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end
