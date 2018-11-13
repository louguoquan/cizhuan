//
//  YSAddress.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAddress : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *provinceId;

@property (nonatomic, strong) NSString  *cityId;

@property (nonatomic, strong) NSString  *districtId;

@property (nonatomic, strong) NSString  *streetId;

@property (nonatomic, strong) NSString  *provinceName;

@property (nonatomic, strong) NSString  *cityName;

@property (nonatomic, strong) NSString  *districtName;

@property (nonatomic, strong) NSString  *streetName;

@property (nonatomic, strong) NSString  *name;

@property (nonatomic, strong) NSString  *mobile;

@property (nonatomic, strong) NSString  *address;

@property (nonatomic, assign) NSInteger type;

@end
