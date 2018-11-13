//
//  JYVerifFundsPwsController.h
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSBaseScrollViewController.h"

typedef NS_ENUM(NSInteger, PushVerifFundsType) {
    PushVerifFundsType_Phone = 0, //换绑手机
    PushVerifFundsType_Email = 1, //换绑邮箱
};

@interface JYVerifFundsPwsController : YSBaseScrollViewController

@property (nonatomic, assign) PushVerifFundsType      pushType;

@end
