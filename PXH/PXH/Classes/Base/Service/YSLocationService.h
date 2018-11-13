//
//  YSLocationService.h
//  HouseDoctorMember
//
//  Created by yu on 2017/7/3.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface YSLocationService : NSObject

+ (instancetype)sharedService;

- (void)getLocation:(YSCompleteHandler)block;

- (void)getCity:(YSCompleteHandler)block;

@end
