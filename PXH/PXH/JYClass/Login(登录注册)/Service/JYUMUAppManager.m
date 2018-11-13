//
//  JYUMUAppManager.m
//  PXH
//
//  Created by LX on 2018/5/31.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYUMUAppManager.h"

#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>

#define UApp_Key   @"5b0fd3b1f43e487a5c000177"

#define CHANNEL    @""

@implementation JYUMUAppManager


+ (void)registUApp
{
    [UMConfigure setEncryptEnabled:YES];//打开加密传输
    [UMConfigure setLogEnabled:YES];//设置打开日志
    
//    [MobClick setCrashReportEnabled:NO];   // 关闭Crash收集,
    
    [UMConfigure initWithAppkey:UApp_Key channel:CHANNEL];
    
    [UMCommonLogManager setUpUMCommonLogManager];
}



@end
