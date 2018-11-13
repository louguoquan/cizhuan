//
//  YSPayManager.h
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <WXApi.h>
//#import <AlipaySDK/AlipaySDK.h>

typedef NS_ENUM(NSUInteger, YSPayType) {
    YSPayTypeAliPay,
    YSPayTypeWechatPay,
};

typedef void(^PayHandler)(YSPayType type, BOOL isSuccess, id error);

@interface YSPayManager : NSObject//<WXApiDelegate>

@property (nonatomic, copy) PayHandler  block;

+ (instancetype)sharedManager;

- (void)aliPayCallBackHandler:(NSURL *)url;

@end
