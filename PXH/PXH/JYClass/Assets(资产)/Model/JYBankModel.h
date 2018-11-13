//
//  JYBankModel.h
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYBankModel : NSObject

@property (nonatomic,strong)NSString *bank;
@property (nonatomic,strong)NSString *branch;
@property (nonatomic,strong)NSString *cardNumber;
@property (nonatomic,strong)NSString *ct;
@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)NSString *payee;
@property (nonatomic,strong)NSString *remarks;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *ut;


/*
 
 "bank": "中国农业银行",
 "branch": "西湖区支行",
 "cardNumber": "62220212058205896358",
 "ct": "",
 "id": 1,
 
 "payee": "叮叮当",
 "remarks": "",
 "status": "",
 "ut": ""
 */


@end
