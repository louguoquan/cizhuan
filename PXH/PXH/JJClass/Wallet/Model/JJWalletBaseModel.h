//
//  JJWalletBaseModel.h
//  PXH
//
//  Created by louguoquan on 2018/8/1.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJWalletModel.h"

@class JJMachModel;

@interface JJWalletBaseModel : NSObject

@property (nonatomic,strong)NSArray <JJWalletModel *> *infoCoin;
@property (nonatomic,strong)JJMachModel *mag;
@property (nonatomic,strong)NSString *totaFoid;
@property (nonatomic,assign)NSInteger machopen;

@end


@interface JJMachModel : NSObject


@property (nonatomic,strong)NSString *countNum;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *fold;
@property (nonatomic,strong)NSString *freezingTime;
@property (nonatomic,strong)NSString *frozenAssets;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *lockAssets;
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *payPassword;
@property (nonatomic,strong)NSString *releaseAssets;

@property (nonatomic,strong)NSString *staue;
@property (nonatomic,strong)NSString *totaAssets;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *currentPrice;

@end

