//
//  JJLoginService.h
//  PXH
//
//  Created by louguoquan on 2018/7/28.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJLoginService : NSObject

/** 获取验证码 */
+ (void)requestMobileCodeSend:(NSString *)mobile type:(NSString *)type category:(NSString *)category Completion:(YSCompleteHandler)completion;

/** 校验验证码 */
+ (void)requestMobileMemberCheckCode:(NSString *)mobile identifyingCode:(NSString *)identifyingCode type:(NSString *)type Completion:(YSCompleteHandler)completion;

/** 忘记密码 */
+ (void)requestMobileMemberChangePassword:(NSString *)password mobile:(NSString *)mobile Completion:(YSCompleteHandler)completion;


/** 修改密码 */
+ (void)requestMobileMemberChangePasswordM:(NSString *)password newPassWord:(NSString *)newPassWord Completion:(YSCompleteHandler)completion;



/** 注册*/
+ (void)requestMobileMemberRegist:(NSString *)regStr password:(NSString *)password recCode:(NSString *)recCode userName:(NSString *)userName type:(NSString *)type Completion:(YSCompleteHandler)completion;



/** 登录*/
+ (void)mobileMemberLoginWithMobile:(NSString *)mobile password:(NSString *)password Completion:(YSCompleteHandler)completion;




@end
