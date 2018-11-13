//
//  YSAccountService.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UMSocialCore/UMSocialCore.h>

#import "YSFans.h"
#import "YSSigninModel.h"
#import "YSAmountDetail.h"
#import "YSScoreRule.h"
typedef NS_ENUM(NSUInteger, YSSwitchRootVcType) {
    YSSwitchRootVcTypeTabbar,
    YSSwitchRootVcTypeLogin,
};

@interface YSAccountService : NSObject

+ (void)switchToRootViewControler:(YSSwitchRootVcType)rootVcType;


#pragma mark - 简单的手机号正则验证
+ (BOOL)isMobile:(NSString *)phoneNum;

/**
 登录

 @param type 1手机号码(密码) 2微信 3手机号码(验证码)
 */
//+ (void)loginServiceType:(NSInteger)type
//                  mobile:(NSString *)mobile
//                password:(NSString *)password
//                    code:(NSString *)code
//                userInfo:(UMSocialUserInfoResponse *)userInfo
//              completion:(YSCompleteHandler)completion;

/**
 注册
 */
+ (void)registerServiceMobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password completion:(YSCompleteHandler)completion;


/**
 修改密码
 */
+ (void)updatePasswordWithUrl:(NSString *)url mobile:(NSString *)mobile code:(NSString *)code password:(NSString *)password completion:(YSCompleteHandler)completion;

/**
 获取用户详情
 */
+ (void)fetchUserInfoWithCompletion:(YSCompleteHandler)completion;


/**
 修改用户信息
 */
+ (void)updateUserInfo:(NSDictionary *)param completion:(YSCompleteHandler)completion;

/**
 获取粉丝列表
 */
+ (void)fetchFansList:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 获取签到数据
 */
+ (void)fetchSigninDataWithCompletion:(YSCompleteHandler)completion;

/**
 签到
 */
+ (void)signinWithCompletion:(YSCompleteHandler)completion;

/**
    积分规则
 */
+ (void)scoreRuleWithCompletion:(YSCompleteHandler)completion;

/**
 获取资金明细
 */
+ (void)fetchAmountDetail:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;



@end
