//
//  JJFoundService.h
//  PXH
//
//  Created by louguoquan on 2018/8/2.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJHomeBaseModel.h"
#import "JJHomeModel.h"



@interface JJFoundService : NSObject

/** 首页banner */
+ (void)JJMobileCmsConsultationCompletion:(YSCompleteHandler)completion;

/** 首页通知*/
+ (void)JJMobileCmsNoticeCompletion:(YSCompleteHandler)completion;

/** 合作入驻*/
+ (void)JJMobileCmsCooperation:(NSString *)content name:(NSString *)name email:(NSString *)email mobile:(NSString *)mobile Completion:(YSCompleteHandler)completion;

/** 机界狗下载地址*/
+ (void)JJDownloadAddressCompletion:(YSCompleteHandler)completion;

/** 交易所下载地址*/
+ (void)JJDownloadCompletion:(YSCompleteHandler)completion;

@end
