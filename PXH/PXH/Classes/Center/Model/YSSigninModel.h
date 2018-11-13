//
//  YSSigninModel.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSCalendarComponent.h"

@interface YSSigninModel : NSObject

@property (nonatomic, strong) NSString  *date;

@property (nonatomic, assign) BOOL      isTodaySign;

@property (nonatomic, assign) NSString  *score;

@property (nonatomic, copy)   NSArray<YSCalendarComponent *>   *list;

@end
