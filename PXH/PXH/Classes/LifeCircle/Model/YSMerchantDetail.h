//
//  YSMerchantDetail.h
//  PXH
//
//  Created by yu on 2017/8/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSLifeMerchants.h"

@interface YSLifeCoupons : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, strong) NSString  *title;

@property (nonatomic, strong) NSString  *endTime;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, assign) NSInteger isExchange;

@property (nonatomic, strong) NSString  *productId;

@end

@interface YSMerchantDetail : NSObject

@property (nonatomic, strong) YSLifeMerchants   *shop;

@property (nonatomic, copy)   NSArray   *coupons;

@property (nonatomic, strong) NSString  *html;

@end


