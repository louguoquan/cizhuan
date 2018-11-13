//
//  YSNetWork.m
//  PXH
//
//  Created by futurearn on 2017/12/5.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSNetWork.h"

@implementation YSNetWork

#pragma mark - 上传CID

+ (void)uploadClientID:(NSString *)CID {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = [YSAccount sharedAccount].ID;
    params[@"clientId"] = CID;
    params[@"type"] = @"2";
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:kupload_URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"上传 CID 成功！");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"上传 CID 失败！");
//    }];
    [[SDDispatchingCenter sharedCenter] POST:kupload_URL
            parameters:params
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSLog(@"上传 CID 成功！");
               } failure:^(NSURLSessionDataTask *task, SDError *error) {
                   NSLog(@"上传 CID 失败！");
               }];
}

#pragma mark - 清除 CID

+ (void)clearCID {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = [YSAccount sharedAccount].ID;
    [[SDDispatchingCenter sharedCenter] POST:kCleanCID_URL
            parameters:params
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSLog(@"清除 CID 成功！");
               } failure:^(NSURLSessionDataTask *task, SDError *error) {
                   NSLog(@"清除 CID 失败！");
               }];
}

@end
