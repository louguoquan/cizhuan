//
//  JYBindingController.h
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSBaseScrollViewController.h"

//typedef NS_ENUM(NSInteger, PushBindType) {
//    PushBindType_Phone = 0, //绑定手机
//    PushBindType_Email = 1, //绑定邮箱
//};

@interface JYBindingController : YSBaseScrollViewController

//@property (nonatomic, assign) PushBindType      pushType;

@property (nonatomic, copy)   NSString          *navTitle;

//type: 1,手机； 2，邮箱
@property (nonatomic, copy) void(^bindSuccessBlock)(NSInteger type, NSString *phoneOrEmail);

@end
