//
//  JYPasswordController.h
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSBaseScrollViewController.h"

typedef NS_ENUM(NSInteger, PushType) {
    PushType_LoginPsw = 0, //修改登录密码
    PushType_BankrollPws = 1, //设置资金密码
};

@interface JYPasswordController : YSBaseScrollViewController

@property (nonatomic, assign) PushType      pushType;

@property (nonatomic, copy) void(^setUpSuccessBlock)(PushType type);

@end
