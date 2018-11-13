//
//  JJCalculateBallModel.m
//  PXH
//
//  Created by louguoquan on 2018/7/30.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateBallModel.h"

@implementation JJCalculateBallModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end

@implementation JJCalculateBallBaseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"dayReward" : [JJCalculateBallModel class]
             };
}


@end
