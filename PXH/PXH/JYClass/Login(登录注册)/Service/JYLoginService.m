//
//  JYLoginService.m
//  PXH
//
//  Created by LX on 2018/5/30.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYLoginService.h"

static NSString *JYRegister_URL = @"/mobile/user/regist";

static NSString *JYForgetPassword_URL = @"/mobile/member/forgetPassword";

static NSString *JYLogin_URL = @"/mobile/user/login";

static NSString *JYFigureCheckCode_URL = @"/shop/yzm";

static NSString *JYValidateFigureCode_URL = @"/shop/validateYzm";

@implementation JYLoginService

+ (void)requestFigureCheckCodeKey:(NSString *)key
                       Completion:(YSCompleteHandler)completion
{
    //获取当前时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970]*1000;//毫秒
    
    NSString *keys = [NSString stringWithFormat:@"%.f%05d", interval, arc4random()%10000];
    [[NSUserDefaults standardUserDefaults] setObject:keys forKey:JYFigureCheckCodeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"\n图形验证码key: %@", keys);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:1];
    parameters[@"key"] = keys;
    
    [[SDDispatchingCenter sharedCenter] GET:JYFigureCheckCode_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject[@"result"], nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

+ (void)validateFigureCode:(NSString *)yzm
                completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:7];
    parameters[@"yzm"] = yzm;
    
    [[SDDispatchingCenter sharedCenter] POST:JYFigureCheckCode_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)registerServiceUserName:(NSString *)userName
                         regStr:(NSString *)regStr
                figureCheckCode:(NSString *)figureCheckCode
                      checkCode:(NSString *)checkCode
                       password:(NSString *)password
                        recCode:(NSString *)recCode
                           type:(NSString *)type
                     completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:7];
    parameters[@"userName"] = userName;
    parameters[@"regStr"] = regStr;
    parameters[@"figureCheckCode"] = figureCheckCode;
    parameters[@"checkCode"] = checkCode;
    parameters[@"password"] = [password md5String];
    parameters[@"recCode"] = recCode;
    parameters[@"type"] = type;
    
    [[SDDispatchingCenter sharedCenter] POST:JYRegister_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

+ (void)ForgetPasswordMobile:(NSString *)mobile
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password
                        type:(NSString *)type
                  completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:4];
    parameters[@"mobile"] = mobile;
    parameters[@"checkCode"] = msgCode;
    parameters[@"payPassword"] = [password md5String];
//    parameters[@"type"] = type;
    
    [[SDDispatchingCenter sharedCenter] POST:JYSetUpLoginPassWord_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)loginServiceMobile:(NSString *)mobile
                  password:(NSString *)password
                completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:4];
    parameters[@"mobile"] = mobile;
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:JYLogin_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JYAccountModel *account = [JYAccountModel mj_objectWithKeyValues:responseObject[@"result"]];

        if (account.token) {
            account.loginTime = [self getTimeIntervals:YES];
            account.expiredTime = [self getTimeIntervals:NO];
            [JYAccountModel saveAccount:account];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loginMessageWithTimeOut" object:nil];
            
            !completion?:completion(account, nil);
        } else {
            [MBProgressHUD showErrorMessage:@"登录失败" toContainer:nil];
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 获取登录时间、token过期时间

 @param isCurrent YES：获取当前时间， NO， 过期时间
 */
+ (NSString *)getTimeIntervals:(BOOL)isCurrent
{
     //获取当前时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentInterval = [date timeIntervalSince1970]*1000;//毫秒
    if (isCurrent) return [NSString stringWithFormat:@"%f", currentInterval];
    
    //获取七天后的时间戳
    NSTimeInterval laterInterbal = 7 * (24 * 60 * 60) * 1000;
    laterInterbal += currentInterval;
    return [NSString stringWithFormat:@"%f", laterInterbal];
}

@end
