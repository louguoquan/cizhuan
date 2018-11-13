//
//  YSLifeCircleModel.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSLifeCategory.h"

@interface YSLifeCircleModel : NSObject

@property (nonatomic, strong) NSString  *tips;

@property (nonatomic, assign) NSArray   *images;

@property (nonatomic, assign) NSArray<YSLifeCategory *>   *cats;

@property (nonatomic, assign) CGFloat buyMoney;    //已消费金额

@property (nonatomic, assign) CGFloat shortMoney;  //剩余金额

@end
