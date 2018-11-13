//
//  YSRefundsDetail.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRefundsDetail.h"

@implementation YSRefundsDetail

+ (NSString *)statusStringWithStatus:(NSInteger)status {
    switch (status) {
        case 0:
            return @"提交申请";
        case 1:
            return @"商户同意";
        case 2:
            return @"商户拒绝";
        case 3:
            return @"用户提交物流信息";
        case 4:
            return @"商户完成退款";
        case 6:
            return @"用户提交了物流信息";
        default:
            break;
    }
    return @"";
}
@end
