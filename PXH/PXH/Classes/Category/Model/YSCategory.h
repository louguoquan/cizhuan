//
//  YSCategory.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCategory : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *name;

@property (nonatomic, strong) NSString  *logo;

@property (nonatomic, strong) NSString  *parentId;

@property (nonatomic, strong) NSString  *expanded;

@property (nonatomic, copy)   NSArray   *children;

@end
