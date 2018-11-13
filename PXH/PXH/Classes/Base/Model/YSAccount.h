//
//  YSAccount.h
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAccount : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, assign) NSInteger accountCount;

@property (nonatomic, strong) NSString  *accountId;

@property (nonatomic, strong) NSString  *accountName;

@property (nonatomic, strong) NSString  *accountNo;

@property (nonatomic, strong) NSString  *accountNo2;

@property (nonatomic, assign) CGFloat   amount;

@property (nonatomic, strong) NSString  *birthday;

@property (nonatomic, strong) NSString  *carItemCount;

@property (nonatomic, strong) NSString  *identityNo;

@property (nonatomic, strong) NSString  *inviteCode;

@property (nonatomic, assign) BOOL      isVip;

@property (nonatomic, strong) NSString  *logo;

@property (nonatomic, strong) NSString  *mobile;

@property (nonatomic, strong) NSString  *nickName;

@property (nonatomic, strong) NSString  *openid;

@property (nonatomic, strong) NSString  *realName;

@property (nonatomic, strong) NSString  *recId;

@property (nonatomic, strong) NSString  *recMobile;

@property (nonatomic, strong) NSString  *recName;

@property (nonatomic, strong) NSString  *regTime;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSString  *scoreStr;

@property (nonatomic, strong) NSString  *sex;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString  *unionid;

@property (nonatomic, strong) NSString  *viewMobile;

@property (nonatomic, strong) NSString  *withdrawAmount;

@property (nonatomic, strong) NSString  *isSetPayPwd;

@property (nonatomic, assign) CGFloat reward;

+ (YSAccount *)sharedAccount;

+ (void)saveAccount:(YSAccount *)account;

+ (void)deleteAccount;

@end
