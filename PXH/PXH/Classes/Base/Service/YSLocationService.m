//
//  YSLocationService.m
//  HouseDoctorMember
//
//  Created by yu on 2017/7/3.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLocationService.h"

@interface YSLocationService ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKLocationService    *locService;

@property (nonatomic, strong) BMKGeoCodeSearch      *geocodeSearch;

@property (nonatomic, copy)   YSCompleteHandler     block;

@property (nonatomic, assign) BOOL      isGeoCode;

@property (nonatomic, strong) YSLocationService     *service;

@end

@implementation YSLocationService

+ (instancetype)sharedService {

    YSLocationService *service = [YSLocationService new];
    service.service = service;
    return service;
}

- (void)getLocation:(YSCompleteHandler)block
{
    self.isGeoCode = NO;
    self.block = block;
    [self beginLocation];
}

- (void)getCity:(YSCompleteHandler)block {
    self.isGeoCode = YES;
    self.block = block;
    [self beginLocation];
}

- (void)beginLocation {
    
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
        //每隔50米定位一次
        _locService.distanceFilter = 50;
        
        _geocodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geocodeSearch.delegate = self;
        
        //初始化BMKLocationService
        //启动LocationService
    }
    [_locService startUserLocationService];
}

- (void)stopLocation
{
    [_locService stopUserLocationService];
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self stopLocation];
    
    if (_isGeoCode) {
        //发起反向地理编码检索
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
        BMKReverseGeoCodeResult *result = [BMKReverseGeoCodeResult new];
        result.location = userLocation.location.coordinate;

        
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [BMKReverseGeoCodeOption new];
        reverseGeoCodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
        if (flag) {
            NSLog(@"反geo检索发送成功");
        } else {
            NSLog(@"反geo检索发送失败");
        }

    }else {
        if (self.block) {
            self.block(userLocation.location, nil);
        }
        self.service = nil;
    }
}

#pragma mark - BMKGeoCodeSearchDelegate

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //        NSMutableString *city = [NSMutableString stringWithString:result.addressDetail.city];
        //        [city deleteCharactersInRange:NSMakeRange(city.length - 1, 1)];
        
        if (self.block) {
            self.block(result.addressDetail.city, nil);
        }

        NSLog(@"%@", result.address);

        self.service = nil;
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}


@end
