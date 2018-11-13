//
//  JYSignInPageController.h
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSScrollPageViewController.h"

typedef NS_ENUM(NSInteger, PushType) {
    PushType_SignIn = 0, //注册
    PushType_RetrievePws = 1, //找回密码
};

@interface JYPageController : YSScrollPageViewController

@property (nonatomic, assign) PushType      pushType;

@end
