//
//  YSAccountService.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAccountService.h"

#import "AppDelegate.h"
#import "YSLoginGuidingViewController.h"
#import "YSMainTabBarViewController.h"
#import "JYLogInController.h"


@implementation YSAccountService

/**
 切换RootViewController
 */
+ (void)switchToRootViewControler:(YSSwitchRootVcType)rootVcType {
    CATransition *anim = [CATransition animation];
    anim.type = kCATransitionFade;
    anim.duration = 0.3;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:@"fadeAnimation"];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    switch (rootVcType) {
        case YSSwitchRootVcTypeLogin: {
            //            [SDAccount clearCID];
            [JYAccountModel deleteAccount];
            delegate.window.rootViewController = [[YSNavigationController alloc] initWithRootViewController:[JYLogInController new]];
            
            
            
        }
            break;
        case YSSwitchRootVcTypeTabbar:
        {
//                        [delegate submitClientId];
            delegate.window.rootViewController = [YSMainTabBarViewController new];

        }
            break;
        default:
            break;
    }
}


/**
 登录

 @param type 1手机号码(密码) 2微信 3手机号码(验证码)
 */
+ (void)loginServiceType:(NSInteger)type
                  mobile:(NSString *)mobile
                password:(NSString *)password
                    code:(NSString *)code
//                userInfo:(UMSocialUserInfoResponse *)userInfo
              completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"type"] = @(type);
    switch (type) {
        case 1:
        {
            parameters[@"mobile"] = mobile;
            parameters[@"password"] = [password md5String];

        }
            break;
        case 2:
        {
//            parameters[@"unionid"] = userInfo.uid;
//            parameters[@"nickName"] = userInfo.name;
////            parameters[@"sex"] = sex;
//            parameters[@"headimgurl"] = userInfo.iconurl;

        }
            break;
        case 3:
        {
            parameters[@"mobile"] = mobile;
            parameters[@"code"] = code;
        }
            break;
    }
    [[SDDispatchingCenter sharedCenter] POST:kLogin_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSAccount *account = [YSAccount mj_objectWithKeyValues:result];
        if (account.ID) {
            
            [YSAccount saveAccount:account];
            
            if (completion) {
                completion(account, nil);
            }
        }else {
            [MBProgressHUD showErrorMessage:@"登录失败" toContainer:nil];
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

    //注册
+ (void)registerServiceMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password completion:(YSCompleteHandler)completion {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"mobile"] = mobile;
    parameters[@"code"] = code;
    parameters[@"password"] = [password md5String];
    [[SDDispatchingCenter sharedCenter] POST:kRegister_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *result = responseObject[@"result"];
        YSAccount *account = [YSAccount mj_objectWithKeyValues:result];
        if (account.ID) {
            [YSAccount saveAccount:account];
            if (completion) {
                completion(account, nil);
            }
        }else {
            [MBProgressHUD showErrorMessage:@"注册失败" toContainer:nil];
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
  修改密码
 */
+ (void)updatePasswordWithUrl:(NSString *)url mobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password completion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:5];
    parameters[@"mobile"] = mobile;
    parameters[@"code"] = code;
    NSString *psw = [password md5String];
    parameters[@"password"] = psw;
    parameters[@"newPassword"] = psw;
    parameters[@"payPassword"] = psw;
    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) {
            NSDictionary *result = responseObject[@"result"];
            YSAccount *account = [YSAccount mj_objectWithKeyValues:result];
            [YSAccount saveAccount:account];
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}


/**
 获取用户详情
 */
+ (void)fetchUserInfoWithCompletion:(YSCompleteHandler)completion {
 
    [[SDDispatchingCenter sharedCenter] POST:kMemberDetail_URL parameters:@{@"memberId":USER_ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSAccount *account = [YSAccount mj_objectWithKeyValues:result];
        if (account.ID) {
            [YSAccount saveAccount:account];
            if (completion) {
                completion(account, nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
    }];
}


/**
 修改用户信息
 */
+ (void)updateUserInfo:(NSDictionary *)param completion:(YSCompleteHandler)completion {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:param];
//    parameters[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kUpdateUserInfo_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSAccount *account = [YSAccount mj_objectWithKeyValues:result];
        if (account.ID) {
            [YSAccount saveAccount:account];
            if (completion) {
                completion(account, nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}

/**
 获取粉丝列表
 */
+ (void)fetchFansList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kFansList_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSFans mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}


/**
 获取签到数据
 */
+ (void)fetchSigninDataWithCompletion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kSigninData_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSSigninModel *model = [YSSigninModel mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 签到
 */
+ (void)signinWithCompletion:(YSCompleteHandler)completion {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kSignin_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YSSigninModel *model = [YSSigninModel mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];

}
/**
 积分规则
 */
+ (void)scoreRuleWithCompletion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:kScoreRule_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *result = responseObject[@"result"];
        YSScoreRule *model = [YSScoreRule mj_objectWithKeyValues:result];
        if (completion) {
            completion(model, nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/**
 获取资金明细
 */
+ (void)fetchAmountDetail:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:parameters];
    param[@"page"] = @(page);
    param[@"rows"] = @(10);
    param[@"memberId"] = USER_ID;
    [[SDDispatchingCenter sharedCenter] POST:kAmountDetail_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSArray *models = [YSAmountDetail mj_objectArrayWithKeyValuesArray:result];
        if (completion) {
            completion(models, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
        if (completion) {
            completion(nil, error);
        }
    }];
}


#pragma mark - 简单的手机号正则验证
+ (BOOL)isMobile:(NSString *)phoneNum {
    
    NSString *MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|17[0135678]|18[0-9])\\d{8}$";
    NSPredicate *pred_mobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [pred_mobile evaluateWithObject:phoneNum];
}


@end
