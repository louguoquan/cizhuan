//
//  SDDispatchingCenter.h
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//
// 工具名 : 调度中心
// 功能  :
//          1.提供http/https网络请求接口
//          2.提供应用网络请求信息预处理
//          3.提供网络状态获取
//

#import <Foundation/Foundation.h>
#import "SDError.h"

@interface SDDispatchingCenter : NSObject

/**
 *  网络请求实例
 */
@property (nonatomic, strong) AFHTTPSessionManager *networkManager;    //网络请求Manager

@property (nonatomic, assign) BOOL      isSupportHttps;           //是否支持https

/**
 *  创建网络请求单例服务
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedCenter;

/**
 *  取消所有请求
 */
- (void)cancelAllRequest;

/**
 *  获取网络状态
 *
 *  @return 返回网络状态  枚举值
 */
- (AFNetworkReachabilityStatus)networkStatus;

/**
 *  处理网络状态改变
 *
 *  @param block 网络状态改变后的回调block
 */
- (void)networkStatusChange:(void (^)(AFNetworkReachabilityStatus status))block;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure;

@end
