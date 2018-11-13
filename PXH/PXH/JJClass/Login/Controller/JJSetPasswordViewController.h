//
//  JJSetPasswordViewController.h
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "YSBaseScrollViewController.h"

@interface JJSetPasswordViewController : YSBaseScrollViewController


@property (nonatomic,assign)BOOL isResetPwd;

@property (nonatomic,strong)NSString *type;  //4:手机注册 5:邮箱注册
@property (nonatomic,strong)NSString *mobileOrEmail;

@end
