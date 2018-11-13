//
//  YSMarketModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYMarketModel : NSObject

@property (nonatomic,strong)NSString *blockQuery;
@property (nonatomic,strong)NSString *btcPrice;
@property (nonatomic,strong)NSString *btcPriceView;
@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *coinDesc;
@property (nonatomic,strong)NSString *createTime;

@property (nonatomic,strong)NSString *crowdfundingPrice;
@property (nonatomic,strong)NSString *crowdfundingPriceView;
@property (nonatomic,strong)NSString *currency_type;
@property (nonatomic,strong)NSString *fee;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *lastGains;
@property (nonatomic,strong)NSString *lastGainsView;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *coinId;
@property (nonatomic,strong)NSString *minExchangeNum;
@property (nonatomic,strong)NSString *minExchangeNumView;

@property (nonatomic,strong)NSString *officialWebsite;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *priceView;

@property (nonatomic,strong)NSString *publishSummary;
@property (nonatomic,strong)NSString *publishSummaryView;

@property (nonatomic,strong)NSString *publishTime;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *referPrice;
@property (nonatomic,strong)NSString *referPriceView;


@property (nonatomic,strong)NSString *totalCirculation;
@property (nonatomic,strong)NSString *totalCirculationView;

@property (nonatomic,strong)NSString *totalSales;
@property (nonatomic,strong)NSString *totalSalesView;

@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *usdtPrice;
@property (nonatomic,strong)NSString *usdtPriceView;

@property (nonatomic,strong)NSString *whitePaper;
@property (nonatomic,strong)NSString *yesterdaySales;
@property (nonatomic,strong)NSString *yesterdaySalesView;

@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *selfSort;

@property (nonatomic,strong)NSString *image;


@property (nonatomic,strong)NSString *tradeStatus;
@property (nonatomic,strong)NSString *withdrawStatus;
@property (nonatomic,strong)NSString *chargeStatus;

/*
 "blockQuery": "1",
 "btcPrice": 1,
 "code": "BTC",
 "coinDesc": "比特币",
 "createTime": "",
 
 "crowdfundingPrice": 1,
 "fee": 1,
 "id": 1,
 "isDelete": 0,
 "name": "btc",
 
 "officialWebsite": "1",
 "price": 1,
 "publishSummary": 10000,
 "publishTime": "",
 "status": 1,
 
 "totalCirculation": "",
 "updateTime": "",
 "usdtPrice": 1,
 "whitePaper": "1"
 */

@end
