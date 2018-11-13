//
//  YSPayManager.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPayManager.h"


@implementation YSPayManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    static YSPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[YSPayManager alloc] init];
    });
    return instance;
}

#pragma mark - WX_Delegate

//- (void)onResp:(BaseResp *)resp {
//
//    if ([resp isKindOfClass:[PayResp class]]) {
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//
//        if (_block) {
//            if (resp.errCode == WXSuccess) {
//                _block(YSPayTypeWechatPay, YES, nil);
//            }else {
//                _block(YSPayTypeWechatPay, NO, resp.errStr);
//            }
//        }
//    }
//
//}

#pragma mark - Ali_Delegate

- (void)aliPayCallBackHandler:(NSURL *)url {
//    // 支付跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        if (_block) {
//            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
//                _block(YSPayTypeAliPay, YES, nil);
//            }else {
//                _block(YSPayTypeAliPay, NO, resultDic[@"memo"]);
//            }
//        }
//    }];
//    
//    // 授权跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//        // 解析 auth code
//        NSString *result = resultDic[@"result"];
//        NSString *authCode = nil;
//        if (result.length>0) {
//            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//            for (NSString *subResult in resultArr) {
//                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                    authCode = [subResult substringFromIndex:10];
//                    break;
//                }
//            }
//        }
//        NSLog(@"授权结果 authCode = %@", authCode?:@"");
//    }];

}


@end
