//
//  YSProduct.h
//  PXH
//
//  Created by yu on 2017/8/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSProduct : NSObject

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, assign) CGFloat   costPrice;

@property (nonatomic, assign) CGFloat   vipPrice;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, assign) NSInteger saleCount;

@property (nonatomic, strong) NSString *store;

/**
 1普通产品  2限量秒杀产品  3限时购产品
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *status;

@end
