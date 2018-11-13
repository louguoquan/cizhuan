//
//  JYLoginService.h
//  PXH
//
//  Created by LX on 2018/5/30.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYLoginService : NSObject

/** 获取图形验证码 */
+ (void)requestFigureCheckCodeKey:(NSString *)key
                       Completion:(YSCompleteHandler)completion;


/**
 验证图形验证码

 @param yzm 图形验证码
 */
+ (void)validateFigureCode:(NSString *)yzm
                completion:(YSCompleteHandler)completion;

/**
 注册
 
 @param userName        用户名
 @param regStr          手机号或邮箱
 @param figureCheckCode 图形验证码（发送短信时已验证，应该不需要，暂时不传）
 @param checkCode       短信验证码
 @param password        登录密码
 @param recCode         邀请码
 @param type            1.手机； 2.邮箱
 */
+ (void)registerServiceUserName:(NSString *)userName
                         regStr:(NSString *)regStr
                figureCheckCode:(NSString *)figureCheckCode
                      checkCode:(NSString *)checkCode
                       password:(NSString *)password
                        recCode:(NSString *)recCode
                           type:(NSString *)type
                     completion:(YSCompleteHandler)completion;


/**
 忘记密码

 @param mobile      手机号
 @param msgCode     验证码
 @param password    新密码
  @param type       1.手机； 2.邮箱
 */
+ (void)ForgetPasswordMobile:(NSString *)mobile
                     msgCode:(NSString *)msgCode
                    password:(NSString *)password
                        type:(NSString *)type
                  completion:(YSCompleteHandler)completion;


/**
 登录

 @param mobile 账号
 @param password 密码
 */
+ (void)loginServiceMobile:(NSString *)mobile
                  password:(NSString *)password
                completion:(YSCompleteHandler)completions;

@end
