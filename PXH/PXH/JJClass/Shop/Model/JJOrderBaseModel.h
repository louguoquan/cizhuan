//
//  JJOrderBaseModel.h
//  PXH
//
//  Created by louguoquan on 2018/9/6.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJProductModel;

@interface JJOrderBaseModel : NSObject

@property (nonatomic,strong)NSString *countPrice;
@property (nonatomic,strong)NSString *countNum;
@property (nonatomic,strong)NSString *balance;
@property (nonatomic,strong)NSString *remain;
@property (nonatomic,strong)NSString *sendGift;

@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)JJProductModel *product;

@end


@interface JJProductModel : NSObject



@property (nonatomic,strong)NSString *appImg;
@property (nonatomic,strong)NSString *area;
@property (nonatomic,strong)NSString *barCode;
@property (nonatomic,strong)NSString *brandId;
@property (nonatomic,strong)NSString *brandName;

@property (nonatomic,strong)NSString *categoryId;
@property (nonatomic,strong)NSString *categoryName;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *costPrice;
@property (nonatomic,strong)NSString *countLimit;

@property (nonatomic,strong)NSString *countNum;
@property (nonatomic,strong)NSString *ct;
@property (nonatomic,strong)NSString *deleted;
@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *group;

@property (nonatomic,strong)NSString *groupMargin;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *image;
@property (nonatomic,strong)NSString *images;
@property (nonatomic,strong)NSString *isGroup;

@property (nonatomic,strong)NSString *itemNo;
@property (nonatomic,strong)NSString *marketPrice;
@property (nonatomic,strong)NSString *num;
@property (nonatomic,strong)NSString *parentCategoryId;
@property (nonatomic,strong)NSString *price;

@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *productStore;
@property (nonatomic,strong)NSString *productWeight;
@property (nonatomic,strong)NSString *remain;
@property (nonatomic,strong)NSString *saleCount;

@property (nonatomic,strong)NSString *salePrice;
@property (nonatomic,strong)NSString *sellerId;
@property (nonatomic,strong)NSString *stage;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *statusName;

@property (nonatomic,strong)NSString *tip;
@property (nonatomic,strong)NSString *total;
@property (nonatomic,strong)NSString *unit;
@property (nonatomic,strong)NSString *ut;



@end
