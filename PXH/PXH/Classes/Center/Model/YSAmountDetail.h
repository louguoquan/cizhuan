//
//  YSAmountDetail.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAmountDetail : NSObject

@property (nonatomic, strong) NSString  *memberId;

@property (nonatomic, strong) NSString  *type;

@property (nonatomic, strong) NSString  *orderId;

@property (nonatomic, assign) CGFloat   amount;

@property (nonatomic, strong) NSString  *memo;

@property (nonatomic, strong) NSString  *time;

@property (nonatomic, strong) NSString  *desc;


//"memberId": 1,
//"type": 2,
//"orderId": null,
//"amount": 0.5,
//"memo": "签到赠送",
//"time": "2017-08-23 16:22:16",
//"desc": "签到赠送"

@end
