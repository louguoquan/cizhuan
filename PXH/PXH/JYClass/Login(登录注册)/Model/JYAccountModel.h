//
//  JYAccountModel.h
//  PXH
//
//  Created by LX on 2018/5/31.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^BallClick)(NSInteger index);
typedef void(^BallClickReceive)();

@interface JYAccountModel : NSObject

//解挡
+ (JYAccountModel *)sharedAccount;

//归档
+ (void)saveAccount:(JYAccountModel *)account;

//删除归档
+ (void)deleteAccount;


@property (nonatomic, copy)BallClick BallClick;
@property (nonatomic, copy)BallClickReceive BallClickReceive;

@property (nonatomic, copy) NSString        *account;
@property (nonatomic, copy) NSString        *createTime;
@property (nonatomic, copy) NSString        *email;
@property (nonatomic, copy) NSString        *icon;
@property (nonatomic, copy) NSString        *loginTime;

@property (nonatomic, copy) NSString        *mobile;
@property (nonatomic, copy) NSString        *nickName;
@property (nonatomic, copy) NSString        *realName;
@property (nonatomic, copy) NSString        *recCode;
@property (nonatomic, copy) NSString        *recId;

@property (nonatomic, copy) NSString        *status;
@property (nonatomic, copy) NSString        *token;
@property (nonatomic, copy) NSString        *uid;
@property (nonatomic, copy) NSString        *updateTime;


@property (nonatomic, copy) NSString        *expiredTime;

//用户信息状态
@property (nonatomic, copy) NSString        *isMobile;
@property (nonatomic, copy) NSString        *isCertified;
@property (nonatomic, copy) NSString        *isPayPassword;
@property (nonatomic, copy) NSString        *isEmail;


@property (nonatomic, strong) NSString  *bit;
@property (nonatomic, strong) NSString  *btc;
@property (nonatomic, strong) NSString  *ct;
@property (nonatomic, strong) NSString  *deleted;
@property (nonatomic, strong) NSString  *eth;

@property (nonatomic, strong) NSString  *goc;
@property (nonatomic, strong) NSString  *head;
@property (nonatomic, strong) NSString  *ID;
@property (nonatomic, strong) NSString  *invitationNumber;
@property (nonatomic, strong) NSString  *isAgent;


@property (nonatomic, strong) NSString  *isBuy;
@property (nonatomic, strong) NSString  *level;
//@property (nonatomic, strong) NSString  *mobile;
@property (nonatomic, strong) NSString  *nickname;
@property (nonatomic, strong) NSString  *password;


@property (nonatomic, strong) NSString  *purseAddressStatus;
@property (nonatomic, strong) NSString  *recommendedCode;
@property (nonatomic, strong) NSString  *recommendedSort;
@property (nonatomic, strong) NSString  *recommenderId;
@property (nonatomic, strong) NSString  *recommenderPhone;


@property (nonatomic, strong) NSString  *recommenderType;
@property (nonatomic, strong) NSString  *reward;
@property (nonatomic, strong) NSString  *usdt;
@property (nonatomic, strong) NSString  *username;
@property (nonatomic, strong) NSString  *ut;




/*
@property (nonatomic, copy) NSString        *cityId;
@property (nonatomic, copy) NSString        *cityName;
@property (nonatomic, copy) NSString        *countryId;
@property (nonatomic, copy) NSString        *countryName;
@property (nonatomic, copy) NSString        *districtId;

@property (nonatomic, copy) NSString        *districtName;
@property (nonatomic, copy) NSString        *ID;

@property (nonatomic, copy) NSString        *isDelete;
@property (nonatomic, copy) NSString        *isGoogleCertified;

@property (nonatomic, copy) NSString        *password;
@property (nonatomic, copy) NSString        *path;
@property (nonatomic, copy) NSString        *payPassword;
@property (nonatomic, copy) NSString        *proviceId;
@property (nonatomic, copy) NSString        *provinceName;
*/

@end
