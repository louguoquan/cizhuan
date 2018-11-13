//
//  YSProductSpec.h
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSStandard : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *key;

@property (nonatomic, strong) NSString  *value;

@property (nonatomic, strong) NSString  *keyId;

@property (nonatomic, strong) NSString  *valueId;

@property (nonatomic, copy)   NSArray<YSStandard *>   *normses;

@property (nonatomic, assign) BOOL      selected;

@end
