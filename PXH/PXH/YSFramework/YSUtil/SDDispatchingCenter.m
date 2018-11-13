//
//  SDDispatchingCenter.m
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//

#import "SDDispatchingCenter.h"
#import "SDError.h"

@implementation SDDispatchingCenter

+ (instancetype)sharedCenter
{
    static SDDispatchingCenter *sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCenter = [[[self class] alloc] init];
    });
    return sharedCenter;
}

////方法用于配置默认网络请求配置信息,根据项目实际情况预先设置请求配置信息
//- (void)networkConfig{
//    //self.networkManager.requestSerializer=[AFJSONRequestSerializer serializer];
//    self.networkManager.requestSerializer.timeoutInterval = 20;
//    //self.networkManager.responseSerializer = [AFJSONResponseSerializer serializer];
//}

- (AFHTTPSessionManager *)networkManager
{
    if (!_networkManager) {
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _networkManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL] sessionConfiguration:config];
        
        _networkManager.requestSerializer.timeoutInterval = 20;
        if (self.isSupportHttps) {
            _networkManager.securityPolicy.allowInvalidCertificates = YES;
        }
        
//        _networkManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
//        _networkManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"multipart/form-data", @"application/octet-stream", @"text/json", @"text/javascript", @"text/plain", @"text/html", @"application/xml", @"image/jpeg",@"image/png", @"text/xml", nil];
    }

    //加入token,实现登录
    NSString *token = [JYAccountModel sharedAccount].token;
    if (token && token.length>0) {
//        [_networkManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        
        [_networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    
    return _networkManager;
}

- (void)cancelAllRequest
{
    [self.networkManager.operationQueue cancelAllOperations];
}

#pragma mark 获取网络状态

- (AFNetworkReachabilityStatus)networkStatus
{
    return [[self.networkManager reachabilityManager] networkReachabilityStatus];
}

- (void)networkStatusChange:(void (^)(AFNetworkReachabilityStatus status))block
{
    [[self.networkManager reachabilityManager] setReachabilityStatusChangeBlock:block];
}

#pragma mark 网络请求接口（方法中包含请求参数与返回信息的预处理）

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    
    NSURLSessionDataTask *dataTask = [self.networkManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                
                [self checkTokenisExpired:err];
                
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        //抛出失败响应
        failure(task,err);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    //发送网络请求
    NSURLSessionDataTask *dataTask=[self.networkManager HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask *task) {
        
        //抛出成功响应
        success(task);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        
        //抛出失败响应
        failure(task,err);
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    //发送网络请求
    NSURLSessionDataTask *dataTask = [self.networkManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                
                [self checkTokenisExpired:err];
                
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        //抛出失败响应
        failure(task,err);
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    
    NSURLSessionDataTask *dataTask = [self.networkManager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        
        //抛出失败响应
        failure(task,err);
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    
    //发送网络请求
    NSURLSessionDataTask *dataTask=[self.networkManager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        
        //抛出失败响应
        failure(task,err);
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    //发送网络请求
    NSURLSessionDataTask *dataTask=[self.networkManager PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        
        //抛出失败响应
        failure(task,err);
    }];
    
    //添加网络请求到任务列表
    return dataTask;
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, SDError *error))failure
{
    //发送网络请求
    NSURLSessionDataTask *dataTask = [self.networkManager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger errorCode = [[responseObject objectForKey:@"code"] integerValue];
            NSString  *errorMessage = [responseObject objectForKey:@"message"];
            //处理成功响应
            SDError *err = [SDError errorWithCode:errorCode Msg:errorMessage];
            if (err.errorCode != 0) {//业务层失败信息处理
                failure(task,err);
            } else {//业务层成功信息处理
                success(task,responseObject);
            }
        } else {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SDError *err = [SDError errorWithCode:error.code Msg:error.localizedDescription];
        //抛出失败响应
        failure(task,err);
    }];
    
    //添加网络请求到任务列表
    return dataTask;
}

- (void)checkTokenisExpired:(SDError *)err
{
    if (err.errorCode == 700) {//token过期
        //发出重新登录通知
        [[NSNotificationCenter defaultCenter] postNotificationName:JYTokenExpiredReLogin object:self];
    }
}

@end
