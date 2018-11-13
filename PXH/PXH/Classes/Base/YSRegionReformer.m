//
//  YSRegionReformer.m
//  QingTao
//
//  Created by yu on 16/4/23.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "YSRegionReformer.h"

@interface YSRegionReformer ()

#define YSREGION_PATH   [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"ysRegion.plist"]

@property (nonatomic, assign) BOOL  isFirst;

@end

@implementation YSRegionReformer

+ (YSRegionReformer *)shareInstance
{
    static YSRegionReformer *reformer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reformer = [[YSRegionReformer alloc] init];
        reformer.isFirst = YES;
    });
    
    return reformer;
}

- (void)fetchRegionListSuccess:(successReformer)success
                       failure:(failureReformer)failure {
    NSArray *dataSource = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:YSREGION_PATH]];
    
    if ([dataSource count] > 0) {
        success(dataSource);
    }
    
    if (_isFirst || [dataSource count] <= 0) {
        [[SDDispatchingCenter sharedCenter] POST:kAllRegion_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *result = responseObject[@"result"];
            NSArray *dataSource = [YSRegion mj_objectArrayWithKeyValuesArray:result];
            [NSKeyedArchiver archiveRootObject:dataSource toFile:YSREGION_PATH];
            _isFirst = NO;
            success(dataSource);
        } failure:^(NSURLSessionDataTask *task, SDError *error) {
            failure(error);
        }];
    }
}

- (void)fetchStreetListWithDistrictId:(NSString *)districtId success:(successReformer)success failure:(failureReformer)failure {
    NSDictionary *parameters = @{@"districtId" : districtId};
    [[SDDispatchingCenter sharedCenter] POST:kStreetList_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *dataSource = [YSRegion mj_objectArrayWithKeyValuesArray:result];

        success(dataSource);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        failure(error);
    }];

}

@end
