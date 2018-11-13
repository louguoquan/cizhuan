//
//  JJTransformModel.h
//  PXH
//
//  Created by louguoquan on 2018/8/2.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJTransforminfoCoinModel;
@interface JJTransformModel : NSObject

@property (nonatomic,strong)NSString *ReleaseAssets;
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *fold;
@property (nonatomic,strong)JJTransforminfoCoinModel *infoCoin;

@end

@interface JJTransforminfoCoinModel : NSObject

@property (nonatomic,strong)NSString *blockQuery;
@property (nonatomic,strong)NSString *btcLastGains;
@property (nonatomic,strong)NSString *btcPrice;
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *coinDesc;

@property (nonatomic,strong)NSString *coinId;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *crowdfundingPrice;
@property (nonatomic,strong)NSString *fee;
//@property (nonatomic,strong)NSString *fold;

@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *minExchangeNum;
@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *officialWebsite;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *publishSummary;
@property (nonatomic,strong)NSString *publishTime;
@property (nonatomic,strong)NSString *referPrice;

@property (nonatomic,strong)NSString *simpleDesc;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *totalCirculation;
@property (nonatomic,strong)NSString *totalSales;
@property (nonatomic,strong)NSString *updateTime;

@property (nonatomic,strong)NSString *usdtLastGains;
@property (nonatomic,strong)NSString *usdtPrice;
@property (nonatomic,strong)NSString *whitePaper;
@property (nonatomic,strong)NSString *yesterdaySales;
//
//
//blockQuery = "";
//btcLastGains = "";
//btcPrice = "";
//code = MAG;
//coinDesc = "";

//coinId = "";
//createTime = "";
//crowdfundingPrice = "";
//"currency_type" = "";
//fee = "";

//id = 8;
//image = "";
//isDelete = 0;
//minExchangeNum = "";
//name = MAG;

//officialWebsite = "";
//price = "";
//publishSummary = "";
//publishTime = "";
//referPrice = "";

//simpleDesc = "";
//status = "";
//totalCirculation = "";
//totalSales = "";
//updateTime = "";

//usdtLastGains = "";
//usdtPrice = "";
//whitePaper = "";
//yesterdaySales = "";


@end
