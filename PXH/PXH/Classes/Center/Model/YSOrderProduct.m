//
//  YSOrderProduct.m
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderProduct.h"

@implementation YSOrderProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        _extScore1 = 5;
        _extScore2 = 5;
        _extImages = [NSMutableArray array];
    }
    return self;
}

@end
