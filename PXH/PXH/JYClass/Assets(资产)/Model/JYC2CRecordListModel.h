//
//  JYC2CRecordListModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYC2CRecordListModel : NSObject

@property (nonatomic, copy) NSString    *bankId;
@property (nonatomic, copy) NSString    *buyProportion;
@property (nonatomic, copy) NSString    *buyerUserId;
@property (nonatomic, copy) NSString    *certificateImg;
@property (nonatomic, copy) NSString    *collectId;

@property (nonatomic, copy) NSString    *confirmDate;
@property (nonatomic, copy) NSString    *createDate;
@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *currencyType;
@property (nonatomic, copy) NSString    *deleteDate;

@property (nonatomic, copy) NSString    *ID;
@property (nonatomic, copy) NSString    *ifDelete;
@property (nonatomic, copy) NSString    *isDelete;
@property (nonatomic, copy) NSString    *logtradeId;
@property (nonatomic, copy) NSString    *orderFee;

@property (nonatomic, copy) NSString    *orderNo;
@property (nonatomic, copy) NSString    *orderStatus;
@property (nonatomic, copy) NSString    *remark;
@property (nonatomic, copy) NSString    *sellerUserId;
@property (nonatomic, copy) NSString    *status;

@property (nonatomic, copy) NSString    *tradeId;
@property (nonatomic, copy) NSString    *tradeNum;
@property (nonatomic, copy) NSString    *tradePrice;
@property (nonatomic, copy) NSString    *tradeRefer;
@property (nonatomic, copy) NSString    *tradeType;

@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, copy) NSString    *usdtMoney;

@end

/*
{
    "bankId": null,
    "buyProportion": null,
    "buyerUserId": 19,
    "certificateImg": null,
    "collectId": null,
 
    "confirmDate": null,
    "createDate": null,
    "createTime": "2018-07-09 14:18:50",
    "currencyType": null,
    "deleteDate": null,
 
    "id": 106,
    "ifDelete": null,
    "isDelete": 0,
    "logtradeId": null,
    "orderFee": null,
 
    "orderNo": "sf311171299100",
    "orderStatus": 0,
    "remark": "00806100",
    "sellerUserId": null,
    "status": null,
 
    "tradeId": null,
    "tradeNum": 100,
    "tradePrice": 670,
    "tradeRefer": null,
    "tradeType": 0,
 
    "updateTime": "2018-07-09 14:18:50",
    "usdtMoney": 6.7
    }
*/
