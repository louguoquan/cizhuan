//
//  JYBussinessModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBussinessModel : NSObject

@property (nonatomic,strong)NSString *buyMatchId;
@property (nonatomic,strong)NSString *buyerUserId;
@property (nonatomic,strong)NSString *coinDeal;
@property (nonatomic,strong)NSString *coinType;
@property (nonatomic,strong)NSString *timeString;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *orderFee;
@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic,strong)NSString *orderStatus;

@property (nonatomic,strong)NSString *priceDeal;
@property (nonatomic,strong)NSString *sellMatchId;
@property (nonatomic,strong)NSString *sellerUserId;
@property (nonatomic,strong)NSString *totalDeal;
@property (nonatomic,strong)NSString *tradeCoin;

@property (nonatomic,strong)NSString *direction;
@property (nonatomic,strong)NSString *tradeNum;
@property (nonatomic,strong)NSString *tradePrice;
@property (nonatomic,strong)NSString *tradeNumStr;
@property (nonatomic,strong)NSString *tradePriceStr;
@property (nonatomic,strong)NSString *updateTime;


@end
