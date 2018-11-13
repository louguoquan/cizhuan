//
//  YSCartProduct.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCartProduct : NSObject

@property (nonatomic, strong) NSString  *carId;

@property (nonatomic, strong) NSString  *memberId;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, strong) NSString  *productImage;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, assign) CGFloat   costPrice;

@property (nonatomic, assign) CGFloat   totalFee;

@property (nonatomic, strong) NSString  *normalId;

@property (nonatomic, strong) NSString  *normal;

@property (nonatomic, strong) NSString  *store;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL      selected;

@end
