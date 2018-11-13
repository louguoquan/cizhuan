////
////  AppDelegate+SDRemoteopushService.m
////  QingTao
////
////  Created by yu on 16/4/5.
////  Copyright © 2016年 com.sunday-mobi. All rights reserved.
////
//
//#import "AppDelegate+SDRemoteopushService.h"
//
//#import "YSMainTabBarViewController.h"
//#import "YSMessageViewController.h"
//#import "YSMessageListViewController.h"
//#import "YSTravelDetailViewController.h"
//
//#import "YSRewardView.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"
//#import <EBForeNotification.h>
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//#import <UserNotifications/UserNotifications.h>
//#endif
//
//#define kGtAppId        @"WZl49nk1j0AxMp0obmu6l7"
//#define kGtAppKey       @"OGuErQjuWT7dBJF1P3XDt1"
//#define kGtAppSecret    @"vju9NsgcAg5blMQDmAw4V5"
//
//static NSString * __clientId = nil;
//
//@implementation AppDelegate (SDRemoteopushService)
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (void)remotePushApplication:(UIApplication *)application
//didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//{
//    // [ GTSdk ]：自定义渠道
//    [GeTuiSdk setChannelId:@"YLFMember_iOS"];
//    
//    // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT创建个推实例
//    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
//    
//    // 注册APNs - custom method - 开发者自定义的方法
//    [self registerRemoteNotification];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitClientId) name:kSubmitCIDNotification object:nil];
//    
//    [GeTuiSdk resetBadge];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    
//}
//
///******************************************************************/
//- (void)handlerRemoteNotification:(NSDictionary *)dictionary
//{
//    NSInteger code = [dictionary[@"code"] integerValue];
//    
//    switch (code) {
//        case 9001:  //系统消息
//        {
//            [YSPublicInfo sharedInfo].sysMessCount += 1;
//            [YSPublicInfo sharedInfo].hasNewMessage = YES;
//        }
//            break;
//        case 1001:  //订单消息
//        {
//            [YSPublicInfo sharedInfo].orderMessCount += 1;
//            [YSPublicInfo sharedInfo].hasNewMessage = YES;
//        }
//            break;
//        case 0:     //群消息
//        {
//            [YSPublicInfo sharedInfo].tripMessCount += 1;
//            [YSPublicInfo sharedInfo].hasNewMessage = YES;
//        }
//            break;
//        case 1: //讨赏
//        {
//            NSString *tripId = dictionary[@"tripId"];
//            NSString *memberId = dictionary[@"memberId"];
//            if (USER_ID && tripId && ([USER_ID integerValue] == [memberId integerValue])) {
//                //讨赏
//                YSRewardView *view = [[YSRewardView alloc] initWithFrame:CGRectZero tips:dictionary[@"content"] type:2];
//                [view setBlock:^(NSDictionary *parameters){
//                    [self prepay:parameters tripId:tripId];
//                }];
//                [view show];
//            }
//        }
//            break;
//        case 10086:    //团结束
//        case 9007:      //导游添加、删除团员
//        case 9005:  //导游发起签到
//        {   //更新首页数据
//            [[NSNotificationCenter defaultCenter] postNotificationName:kGroupDidEndNotification object:nil];
//        }
//            break;
//        case 9006:  //导游发布行程
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kPublishTravelNotification object:nil userInfo:@{@"hidden":@(NO)}];
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    /*-------------------------------1.0------------------------------------------*/
//    //    NSInteger code = [dictionary[@"code"] integerValue];
//    //    switch (code) {
//    //        case 9001:
//    //        {
//    //            [YSPublicInfo sharedInfo].sysMessCount += 1;
//    //            [YSPublicInfo sharedInfo].hasNewMessage = YES;
//    //        }
//    //            break;
//    //        case 1001:
//    //        {
//    //            [YSPublicInfo sharedInfo].orderMessCount += 1;
//    //            [YSPublicInfo sharedInfo].hasNewMessage = YES;
//    //        }
//    //            break;
//    //        case 0:     //群消息
//    //        {
//    //            if (USER_ID && USER_TRIPID) {
//    //                YSMainTabBarViewController *tabbarVc = (YSMainTabBarViewController *)self.window.rootViewController;
//    //                if ([tabbarVc isKindOfClass:[YSMainTabBarViewController class]]) {
//    //                    YSNavigationController *nav = [tabbarVc selectedViewController];
//    //
//    //                    if (![nav.topViewController isKindOfClass:[YSMessageViewController class]] || [nav.topViewController isKindOfClass:[YSMessageListViewController class]]) {
//    //                        YSMessageViewController *messageVc = [YSMessageViewController new];
//    //                        [nav pushViewController:messageVc animated:YES];
//    //                    }
//    //                }
//    //
//    //                [YSPublicInfo sharedInfo].tripMessCount += 1;
//    //                [YSPublicInfo sharedInfo].hasNewMessage = YES;
//    //            }
//    //        }
//    //            break;
//    //        case 1: //讨赏
//    //        {
//    //            if (USER_ID && USER_TRIPID) {
//    //                //讨赏
//    //                YSRewardView *view = [[YSRewardView alloc] initWithFrame:CGRectZero tips:dictionary[@"content"] type:2];
//    //                [view setBlock:^(NSDictionary *parameters){
//    //                    [self prepay:parameters tripId:dictionary[@"tripId"]];
//    //                }];
//    //                [view show];
//    //            }
//    //        }
//    //            break;
//    //        case 10086:    //团结束
//    //        case 9007:      //导游添加、删除团员
//    //        {
//    //            [[NSNotificationCenter defaultCenter] postNotificationName:kGroupDidEndNotification object:nil];
//    //        }
//    //            break;
//    //        case 9005:  //导游发起签到
//    //        {
//    //            [[NSNotificationCenter defaultCenter] postNotificationName:kStartSignNotification object:nil];
//    //        }
//    //            break;
//    //        case 9006:  //导游发布行程
//    //        {
//    //            if (USER_ID && USER_TRIPID) {
//    //                YSMainTabBarViewController *tabbarVc = (YSMainTabBarViewController *)self.window.rootViewController;
//    //                if ([tabbarVc isKindOfClass:[YSMainTabBarViewController class]]) {
//    //                    YSNavigationController *nav = [tabbarVc selectedViewController];
//    //
//    //                    if (![nav.topViewController isKindOfClass:[YSTravelDetailViewController class]]) {
//    //                        YSTravelDetailViewController *vc = [YSTravelDetailViewController new];
//    //                        vc.url = dictionary[@"url"];
//    //                        [nav pushViewController:vc animated:YES];
//    //                    }
//    //                }
//    //            }
//    //        }
//    //            break;
//    //
//    //        default:
//    //            break;
//    //    }
//}
//
////
//- (void)prepay:(NSDictionary *)param tripId:(NSString *)tripId
//{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"memberId"] = USER_ID;
//    parameters[@"tripId"] = tripId;
//    parameters[@"money"] = @([param[@"price"] doubleValue] * 100);
//    NSInteger type = [param[@"type"] integerValue] + 1;
//    parameters[@"type"] = @(type);
//    parameters[@"tag"] = @(1);
//    WS(weakSelf);
//    [[SDDispatchingCenter sharedCenter] POST:rewardPrepay_url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        [weakSelf rewardGuide:responseObject[@"result"] type:type];
//    } failure:^(NSURLSessionDataTask *task, SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//    }];
//}
//
////打赏
//- (void)rewardGuide:(NSDictionary *)parameters type:(NSInteger)type
//{
//    WS(weakSelf);
//    if (type == 1) {
//        [[AlipaySDK defaultService] payOrder:parameters[@"aliPayString"] fromScheme:APP_SCHEME callback:^(NSDictionary *resultDic) {
//            if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"打赏成功" delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
//            }
//        }];
//    }else {
//        PayReq *request = [[PayReq alloc] init];
//        request.partnerId = kWechatPartnerId;
//        request.prepayId = parameters[@"prepayId"];
//        request.package = @"Sign=WXPay";
//        request.nonceStr = parameters[@"nonceStr"];
//        request.timeStamp = [parameters[@"timeStamp"] intValue];
//        request.sign = parameters[@"signType"];
//        [WXApi sendReq:request];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaySuccessed) name:kWechatPaySuccessedNotification object:nil];
//    }
//}
//
//- (void)wechatPaySuccessed
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"打赏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
//    
//}
//
//#pragma mark - 用户通知(推送) _自定义方法
//
///** 注册远程通知 */
//- (void)registerRemoteNotification
//{
//    
//    /*
//     警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
//     */
//    
//    /*
//     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
//     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
//     */
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = self;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
//            if (!error) {
//                NSLog(@"request authorization succeeded!");
//            }
//        }];
//        
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//#else // Xcode 7编译会调用
//        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//#endif
//    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }
//    //    else {    //iOS 7
//    //        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
//    //                                                                       UIRemoteNotificationTypeSound |
//    //                                                                       UIRemoteNotificationTypeBadge);
//    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
//    //    }
//}
//
//#pragma mark - 远程通知(推送)回调
//
///** 远程通知注册成功委托 */
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
//    
//    // [ GTSdk ]：向个推服务器注册deviceToken
//    [GeTuiSdk registerDeviceToken:token];
//}
//
///** 远程通知注册失败委托 */
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
//}
//
//- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    [GeTuiSdk resume];
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送
//
///** APP已经接收到“远程”通知(推送) - 透传推送消息  */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
//    
//    
//    // [ GTSdk ]：将收到的APNs信息传给个推统计
//    [GeTuiSdk handleRemoteNotification:userInfo];
//    
//    // 控制台打印接收APNs信息
//    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//#pragma mark - iOS 10中收到推送消息
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0    //xcode8编译
////  iOS 10: App在前台获取到通知
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    
//    
//    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
//    
//    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//}
//
////  iOS 10: 点击通知进入App时触发
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    
//    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
//    
//    // [ GTSdk ]：将收到的APNs信息传给个推统计
//    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
//    
//    completionHandler();
//}
//#endif
//
//
//#pragma mark - GeTuiSdkDelegate
//
///** SDK启动成功返回cid */
//- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
//    // [4-EXT-1]: 个推SDK已注册，返回clientId
//    NSLog(@"\n>>[GTSdk RegisterClient]:%@\n\n", clientId);
//    
//    __clientId = clientId;
//    
//    [self submitClientId];
//}
//
///** SDK遇到错误回调 */
//- (void)GeTuiSdkDidOccurError:(NSError *)error {
//    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
//    NSLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
//}
//
///** SDK收到透传消息回调 */
//- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
//    
//    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
//    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
//    
//    // 数据转换
//    NSString *payloadMsg = nil;
//    if (payloadData) {
//        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
//    }
//    
//    // 控制台打印日志
//    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : @""];
//    NSLog(@"\n>>[GTSdk ReceivePayload]:%@\n\n", msg);
//    
//    [GeTuiSdk resetBadge];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    
//    //    {"tripId":1,"title":"导游讨赏","content":"12345 上山打老虎",@"code"}
//    
//    if ([[payloadMsg jsonValueDecoded] isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *dictionary = [payloadMsg jsonValueDecoded];
//        [self handlerRemoteNotification:dictionary];
//        
//        if (!offLine) {
//            NSMutableDictionary *aps = [NSMutableDictionary dictionary];
//            aps[@"alert"] = dictionary[@"content"];
//            aps[@"ysTitle"] = dictionary[@"title"];
//            NSDictionary *userInfo = @{@"aps":aps};
//            [EBForeNotification handleRemoteNotification:userInfo soundID:1312 isIos10:iOS(10.0)];
//        }
//    }
//}
//
///** SDK收到sendMessage消息回调 */
//- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
//    // 发送上行消息结果反馈
//    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
//    NSLog(@"\n>>[GTSdk DidSendMessage]:%@\n\n", msg);
//}
//
///** SDK运行状态通知 */
//- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
//    // 通知SDK运行状态
//    NSLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
//}
//
///** SDK设置推送模式回调 */
//- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
//    if (error) {
//        NSLog(@"\n>>[GTSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
//        return;
//    }
//    
//    NSLog(@"\n>>[GTSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
//}
//
//#pragma mark - private
//
//- (void)submitClientId
//{
//    if (__clientId && USER_ID) {
//        NSDictionary *parameters = @{@"objId":USER_ID,@"clientId":__clientId,@"appType":@(2),@"memberType":@(2)};
//        [[SDDispatchingCenter sharedCenter] POST:saveToken_url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"\n>>>[SubmitClientId success]\n\n");
//        } failure:^(NSURLSessionDataTask *task, SDError *error) {
//            NSLog(@"\n>>>[SubmitClientId error]\n\n");
//        }];
//    }
//}
//
//@end
