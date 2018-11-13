//
//  AppDelegate.m
//  PXH
//
//  Created by yu on 16/6/4.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "AppDelegate.h"

#import "YSPayManager.h"
#import "YSNetWork.h"
#import "YSIndexViewController.h"
#import "YSMainTabBarViewController.h"
#import <GTSDK/GeTuiSdk.h>
//#import "UMMobClick/MobClick.h"
#import <UserNotifications/UserNotifications.h>
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Bugly/Bugly.h>
#define GtAppID @"Mf4TvlzbhWAZjznwkflHk8"
#define GtAppSecret @"GQX7ILo2wQAyThLzXbEgc6"
#define GtAppKey @"WgUF3ana1i69Xj5csVASo5"
//#warning -------------  个推单独用 AppDelegate+SDRemoteopushService 实现
//#import "AppDelegate+SDRemoteopushService.h"

//#import <UMSocialCore/UMSocialCore.h>

#import "JYUMShareManger.h"
#import "JYMarketService.h"
#import "JXGuideFigure.h"
//#import <Meiqia/MeiQiaSDK/MQManager.h>
#import "JYMarketService.h"


@interface AppDelegate ()<GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

//@property (nonatomic, strong) BMKMapManager *mapManager;

@property (nonatomic, copy) NSString *clientId;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    
    
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:1.5];

    
    
#pragma mark  集成第一步: 初始化,  参数:appkey  ,尽可能早的初始化appkey.
//    [MQManager initWithAppkey:@"fb95712556595be97cf79651d50a4fa5" completion:^(NSString *clientId, NSError *error) {
//        if (!error) {
//            NSLog(@"美洽 SDK：初始化成功");
//        } else {
//            NSLog(@"error:%@",error);
//        }
//    }];
    
    
    [self initThirdPartyConfig:application launchOption:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //    [[UMSocialManager defaultManager] openLog:YES];
    
    //    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // 设置自定义日志上报的级别，默认不上报自定义日志
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    //    [Bugly startWithAppId:@"25a548252f" config:config];
    
#warning 修改待定
    
    if ([JYAccountModel sharedAccount].token.length>0) {
        [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
    }else{
         [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeLogin];
    }
    
    
//    
//    [JXGuideFigure figureWithImages:@[@"引导1",@"引导2",@"引导3",@"引导4"] finashMainViewController:self.window.rootViewController];
    
    [self.window makeKeyAndVisible];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    
    //个推
    //    [GeTuiSdk startSdkWithAppId:GtAppID appKey:GtAppKey appSecret:GtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"" forKey:@"city"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginMessageWithTimeOut) name:@"loginMessageWithTimeOut" object:nil];
    
    
    if ([JYDefaultDataModel sharedDefaultData].systemTimeLast) {
        
        [self isShowMsgTime];
    }
    
    
    //版本更新检查
    [self checkVerison];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)loginMessageWithTimeOut{
    
    
    [self secondThreadTimer];
    
    __weak AppDelegate *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%d",[NSRunLoop currentRunLoop] == [NSRunLoop mainRunLoop]);
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:weakSelf selector:@selector(secondThreadTimer) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        [[NSRunLoop currentRunLoop] run];
        
    });
    
}

-(BOOL)isShowMsgTime{
    
    NSDate *beginD = [NSDate dateWithTimeIntervalSinceNow:[JYDefaultDataModel sharedDefaultData].systemTimeLast/1000];
    NSDate *endD = [NSDate dateWithTimeIntervalSinceNow:[JYDefaultDataModel sharedDefaultData].systemTime/1000];
    NSTimeInterval value=[endD timeIntervalSinceDate:beginD];
    
    //如果时间大于5分钟，5*60秒，则显示时间
    
    if (value>3*60*30) {

//    发出重新登录通知
        [JYAccountModel deleteAccount];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"timeOutLogin" object:nil];
        return true;
        
    }
    
    return NO;
    
}


- (void)secondThreadTimer{
    
//    [JYMarketService UpdateGetSystemTime:@"1" completion:^(id result, id error) {
//        JYDefaultDataModel *model = [JYDefaultDataModel sharedDefaultData];
//        model.systemTime = [result[@"result"] longLongValue];
//        [JYDefaultDataModel saveDefaultData:model];
//        
//    }];
}


- (void)checkVerison{
    
    
    if ([JYAccountModel sharedAccount].token.length>0) {
        [JJMineService JJMobileMemberOneDayLoginCompletion:^(id result, id error) {
            
        }];
    }
   
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//获取项目版本号

    [JYMarketService UpdateCheck:@"1" completion:^(id result, id error) {
        NSDictionary *dict = result;
        
        if ([dict[@"code"] integerValue] == 0 ) {
            
            
            NSString *version1 = dict[@"result"][@"versionName"];
            NSString *downLoadURL = dict[@"result"][@"url"];
            NSString *versionContent = dict[@"result"][@"versionContent"];
            if (version1.floatValue>version.floatValue) {
                NSString *msg = versionContent;
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"升级提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在升级" style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
                    
                    NSURL *url = [NSURL URLWithString:downLoadURL];
                    [[UIApplication sharedApplication]openURL:url];
                }];
                [alertController addAction:otherAction];
                [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            }}
        
    }];
    
}


