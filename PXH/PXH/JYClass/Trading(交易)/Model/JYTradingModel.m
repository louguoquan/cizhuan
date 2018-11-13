//
//  YSTradingModel.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "JYTradingModel.h"

@implementation JYTradingModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"buy" : [JYTradingBuyOreSellModel class],
             @"sell":[JYTradingBuyOreSellModel class]
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"price" : @"newPrice"};
}


@end


@implementation JYTradingBuyOreSellModel

@end
