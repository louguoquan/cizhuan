//
//  JYBuyOrderListModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBuyOrderListModel : NSObject


@property (nonatomic,strong)NSString *bankId;
@property (nonatomic,strong)NSString *buyProportion;
@property (nonatomic,strong)NSString *buyerUserId;
@property (nonatomic,strong)NSString *certificateImg;
@property (nonatomic,strong)NSString *collectId;

@property (nonatomic,strong)NSString *confirmDate;
@property (nonatomic,strong)NSString *createDate;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *currencyType;
@property (nonatomic,strong)NSString *deleteDate;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *ifDelete;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *logtradeId;
@property (nonatomic,strong)NSString *orderFee;


@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *sellerUserId;
@property (nonatomic,strong)NSString *status;

@property (nonatomic,strong)NSString *tradeId;
@property (nonatomic,strong)NSString *tradeNum;
@property (nonatomic,strong)NSString *tradePrice;
@property (nonatomic,strong)NSString *tradeType;
@property (nonatomic,strong)NSString *updateTime;

@property (nonatomic,strong)NSString *usdtMoney;


/*
 
 "bankId": "",
 "buyProportion": "",
 "buyerUserId": 18,
 "certificateImg": "",
 "collectId": "",
 
 
 "confirmDate": "",
 "createDate": "",
 "createTime": "2018-06-05 17:25:28",
 "currencyType": "",
 "deleteDate": "",
 
 "id": 2,
 "ifDelete": "",
 "isDelete": 0,
 "logtradeId": "",
 "orderFee": "",
 
 "orderNo": "5t2819072860",
 "orderStatus": 0,
 "remark": "113260",
 "sellerUserId": "",
 "status": "",
 
 "tradeId": "",
 "tradeNum": 1,
 "tradePrice": "",
 "tradeType": 0,
 "updateTime": "2018-06-05 17:25:28",
 
 "usdtMoney": 6.7
 */




@end