#pragma mark -
- (void)initThirdPartyConfig:(UIApplication *)application launchOption:(NSDictionary *)launchOptions {
    //初始化bugly
    //    [Bugly startWithAppId:<#(NSString * _Nullable)#> config:<#(BuglyConfig * _Nullable)#>];
    
    //友盟
    //    [[UMSocialManager defaultManager] setUmSocialAppkey:kUmengKey];
    //
    ////    UMConfigInstance.appKey = @"5a2bbe52a40fa3436a00018e";
    ////    UMConfigInstance.channelId = @"App Store";
    ////    [MobClick startWithConfigure:UMConfigInstance];
    //
    //    //微信
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWechatID appSecret:kWechatSecret redirectURL:@"http://mobile.umeng.com/social"];
    ////    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    //
    //    [WXApi registerApp:kWechatID];
    
    //UM
    [[JYUMShareManger sharedManger] UMShareApplication:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // 支付跳转支付宝钱包进行支付，处理支付结果
    if ([url.host isEqualToString:@"safepay"]) {
        [[YSPayManager sharedManager] aliPayCallBackHandler:url];
        return YES;
    }
    //        //微信
    //    if ([url.host isEqualToString:@"pay"]) {
    //        return [WXApi handleOpenURL:url delegate:[YSPayManager sharedManager]];
    //    }
    //
    //    return [[UMSocialManager defaultManager] handleOpenURL:url];
    
    //UM
    [[JYUMShareManger sharedManger] UMShareApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[YSPayManager sharedManager] aliPayCallBackHandler:url];
        return YES;
    }
    
    //    if ([url.host isEqualToString:@"pay"]) {
    //        return [WXApi handleOpenURL:url delegate:[YSPayManager sharedManager]];
    //    }
    //
    //    return [[UMSocialManager defaultManager] handleOpenURL:url];
    
    
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    
//    /*
//
//    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
//    if ([url.host isEqualToString:@"safepay"]) {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
//            NSLog(@"result = %@",resultDic);
//        }];
//        return YES;
//    }
//    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
//        
//        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
//            NSLog(@"result = %@",resultDic);
//        }];
//        return YES;
//    }
//     */
//    return [UMSocialSnsService handleOpenURL:url];
//}

//- (void)uploadClientID {
//    
//    if (_clientId && [YSAccount sharedAccount].ID) {
//        [YSNetWork uploadClientID:_clientId];
//    }
//}


- (void)handlePushNotificationWithUserInfo:(NSDictionary *)userInfo {
    
    if (![YSAccount sharedAccount].ID) {
        return;
    }
    
    YSMainTabBarViewController *mainVc = (YSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([mainVc isKindOfClass:[YSMainTabBarViewController class]]) {
        YSNavigationController *nav = mainVc.selectedViewController;
        [nav pushViewController:[YSIndexViewController new] animated:YES];
    }
}

- (NSString *)formateTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // [ GTSdk ]：Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - 用户通知(推送) _自定义方法

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
#pragma mark  集成第四步: 上传设备deviceToken
//    [MQManager registerDeviceToken:deviceToken];
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    [_viewController logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}

#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - (App运行在后台)  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    // 处理跳转
    [self handlePushNotificationWithUserInfo:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - iOS 10中收到推送消息

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCoHmpletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    [self handlePushNotificationWithUserInfo:response.notification.request.content.userInfo];
    
    completionHandler();
}

#endif


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    _clientId = clientId.copy;
    //    [self uploadClientID];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    if (!offLine) {
        if (![YSAccount sharedAccount].ID) {
            return;
        }
        
        
        YSMainTabBarViewController *mainVc = (YSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MMPopupItemHandler block = ^(NSInteger index) {
            if ([mainVc isKindOfClass:[YSMainTabBarViewController class]]) {
                YSNavigationController *nav = mainVc.selectedViewController;
                [nav pushViewController:[YSIndexViewController new] animated:YES];
            }
        };
        
        MMAlertView *alert = [[MMAlertView alloc] initWithTitle:@"" detail:@"有新的消息，是否查看" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"查看", MMItemTypeHighlight, block)]];
        alert.attachedView = mainVc.view;
        [alert show];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //重置角标计数
    [GeTuiSdk resetBadge];
    // APP 清空角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 页面显示：上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"message ====== %@", record);
}

/** SDK遇到错误回调 */
//- (void)GeTuiSdkDidOccurError:(NSError *)error {
//    // 页面显示：个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
////    [_viewController logMsg:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]];
//}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 页面显示更新通知SDK运行状态
    
}

/** SDK设置推送模式回调  */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    // 页面显示错误信息
    if (error) {
        return;
    }
}


/** 是否清除token */
- (void)isCleanToken
{
    JYAccountModel *account = [JYAccountModel sharedAccount];
    if (!account.token.length) return;
    
    //当前日期时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970]*1000;//毫秒
    
    if (account.expiredTime.doubleValue > interval) return;
    
    //清除用户信息
    [JYAccountModel deleteAccount];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    
    JYDefaultDataModel *model = [JYDefaultDataModel sharedDefaultData];
    if (model.systemTime) {
        model.systemTimeLast = model.systemTime;
    }
    [JYDefaultDataModel saveDefaultData:model];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
//    [self secondThreadTimer];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        if ([JYDefaultDataModel sharedDefaultData].systemTimeLast) {
//
//            [self isShowMsgTime];
//        }
//
//    });
    
 
    
#pragma mark  集成第二步: 进入前台 打开meiqia服务
//    [MQManager openMeiqiaService];
    [self checkVerison];
    if ([JYAccountModel sharedAccount].token.length>0) {
        [JJMineService JJMobileMemberOneDayLoginCompletion:^(id result, id error) {
            
        }];
    }
    
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    JYDefaultDataModel *model = [JYDefaultDataModel sharedDefaultData];
    if (model.systemTime) {
        model.systemTimeLast = model.systemTime;
    }
    [JYDefaultDataModel saveDefaultData:model];
    
#pragma mark  集成第三步: 进入后台 关闭美洽服务
//    [MQManager closeMeiqiaService];
}

@end
