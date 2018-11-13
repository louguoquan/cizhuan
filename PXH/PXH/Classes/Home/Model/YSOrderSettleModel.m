//
//  YSOrderSettleModel.m
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrderSettleModel.h"

@implementation YSSettleProduct

@end

@implementation YSOrderSettleModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"productDetails" : [YSSettleProduct class]};
    
}

@end
