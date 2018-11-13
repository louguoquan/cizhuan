//
//  JYCoinInfoModel.h
//  PXH
//
//  Created by LX on 2018/6/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCoinInfoModel : NSObject

@property (nonatomic, copy) NSString    *blockQuery;
@property (nonatomic, copy) NSString    *btcPrice;
@property (nonatomic, copy) NSString    *code;
@property (nonatomic, copy) NSString    *coinDesc;
@property (nonatomic, copy) NSString    *coinId;

@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *crowdfundingPrice;
@property (nonatomic, copy) NSString    *currency_type;
@property (nonatomic, copy) NSString    *fee;
@property (nonatomic, copy) NSString    *ID;

@property (nonatomic, copy) NSString    *image;
@property (nonatomic, copy) NSString    *isDelete;
@property (nonatomic, copy) NSString    *lastGains;
@property (nonatomic, copy) NSString    *minExchangeNum;
@property (nonatomic, copy) NSString    *name;

@property (nonatomic, copy) NSString    *officialWebsite;
@property (nonatomic, copy) NSString    *price;
@property (nonatomic, copy) NSString    *publishSummary;
@property (nonatomic, copy) NSString    *publishTime;
@property (nonatomic, copy) NSString    *referPrice;

@property (nonatomic, copy) NSString    *selfSort;
@property (nonatomic, copy) NSString    *simpleDesc;
@property (nonatomic, copy) NSString    *status;
@property (nonatomic, copy) NSString    *totalCirculation;
@property (nonatomic, copy) NSString    *totalSales;

@property (nonatomic, copy) NSString    *type;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, copy) NSString    *usdtPrice;
@property (nonatomic, copy) NSString    *whitePaper;
@property (nonatomic, copy) NSString    *yesterdaySales;

@end

/*
 {
 "blockQuery": "https://etherscan.io/",
 "btcPrice": 100,
 "code": "ETH",
 "coinDesc": "http://web.asfinex.com/eth",
 "coinId": null,
 "createTime": null,
 "crowdfundingPrice": 2,
 "currency_type": 0,
 "fee": 2,
 "id": 3,
 "image": null,
 "isDelete": 0,
 "lastGains": 2,
 "minExchangeNum": 0.001,
 "name": "以太坊",
 "officialWebsite": "https://www.ethereum.org/",
 "price": 2,
 "publishSummary": 300000,
 "publishTime": null,
 "referPrice": null,
 "selfSort": null,
 "simpleDesc":  以太坊|Ethereum被称为通用区块链计算机，概念诞生于2013年,
 "status": 1,
 "totalCirculation": null,
 "totalSales": 1,
 "type": null,
 "updateTime": "2018-07-06 14:19:02",
 "usdtPrice": 10,
 "whitePaper": "https://github.com/ethereum/wiki/wiki/%5BEnglish%5D-White-Paper",
 "yesterdaySales": 5
 }
 */
