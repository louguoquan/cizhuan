//
//  JJFoundService.m
//  PXH
//
//  Created by louguoquan on 2018/8/2.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJFoundService.h"

static NSString *JJMobileCmsConsultation = @"/mobile/cms/broadcast";
static NSString *JJMobileCmsNotice = @"/mobile/cms/notice";
static NSString *JJMobileCmsCooperation = @"/mobile/cms/cooperation";
static NSString *JJDownloadAddress = @"/mobile/cms/downloadAddress";
static NSString *JJDownload = @"/mobile/cms/download";




@implementation JJFoundService


/** 首页banner */
+ (void)JJMobileCmsConsultationCompletion:(YSCompleteHandler)completion{
    
 
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCmsConsultation parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJHomeBaseModel *array = [JJHomeBaseModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 首页通知*/
+ (void)JJMobileCmsNoticeCompletion:(YSCompleteHandler)completion{
    
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileCmsNotice parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [JJHomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 合作入驻*/
+ (void)JJMobileCmsCooperation:(NSString *)content name:(NSString *)name email:(NSString *)email mobile:(NSString *)mobile Completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"content"] = content;
    param[@"name"] = name;
    param[@"email"] = email;
    param[@"mobile"] = mobile;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileCmsCooperation parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
         !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 机界狗下载地址*/
+ (void)JJDownloadAddressCompletion:(YSCompleteHandler)completion{

    [[SDDispatchingCenter sharedCenter] GET:JJDownloadAddress parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 交易所下载地址*/
+ (void)JJDownloadCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJDownload parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        !completion?:completion(nil, error);
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}




@end
