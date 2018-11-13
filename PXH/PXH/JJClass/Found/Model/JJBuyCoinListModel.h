//
//  JJBuyCoinListModel.h
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJBuyCoinListModel : NSObject

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
