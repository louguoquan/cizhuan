//
//  YSOrder.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSOrder.h"
#import "NSDictionary+Sunday.h"

@implementation YSOrder

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items" : [YSOrderProduct class]};
}

+ (NSString *)statusStringForStatus:(NSInteger)status {
    static dispatch_once_t onceToken;
    static NSDictionary *dict = nil;
    dispatch_once(&onceToken, ^{
        dict = @{@"0":@"待付款", @"1":@"待发货", @"2":@"待收货", @"3":@"待评价", @"4":@"交易关闭", @"5":@"正在退款", @"6":@"交易取消", @"7":@"已退款", @"8":@"正在退货", @"9":@"已退货", @"10":@"已完成", @"11":@"待自提"};
    });
    
    return [dict stringValueForKey:[NSString stringWithFormat:@"%zd", status] default:@""];
}

@end
