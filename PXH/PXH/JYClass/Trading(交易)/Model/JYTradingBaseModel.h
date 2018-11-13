//
//  JYTradingBaseModel.h
//  PXH
//
//  Created by louguoquan on 2018/6/15.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYTradingBaseModel : NSObject

@property (nonatomic,strong)NSString *keyongjiaoyi;
@property (nonatomic,strong)NSString * jiaoyie;
@property (nonatomic,strong)NSString * dongjiechiyou;
@property (nonatomic,strong)NSString * lilv;
@property (nonatomic,strong)NSString * kemai;

@property (nonatomic,strong)NSString * jiaoyidanjia;
@property (nonatomic,strong)NSString * dongjiejiaoyi;
@property (nonatomic,strong)NSString * keyongchiyou;
@property (nonatomic,strong)NSString * dengzhi;
@property (nonatomic,assign)BOOL isCollect;

/*
 "keyongjiaoyi": 0,
 "jiaoyie": 0,
 "dongjiechiyou": 0,
 "lilv": 0.002,
 "kemai": 0,
 "jiaoyidanjia": 0.6868,
 "dongjiejiaoyi": 0,
 "keyongchiyou": 0
 
 */
@end
