//
//  YSSeckillProduct.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSSeckillProduct : NSObject

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, assign) CGFloat   costPrice;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, strong) NSString  *store;

@property (nonatomic, assign) NSInteger limitCount;

@property (nonatomic, assign) NSInteger buyCount;

@property (nonatomic, assign) NSInteger plusCount;

@property (nonatomic, strong) NSString  *percent;

@property (nonatomic, strong) NSString  *plusPercent;

@property (nonatomic, strong) NSString  *summary;

@end
