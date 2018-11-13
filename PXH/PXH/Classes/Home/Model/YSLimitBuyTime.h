//
//  YSLimitBuyTime.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSLimitBuyTime : NSObject

@property (nonatomic, strong) NSString  *timeId;

@property (nonatomic, strong) NSString  *startTime;

@property (nonatomic, strong) NSString  *endTime;

/**
  1已结束 2进行中 3预热中
 */
@property (nonatomic, assign) NSInteger type;

@end
