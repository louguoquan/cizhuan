//
//  JJBuyModel.h
//  PXH
//
//  Created by louguoquan on 2018/7/31.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJOrderRedayModel;

@interface JJBuyModel : NSObject

@property (nonatomic,strong)NSString *ethAddress;
@property (nonatomic,strong)NSString *ethQRURL;
@property (nonatomic,strong)JJOrderRedayModel *order;

//ethAddress = ashdqwuygdh;
//ethQRURL = "http://machdary.org/whitepaper/ETH.png";
//order =         {
//    bank = "";
//    branch = "";
//    buyNumber = 100;
//    cardNumber = "";
//    ct = "2018-07-31 10:36:48";
//    id = 2;
//    memberId = 8;
//    orderNo = 20180731103648054001;
//    orderStatus = 0;
//    payNumber = "";
//    payPrice = "0.0167";
//    payee = "";
//    remark = "";
//    staue = "";
//    type = 2;
//};

@end

@interface JJOrderRedayModel : NSObject


@property (nonatomic,strong)NSString *bank;
@property (nonatomic,strong)NSString *branch;
@property (nonatomic,strong)NSString *buyNumber;
@property (nonatomic,strong)NSString *cardNumber;
@property (nonatomic,strong)NSString *ct;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,strong)NSString *payNumber;

@property (nonatomic,strong)NSString *payPrice;
@property (nonatomic,strong)NSString *payee;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *staue;
@property (nonatomic,strong)NSString *type;

@end


