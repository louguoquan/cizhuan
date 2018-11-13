//
//  AppDelegate+SDRemoteopushService.h
//  QingTao
//
//  Created by yu on 16/4/5.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "AppDelegate.h"

#import "GeTuiSdk.h"

@interface AppDelegate (SDRemoteopushService)<GeTuiSdkDelegate>

- (void)remotePushApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

    //上传个推CID
- (void)submitClientId;

@end
