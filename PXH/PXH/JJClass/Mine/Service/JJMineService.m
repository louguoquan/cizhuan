//
//  JJMineService.m
//  PXH
//
//  Created by louguoquan on 2018/7/31.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJMineService.h"

static NSString *JJMobileMemberBindMail = @"/mobile/member/bindMail";
static NSString *JJMobileMemberBindMoblie = @"/mobile/member/bindMobile";
static NSString *JJMobileMemberAboutUs = @"/mobile/member/aboutUs";
static NSString *JJMobileMemberRecommendBeiTa = @"/mobile/member/recommendBeiTa";

static NSString *JJMobileMemberHelpCenter = @"/mobile/member/helpCenter";

static NSString *JJMobileMemberOneDayLogin = @"/mobile/member/oneDayLogin";

static NSString *JJMobileMemberOfficialEmail = @"/mobile/member/OfficialEmail";


static NSString *JJMobilMemberMessageCenter = @"/mobile/member/messageCenter";

static NSString *JJMobileMemberGetUserInfo = @"/mobile/member/getUserInfo";

static NSString *JJMobileMemberPayPassword = @"/mobile/member/payPassword";


static NSString *JJMobileMemberJudgePasswordJDG = @"/mobile/member/judgePassword";









@implementation JJMineService


/** 绑定邮箱 */
+ (void)requestMobileMemberBindMail:(NSString *)mail checkCode:(NSString *)checkCode Completion:(YSCompleteHandler)completion{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"mail"] = mail;
    parameters[@"checkCode"] = checkCode;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberBindMail parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 绑定手机 */
+ (void)requestMobileMemberBindMobile:(NSString *)mobile checkCode:(NSString *)checkCode Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"mobile"] = mobile;
    parameters[@"checkCode"] = checkCode;
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberBindMoblie parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 关于我们 */
+ (void)requestMobileMemberAboutUsCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberAboutUs parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 邀请 */
+ (void)JJMobileMemberRecommendBeiTaCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberRecommendBeiTa parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JJShareModel *model = [JJShareModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 帮助中心 */
+ (void)JJMobileMemberHelpCenterCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberHelpCenter parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
     
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 每日登录 */
+ (void)JJMobileMemberOneDayLoginCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobileMemberOneDayLogin parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 客服邮箱 */
+ (void)JJMobileMemberOfficialEmailCompletion:(YSCompleteHandler)completion{
    
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberOfficialEmail parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/** 消息中心 */
+ (void)JJMobilMemberMessageCenterWithPage:(NSInteger )page Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"pageSize"]= @"20";
    
    [[SDDispatchingCenter sharedCenter] GET:JJMobilMemberMessageCenter parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JJMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 获取个人信息 */
+ (void)JJMobileMemberGetUserInfoCompletion:(YSCompleteHandler)completion{

    [[SDDispatchingCenter sharedCenter] GET:JJMobileMemberGetUserInfo parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JYAccountModel *account = [JYAccountModel sharedAccount];
       
        account.username = responseObject[@"result"][@"username"];
        account.head = responseObject[@"result"][@"head"];
        account.email = responseObject[@"result"][@"email"];
        account.mobile = responseObject[@"result"][@"mobile"];
//        [JYAccountModel saveAccount:account];
        
        !completion?:completion(account, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


/** 设置支付密码 */
+ (void)JJMobileMemberPayPasswordWithPassword:(NSString *)pwd Completion:(YSCompleteHandler)completion{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"payPassword"] = [pwd md5String];
    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberPayPassword parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
      
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/** 是否设置支付密码 */
+ (void)JJMobileMemberJudgePasswordJDGCompletion:(YSCompleteHandler)completion{

    [[SDDispatchingCenter sharedCenter] POST:JJMobileMemberJudgePasswordJDG parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        
         !completion?:completion(nil, error);
      
    }];
}






@end
