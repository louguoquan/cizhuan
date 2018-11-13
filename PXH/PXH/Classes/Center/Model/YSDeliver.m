//
//  YSDeliver.m
//  PXH
//
//  Created by futurearn on 2017/11/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDeliver.h"

@implementation YSDeliver

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = key;
    }
}

@end
