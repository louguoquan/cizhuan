//
//  YSCateService.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateService.h"

@implementation YSCateService

+ (void)fetchFirstCate:(YSCompleteHandler)completion {
    
    [[SDDispatchingCenter sharedCenter] POST:kFirstCate_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSCategory mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

+ (void)fetchChildCate:(NSString *)parentCateId completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:1];
    parameters[@"catId"] = parentCateId;
    [[SDDispatchingCenter sharedCenter] POST:kChildCate_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSCategory mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)fetchAllCate:(YSCompleteHandler)completion {
    [[SDDispatchingCenter sharedCenter] POST:kAllCate_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [YSCategory mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

@end
