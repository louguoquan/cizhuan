//
//  YSProductDetail.m
//  PXH
//
//  Created by yu on 2017/8/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductDetail.h"

@implementation YSProductImage


@end

@implementation YSProductDetail

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"comments" : [YSProductComment class],
             @"normals" : [YSStandard class],
             @"images" : [YSProductImage class],
             @"products" : [YSProduct class]};
}

@end
