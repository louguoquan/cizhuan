//
//  JYSendCodeButton.h
//  PXH
//
//  Created by LX on 2018/5/30.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYSendCodeButton : UIButton

@property (nonatomic, assign) NSInteger seconds;
- (void)setUpTimer;

/**
 @param seconds 倒计时秒数
 */
- (instancetype)initWithSeconds:(NSInteger)seconds currentVC:(id)vc action:(SEL)action;

/**
 发送短信、邮箱验证码
 
 @param mobile  账号
 @param yzm     图形验证码
 @param type    1. 手机；2.邮箱
 */
- (void)sendCodeMobile:(NSString *)mobile yzm:(NSString *)yzm type:(NSString *)type;


@end
