//
//  JYMineService.h
//  PXH
//
//  Created by LX on 2018/6/1.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYMarketModel.h"
#import "JYMyProfitModel.h"
#import "JYImageModel.h"
#import "JYGatherAddModel.h"
#import "JYPresentAddModel.h"
#import "JYCmsIndexModel.h"
#import "JYCmsContentModel.h"
#import "JYEarningsModel.h"
#import "JYCommissionModel.h"
#import "JYBenefitsModel.h"

@interface JYMineService : NSObject


/**
 修改登录密码
 
 @param payPassword 密码
 @param mobile 账号
 @param checkCode 验证码
 */
+ (void)setUpLoginPassWord:(NSString *)payPassword
                    mobile:(NSString *)mobile
                 checkCode:(NSString *)checkCode
                completion:(YSCompleteHandler)completion;


/**
 设置或修改支付密码

 @param payPassword 密码
 @param mobile 账号
 @param checkCode 验证码
 */
+ (void)setUpPayPassWord:(NSString *)payPassword
                  mobile:(NSString *)mobile
               checkCode:(NSString *)checkCode
              completion:(YSCompleteHandler)completion;


/**
 上传图片

 @param images UIImage对象或UIImage对象数组
 */
+ (void)uploadImage:(id)images
         completion:(YSCompleteHandler)completion;


/** 获取收款地址列表 */
+ (void)getReceivableAddressListCompletion:(YSCompleteHandler)completion;

/**
 添加收款地址

 @param name 银行卡开户名
 @param openBank 开户行
 @param bankAddress 开户支行
 @param cardNum 银行卡号
 */
+ (void)addReceivableAddressName:(NSString *)name
                        openBank:(NSString *)openBank
                     bankAddress:(NSString *)bankAddress
                         cardNum:(NSString *)cardNum
                      completion:(YSCompleteHandler)completion;


/**
 删除收款地址列表

 @param Id 地址id
 */
+ (void)delReceivableAddressID:(NSString *)Id
                    Completion:(YSCompleteHandler)completion;


/**
币种简介列表

 */
+ (void)coinInfoCoinDesc:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion;

//static NSString *JYAddressList
//
//static NSString *JYDelAddress
//
//static NSString *JYSaveAddress


/**
 获取提币地址

 @param coinId 币种主键
 @param page 页码
 */
+ (void)coinAddressListCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 删除提币地址
 
 @param Id 地址id
 */
+ (void)delCoinAddressId:(NSString *)addressId completion:(YSCompleteHandler)completion;


/**
 保存提币地址

 @param Id 币种主键
 @param address 地址
 @param remark 地址名称(备注)
 */
+ (void)saveCoinAddressId:(NSString *)Id address:(NSString *)address remark:(NSString *)remark completion:(YSCompleteHandler)completion;


/**
 获取用户信息状态
 */
+ (void)getUserInfoStatusCompletion:(YSCompleteHandler)completion;


/**
 手机绑定

 @param mobile 手机号
 @param checkCode 手机验证码
 */
+ (void)bindMobile:(NSString *)mobile checkCode:(NSString *)checkCode completion:(YSCompleteHandler)completion;

/**
 邮箱绑定
 
 @param mobile 手机号
 @param checkCode 手机验证码
 */
+ (void)bindEmail:(NSString *)mail checkCode:(NSString *)checkCode completion:(YSCompleteHandler)completion;


/**
 获取地区列表
 */
+ (void)getCountryListCompletion:(YSCompleteHandler)completion;



/**
 实名认证

 @param proviceId 国家ID
 @param type 证件类型（1.身份证；2.护照）
 @param name 证件上的姓名
 @param idNumber 证件号
 @param certificatesA 证件正面照
 @param certificatesB 证件背面照
 @param certificatesAB 手持证件照
 */
+ (void)userAuthenticationWithProviceId:(NSString *)proviceId
                                   type:(NSString *)type
                                   name:(NSString *)name
                               idNumber:(NSString *)idNumber
                          certificatesA:(NSString *)certificatesA
                          certificatesB:(NSString *)certificatesB
                         certificatesAB:(NSString *)certificatesAB
                             completion:(YSCompleteHandler)completion;



/**
 获取资讯类列表

 @param Id 1.新手指引；2.公告中心；3.联系我们；5.费率标准；6.关于我们
  @param page 页码
 */
+ (void)cmsIndexListWithId:(NSString *)Id page:(NSInteger)page completion:(YSCompleteHandler)completion;

/**
 获取资讯类内容
 
 @param Id 列表Item对应id
 */
+ (void)cmsContentWithId:(NSString *)Id completion:(YSCompleteHandler)completion;

/**
 获取我的收益以及邀请码

 */
+ (void)fetchMyProfitCompletion:(YSCompleteHandler)completion;


/**
 获取我的邀请名单
 
 */
+ (void)fetchRecListWithPage:(NSInteger )page completion:(YSCompleteHandler)completion;


/**
 获取我的返佣名单
 
 */
+ (void)fetchMyInvitingWithPage:(NSInteger )page completion:(YSCompleteHandler)completion;

/**
 获取邀请排行榜
 
 */
+ (void)fetchRevenueRankingWithPage:(NSInteger )page completion:(YSCompleteHandler)completion;

/**
 设置默认银行卡(收款地址)

 @param Id 银行卡Id
 */
+ (void)setUpDefaultBankCardWithId:(NSString *)Id completion:(YSCompleteHandler)completion;

@end
