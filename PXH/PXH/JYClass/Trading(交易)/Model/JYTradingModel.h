//
//  YSTradingModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYTradingBuyOreSellModel;

@interface JYTradingModel : NSObject

@property (nonatomic,strong)NSArray <JYTradingBuyOreSellModel *> *buy;
@property (nonatomic,strong)NSArray <JYTradingBuyOreSellModel *> *sell;

@property (nonatomic,strong)NSString  *price;
@property (nonatomic,strong)NSString  *rate;
@property (nonatomic,strong)NSString  *rmbPrice;

@end


@interface JYTradingBuyOreSellModel : NSObject

@property (nonatomic,strong)NSString  *buyType;
@property (nonatomic,strong)NSString  *coinNum;
@property (nonatomic,strong)NSString  *coinNumStr;
@property (nonatomic,strong)NSString  *remain;
@property (nonatomic,strong)NSString  *remainStr;
@property (nonatomic,strong)NSString  *coinType;
@property (nonatomic,strong)NSString  *createTime;
@property (nonatomic,strong)NSString  *tradeCoin;
@property (nonatomic,strong)NSString  *coinDeal;
@property (nonatomic,strong)NSString  *coinDealStr;
@property (nonatomic,strong)NSString  *tradePrice;
@property (nonatomic,strong)NSString  *tradePriceStr;

/*
 
 "buyType": 0,
 "coinNum": 20000,
 "coinType": 1,
 "createTime": "2018-06-13 01:58:34",
 "tradeCoin": 0,
 
 "tradePrice": 114000.016011054
 
 
 */



@end


