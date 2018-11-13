//
//  JYKlineHeaderModel.m
//  PXH
//
//  Created by louguoquan on 2018/7/5.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYKlineHeaderModel.h"

@implementation JYKlineHeaderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"price" : @"newPrice"};
}

@end
