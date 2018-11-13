//
//  JYMarketService.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYMarketModel.h"
@interface JYMarketService : NSObject

/**
 获取币种列表  带分页
 */
+ (void)fetchCoinList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;


/**
 自选币种重新排序
 */

+ (void)UpdateCoinSortWithID:(NSString *)ID sort:(NSInteger)sort completion:(YSCompleteHandler)completion;

/**
检查版本
 */
+ (void)UpdateCheck:(NSString *)ID completion:(YSCompleteHandler)completion;


/**
 获取系统时间
 */
+ (void)UpdateGetSystemTime:(NSString *)ID completion:(YSCompleteHandler)completion;



@end
