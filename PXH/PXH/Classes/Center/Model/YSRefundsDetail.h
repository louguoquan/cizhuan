//
//  YSRefundsDetail.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRefundsDetail : NSObject

@property (nonatomic, strong) NSString  *customerServiceId; //售后id

@property (nonatomic, strong) NSString  *reason;//原因

@property (nonatomic, strong) NSString  *desc;//说明

@property (nonatomic, assign) NSInteger status;//状态  0提交申请  1商户同意  2商户拒绝  3用户提交物流信息 4商户完成退款 6用户提交了物流信息

@property (nonatomic, strong) NSString  *refuseReason;//商户拒绝原因

@property (nonatomic, strong) NSString  *sellerAddress;//商户地址(用户退货时用)

@property (nonatomic, strong) NSString  *express;//物流公司

@property (nonatomic, strong) NSString  *expressNo;//物流编号

@property (nonatomic, strong) NSString  *time;

@property (nonatomic, assign) CGFloat   amount;

    //1、退款  2、退货
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString  *mobile;

+ (NSString *)statusStringWithStatus:(NSInteger)status;

@end
