//
//  YSMacro.h
//  PXH
//
//  Created by yu on 16/6/4.
//  Copyright © 2016年 yu. All rights reserved.
//

#ifndef YSMacro_h
#define YSMacro_h

//重写NSLog,Debug模式下打印日志和当前行数
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(fmt, ...) {}
#endif


// weakSelf
#define WS(weakSelf) __weak __typeof(self)weakSelf = self;

// 沙盒文档目录
//沙盒目录
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

// 屏幕相关
#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight    ([UIScreen mainScreen].bounds.size.height)
#define kStatusBarHeight    ([UIApplication sharedApplication].statusBarFrame.size.height)
#define kNavigationBarHeight    44

#define SCREEN_SCALE    [UIScreen mainScreen].scale

// 颜色相关
#define RGBA_COLOR(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB_COLOR(r, g, b)  RGBA_COLOR(r, g, b, 1)

#define HEX_COLOR(hex)  [UIColor sd_colorWithHexString:hex]

#define RANDOM_COLOR   RGB_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

    //常用颜色定义
#define MAIN_COLOR  HEX_COLOR(@"#ffffff")

#define LINE_COLOR  HEX_COLOR(@"#E5E5E5")

#define SEPARATOR_COLOR  HEX_COLOR(@"#E5E5E5")

#define BORDER_COLOR    HEX_COLOR(@"#C1C1C1")

#define BACKGROUND_COLOR    [UIColor groupTableViewBackgroundColor]

#define kPlaceholderImage   [UIImage imageNamed:@"eth"]

#define kHeaderDefaultImage   [UIImage imageNamed:@"header_default"]

    //常用字段
#define USER_ID     [YSAccount sharedAccount].ID
#define USER_Mobile     [YSAccount sharedAccount].viewMobile

#define APP_SCHEME  @"PINXINGHUI"

    //百度地图
#define kBaiduMapKey    @"WGcj9t4QUOp4hPGETWybquNyaQV2S9hL"

    //微信
#define kWechatID       @"wxcc2c72c950fd9caa"
#define kWechatSecret   @"18c5244d304ef5ed2575ba8839951324"
    //微信支付
#define kWechatPartnerID    @"1488006572"

    //友盟
#define kUmengKey       @"595b6ba6f43e484aab000038"


// 型号(尺寸相关)
#define iPhone4 (480 == ([[UIScreen mainScreen] bounds].size.height) ? YES : NO)
#define iPhone5 (568 == ([[UIScreen mainScreen] bounds].size.height) ? YES : NO)
#define iPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define iPhone6p (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)

// 系统相关
#define iOS(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version ? YES : NO)

#endif /* YSMacro_h */
