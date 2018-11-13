//
//  YSFans.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSFans : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *nickName;//用户昵称

@property (nonatomic, strong) NSString  *realName;//真实姓名

@property (nonatomic, strong) NSString  *mobile;//联系电话

@property (nonatomic, strong) NSString  *accountNo;//账号

@property (nonatomic, strong) NSString  *regTime;//注册时间

@property (nonatomic, strong) NSString  *logo;//头像

@property (nonatomic, assign) NSInteger sex;

@end
