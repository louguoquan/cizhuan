//
//  YSAssetsModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYAssetsModel : NSObject

@property (nonatomic,strong)NSString *allocateDate;
@property (nonatomic,strong)NSString *balance;
@property (nonatomic,strong)NSString *coinCode;
@property (nonatomic,strong)NSString *coinName;
@property (nonatomic,strong)NSString *coinTypeId;

@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *fold;
@property (nonatomic,strong)NSString *freezeBalance;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *isDelete;

@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *total;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *userId;

@property (nonatomic,strong)NSString *userType;
@property (nonatomic,strong)NSString *walletAddress;
@property (nonatomic,strong)NSString *minExchangeNum;//最低提币量

@property (nonatomic,strong)NSString *tradeStatus;
@property (nonatomic,strong)NSString *withdrawStatus;
@property (nonatomic,strong)NSString *chargeStatus;
@property (nonatomic,strong)NSString *c2cStatus;





/*
 
 allocateDate = "";
 balance = 9;
 coinCode = bcd;
 coinName = bcd;
 coinTypeId = 2;
 
 createTime = "2018-06-06 17:31:58";
 fold = 20;
 freezeBalance = 1;
 id = 2;
 isDelete = 0;
 
 remark = "";
 status = 0;
 total = 10;
 updateTime = "";
 userId = 19;
 
 userType = 0;
 walletAddress = ddwwdwwddwdddwd115151;
 */



@end
