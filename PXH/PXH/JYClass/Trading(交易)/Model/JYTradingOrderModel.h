//
//  JYTradingOrderModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/27.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYTradingOrderModel : NSObject

@property (nonatomic,strong)NSString *buyType;
@property (nonatomic,strong)NSString *coinName;
@property (nonatomic,strong)NSString *coinNum;
@property (nonatomic,strong)NSString *coinNumStr;
@property (nonatomic,strong)NSString *coinType;
@property (nonatomic,strong)NSString *createTime;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *realTrade;
@property (nonatomic,strong)NSString *tradeCoin;
@property (nonatomic,strong)NSString *tradeCoinName;

@property (nonatomic,strong)NSString *tradeNum;
@property (nonatomic,strong)NSString *tradePrice;
@property (nonatomic,strong)NSString *tradePriceStr;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *coinDeal;

@property (nonatomic,strong)NSString *isDeal;
@property (nonatomic,strong)NSString *longTradePrice;
@property (nonatomic,strong)NSString *priceDeal;
@property (nonatomic,strong)NSString *totalDeal;
@property (nonatomic,strong)NSString *fee;
@property (nonatomic,strong)NSString *average;

/*
 "buyType": 1,
 "coinDeal": 0,
 "coinName": "btc",
 "coinNum": 100,
 "coinType": 1,
 "createTime": "2018-06-13 01:59:54",
 "id": 71,
 "isDeal": 1,
 "isDelete": 1,
 "longTradePrice": 10000000000,
 "priceDeal": "",
 "realTrade": 10,
 "totalDeal": 0,
 "tradeCoin": 0,
 "tradeCoinName": "",
 "tradeNum": 0.1,
 "tradePrice": 0.1,
 "updateTime": "2018-06-13 01:59:54",
 "userId": 18
 */

@end
