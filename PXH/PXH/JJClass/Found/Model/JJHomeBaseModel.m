//
//  JJHomeBaseModel.m
//  PXH
//
//  Created by louguoquan on 2018/8/2.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJHomeBaseModel.h"

@implementation JJHomeBaseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"broadcast" : [JJHomeModel class],@"whitepaper":[JJHomeModel class]
             };
}


@end
