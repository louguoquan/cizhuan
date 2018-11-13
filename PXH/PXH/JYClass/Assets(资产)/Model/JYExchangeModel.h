//
//  JYExchangeModel.h
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYExchangeModel : NSObject

@property (nonatomic, copy) NSString    *afterBalance;
@property (nonatomic, copy) NSString    *afterFreeze;
@property (nonatomic, copy) NSString    *amount;
@property (nonatomic, copy) NSString    *beforeBalance;
@property (nonatomic, copy) NSString    *coinTypeId;

@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *ID;
@property (nonatomic, copy) NSString    *isDelete;
@property (nonatomic, copy) NSString    *remark;
@property (nonatomic, copy) NSString    *status;

@property (nonatomic, copy) NSString    *toAddress;
@property (nonatomic, copy) NSString    *tradeFee;
@property (nonatomic, copy) NSString    *tradeId;
@property (nonatomic, copy) NSString    *tradeStatus;
@property (nonatomic, copy) NSString    *tradeTime;

@property (nonatomic, copy) NSString    *tradeType;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, copy) NSString    *userId;

@property (nonatomic, copy) NSString    *coinCode;


@end

/*
 {
 "afterBalance": 8.999,
 "afterFreeze": 2.001,
 "amount": 0.999,
 "beforeBalance": 10,
 "beforeFreeze": 1,
 "coinTypeId": 1,
 "createTime": "2018-06-26 15:26:31",
 "id": 1,
 "isDelete": 0,
 "remark": null,
 "status": null,
 "toAddress": "ddwwdwwddwdddwd115151",
 "tradeFee": null,
 "tradeId": null,
 "tradeStatus": null,
 "tradeTime": null,
 "tradeType": 0,
 "updateTime": null,
 "userId": 21
 }
 */
