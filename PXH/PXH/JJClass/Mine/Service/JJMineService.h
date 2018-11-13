//
//  JJMineService.h
//  PXH
//
//  Created by louguoquan on 2018/7/31.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJShareModel.h"
#import "JJMessageModel.h"

@interface JJMineService : NSObject

/** 绑定邮箱 */
+ (void)requestMobileMemberBindMail:(NSString *)mail checkCode:(NSString *)checkCode Completion:(YSCompleteHandler)completion;

/** 绑定手机 */
+ (void)requestMobileMemberBindMobile:(NSString *)mobile checkCode:(NSString *)checkCode Completion:(YSCompleteHandler)completion;

/** 关于我们 */
+ (void)requestMobileMemberAboutUsCompletion:(YSCompleteHandler)completion;

/** 邀请 */
+ (void)JJMobileMemberRecommendBeiTaCompletion:(YSCompleteHandler)completion;


/** 帮助中心 */
+ (void)JJMobileMemberHelpCenterCompletion:(YSCompleteHandler)completion;


/** 每日登录 */
+ (void)JJMobileMemberOneDayLoginCompletion:(YSCompleteHandler)completion;
/** 客服邮箱 */
+ (void)JJMobileMemberOfficialEmailCompletion:(YSCompleteHandler)completion;

/** 消息中心 */
+ (void)JJMobilMemberMessageCenterWithPage:(NSInteger )page Completion:(YSCompleteHandler)completion;

/** 获取个人信息 */
+ (void)JJMobileMemberGetUserInfoCompletion:(YSCompleteHandler)completion;

/** 设置支付密码 */
+ (void)JJMobileMemberPayPasswordWithPassword:(NSString *)pwd Completion:(YSCompleteHandler)completion;

/** 是否设置支付密码 */
+ (void)JJMobileMemberJudgePasswordJDGCompletion:(YSCompleteHandler)completion;

@end
