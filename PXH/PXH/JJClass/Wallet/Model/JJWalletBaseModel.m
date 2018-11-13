//
//  JJWalletBaseModel.m
//  PXH
//
//  Created by louguoquan on 2018/8/1.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJWalletBaseModel.h"

@implementation JJWalletBaseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"infoCoin" : [JJWalletModel class]
             };
}

@end
