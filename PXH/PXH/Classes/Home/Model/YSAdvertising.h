//
//  YSAdvertising.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAdvertising : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, strong) NSString  *sort;

@property (nonatomic, strong) NSString  *url;

@property (nonatomic, strong) NSString  *name;

@property (nonatomic, strong) NSString  *price;

//    1  商品详情   2 商品列表
@property (nonatomic, assign) NSInteger linkType;

@property (nonatomic, strong) NSString  *catId;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, assign) NSInteger catLevel;

@property (nonatomic, strong) NSString *parentCatId;

@end
