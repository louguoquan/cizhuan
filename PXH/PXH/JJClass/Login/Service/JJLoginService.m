//
//  JJLoginService.m
//  PXH
//
//  Created by louguoquan on 2018/7/28.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJLoginService.h"

static NSString *JJMobileCodeSend = @"/mobile/code/send";
static NSString *JJMobileMemberCheckCode = @"/mobile/member/checkCode";
static NSString *JJMobileMemberRegist = @"/mobile/member/regist";
static NSString *JJMobileMemberLogin = @"/mobile/member/login";
static NSString *JJMobileMemberForgetPassword = @"/mobile/member/forgetPassword";
static NSString *JJMobileMemberChangePassword = @"/mobile/member/changePassword";



@implementation JJLoginService

/** 获取验证码 */
+ (void)requestMobileCodeSend:(NSString *)mobile type:(NSString *)type category:(NSString *)category Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"mobile"] = mobile;
    parameters[@"type"] = type;
    parameters[@"category"] = category;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileCodeSend parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/** 校验验证码 */
+ (void)requestMobileMemberCheckCode:(NSString *)mobile identifyingCode:(NSString *)identifyingCode type:(NSString *)type Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"mobile"] = mobile;
    parameters[@"identifyingCode"] = identifyingCode;
    parameters[@"type"] = type;
    [[SDDispatchingCenter sharedCenter] GET:JJMobileMemberCheckCode parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/** 忘记密码 */
+ (void)requestMobileMemberChangePassword:(NSString *)password mobile:(NSString *)mobile Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"mobile"] = mobile;
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberForgetPassword parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/** 修改密码 */
+ (void)requestMobileMemberChangePasswordM:(NSString *)password newPassWord:(NSString *)newPassWord Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"newPassWord"] = [newPassWord md5String];
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberChangePassword parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    
}





/** 注册*/
+ (void)requestMobileMemberRegist:(NSString *)regStr password:(NSString *)password recCode:(NSString *)recCode userName:(NSString *)userName type:(NSString *)type Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    parameters[@"regStr"] = regStr;
    parameters[@"password"] = [password md5String];
    parameters[@"recCode"] = recCode;
    parameters[@"userName"] = userName;
    parameters[@"type"] = type;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberRegist parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 登录*/
+ (void)mobileMemberLoginWithMobile:(NSString *)mobile password:(NSString *)password Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    parameters[@"mobile"] = mobile;
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberLogin parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JYAccountModel *account = [JYAccountModel mj_objectWithKeyValues:responseObject[@"result"]];
        [JYAccountModel saveAccount:account];
    
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}






@end
