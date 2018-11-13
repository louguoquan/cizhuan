//
//  JYRechargeModel.h
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYRechargeModel : NSObject

@property (nonatomic, copy) NSString        *coinTypeId;
@property (nonatomic, copy) NSString        *createTime;
@property (nonatomic, copy) NSString        *ID;
@property (nonatomic, copy) NSString        *isDelete;
@property (nonatomic, copy) NSString        *presentAmount;

@property (nonatomic, copy) NSString        *rechargeAmount;
@property (nonatomic, copy) NSString        *rechargeDate;
@property (nonatomic, copy) NSString        *rechargeStatus;
@property (nonatomic, copy) NSString        *remark;
@property (nonatomic, copy) NSString        *status;

@property (nonatomic, copy) NSString        *trade_id;
@property (nonatomic, copy) NSString        *updateTime;
@property (nonatomic, copy) NSString        *userId;

@property (nonatomic, copy) NSString        *coinCode;


@end

/*
 {
 "coinTypeId": 1,
 "createTime": null,
 "id": 2,
 "isDelete": 0,
 "presentAmount": 0.0001,
 "rechargeAmount": 0.0002,
 "rechargeDate": "2018-07-03 19:23:07",
 "rechargeStatus": null,
 "remark": null,
 "status": "2",
 "trade_id": null,
 "updateTime": null,
 "userId": 19
 }
 */
