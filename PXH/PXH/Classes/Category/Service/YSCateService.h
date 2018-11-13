//
//  YSCateService.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSCategory.h"

@interface YSCateService : NSObject


/**
 获取一级分类
 */
+ (void)fetchFirstCate:(YSCompleteHandler)completion;


/**
 获取二级分类
 */
+ (void)fetchChildCate:(NSString *)parentCateId completion:(YSCompleteHandler)completion;

/**
 获取所有分类
 */
+ (void)fetchAllCate:(YSCompleteHandler)completion;

@end
