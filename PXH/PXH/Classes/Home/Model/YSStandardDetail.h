//
//  YSProductSpecDetail.h
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSStandardDetail : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *normalCode;

@property (nonatomic, strong) NSString  *store;

@property (nonatomic, assign) CGFloat   salePrice;

@property (nonatomic, assign) CGFloat   costPrice;

@property (nonatomic, assign) CGFloat   vipPrice;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, strong) NSString  *keyValue;

@property (nonatomic, strong) NSString  *valueIds;

@property (nonatomic, strong) NSString  *vipPriceView;

@property (nonatomic, strong) NSString  *salePriceView;

@property (nonatomic, strong) NSString  *costPriceView;

@property (nonatomic, strong) NSString  *normalStr;

@property (nonatomic, strong) NSString  *values;


@end
