//
//  JJShopModel.h
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJShopModel : NSObject

@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSString *marketPrice;

@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *productStore;
@property (nonatomic,strong)NSString *saleCount;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *statusName;

@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *stage;
@property (nonatomic,strong)NSString *countNum;
@property (nonatomic,strong)NSString *countLimit;
@property (nonatomic,strong)NSString *remain;

@property (nonatomic,strong)NSString *tip;
@property (nonatomic,strong)NSString *total;
@property (nonatomic,strong)NSString *sendGift;
@property (nonatomic,strong)NSString *price;






/*
 "countLimit": 365,
 "countNum": 300,
 "desc": "按摩椅666",
 "id": 1,
 "image": "https://ws1.sinaimg.cn/large/9150e4e5ly1fsmm0sax2vj205u05iq3u.jpg",
 
 "images": "",
 "marketPrice": 0,
 "productName": "按摩椅A",
 "productStore": "",
 "remain": 983,
 
 "saleCount": 0,
 "sendGift": "挖矿序列号",
 "stage": "第一期",
 "status": 0,
 "statusName": "正常",
 
 "tip": "绑定送300算力",
 "total": 1000,
 "url": "http://baidu.com"*/

@end
