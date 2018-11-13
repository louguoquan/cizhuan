//
//  YSChangePasswordViewController.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBaseScrollViewController.h"

@interface YSChangePasswordViewController : YSBaseScrollViewController

    //1. 忘记密码   2. 修改密码 3. 修改支付密码 10.绑定手机号
@property (nonatomic, assign) NSInteger     type;

@end
