//
//  JYUMShareManger.m
//  PXH
//
//  Created by LX on 2018/6/2.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYUMShareManger.h"

#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>

#warning 记得更改
/** 友盟 */
NSString *const UMENG_APPKEY = @"5b0fd3b1f43e487a5c000177";

/** Wechat */
NSString *const WECHAT_APPID = @"wx74ac5df744cc5a42";
NSString *const WECHAT_APPSECRET = @"3a304ba08446f21df0ac000f2ad74392";

/** Sina */
NSString *const SINA_APPKEY = @"3921700954";
NSString *const SINA_APPSECRET = @"04b48b094faeb16683c32669824ebdad";
NSString *const SINA_RedirectURL = @"https://sns.whalecloud.com/sina2/callback";

/** QQ */
NSString *const QQ_APPKEY = @"1105821097";
//NSString *const QQ_APPSECRET = @"";
//NSString *const QQ_RedirectURL = @"";


@interface JYUMShareManger ()

@property (nonatomic, strong) UIViewController      *superVC;

///自定义分享面板
@property (nonatomic, strong) JYShareView           *shareView;
    
@end

@implementation JYUMShareManger

static  JYUMShareManger *shareManger;
    
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManger = [super allocWithZone:zone];
    });
    return shareManger;
}
    
    
+ (instancetype)sharedManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManger = [[self alloc] init];
    });
    return shareManger;
}


-(JYShareView *)shareView
{
    if (!_shareView) {
        
        NSArray *titleArr = @[@"微信", @"朋友圈", @"复制链接"];//@"新浪", @"QQ", , @"保存图片"
        NSArray *imgAtt = @[@"share_wx", @"share_pyq", @"share_copy",];//@"share_wb", @"share_qq", @"share_save"
        NSArray *typeArr = @[@(SPlatformType_WechatSession),
                             @(SPlatformType_WechatTimeLine),
//                             @(SPlatformType_Sina),
//                             @(SPlatformType_QQ),
                             @(SPlatformType_CloneURL),
//                             @(SPlatformType_SaveImage),
                             ];
        
        _shareView = [[JYShareView alloc] initWithItemTitleArray:titleArr imageArray:imgAtt PlatformTypeArray:typeArr selTypeBlock:nil];
        _shareView.dk_backgroundColorPicker = DKColorPickerWithKey(VIEW_BG);//BAR
    }
    return _shareView;
}


    
- (BOOL)UMShareApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#warning 删除调试
//    [UMConfigure setLogEnabled:YES];//仅供调试，发布必须删除
    [UMConfigure initWithAppkey:UMENG_APPKEY channel:@"App Store"];
    
    // U-Share 平台设置
    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    //设置分享面板展示平台
    //    [self configUSharePreDefinePlatformType:PlatformType_All];
    
    return YES;
}
    
//- (BOOL)UMShareApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}
    
/** 设置系统回调(支持所有) */
- (BOOL)UMShareApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
    
    
- (void)confitUShareSettings
{
    /** 打开图片水印*/
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /** 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名*/
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
    
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPID appSecret:WECHAT_APPSECRET redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WECHAT_APPID appSecret:WECHAT_APPSECRET redirectURL:nil];
    
    /* 设置分享到QQ互联的appID*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPKEY appSecret:nil redirectURL:nil];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:QQ_APPKEY appSecret:nil redirectURL:nil];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Tim appKey:QQ_APPKEY appSecret:nil redirectURL:nil];

    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPKEY  appSecret:SINA_APPSECRET redirectURL:SINA_RedirectURL];
    
    /** 移除相应平台的分享 */
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite), @(UMSocialPlatformType_TencentWb)]];
}
    
    
#pragma mark -- 定制自己的分享面板预定义平台

- (void)configUMShareMenuWithVC:(id)vc platformType:(PlatformType)platformType shareType:(ShareType)shareType shareData:(id)data
{
    _superVC = vc;
    __weak typeof(self) weakself = self;
    
//自定义
    [self.shareView show];
    self.shareView.selBlock = ^(NSInteger idx, SPlatformType type) {
        
        switch (type) {
            case SPlatformType_WechatSession: {
                [weakself configUMPlatformType:UMSocialPlatformType_WechatSession shareType:shareType shareData:data];
            }
                break;
            case SPlatformType_WechatTimeLine: {
                [weakself configUMPlatformType:UMSocialPlatformType_WechatTimeLine shareType:shareType shareData:data];
            }
                break;
            case SPlatformType_Sina: {
                [weakself configUMPlatformType:UMSocialPlatformType_Sina shareType:shareType shareData:data];
            }
                break;
            case SPlatformType_QQ: {
                [weakself configUMPlatformType:UMSocialPlatformType_QQ shareType:shareType shareData:data];
            }
                break;
            case SPlatformType_Qzone: {
                
                break;
            }
            case SPlatformType_Tim: {
                
                break;
            }
        //定制操作
            case SPlatformType_CloneURL: {
//                !weakself.customOperateBlock?:weakself.customOperateBlock(type);
                
                [weakself cloneUrl:data];
            }
                break;
            case SPlatformType_SaveImage: {
//                !weakself.customOperateBlock?:weakself.customOperateBlock(type);
                
                [weakself saveImage:data];
            }
                break;
            default:
                break;
        }
    };
    
    
//UM
    /*
    [self configUSharePreDefinePlatformType:platformType];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakself configUMPlatformType:platformType shareType:shareType shareData:data];
    }];
     */
}


- (void)configUMPlatformType:(UMSocialPlatformType)platformType shareType:(ShareType)shareType shareData:(id)data
{
    switch (shareType) {
        case ShareType_Text:
            [self shareTextToPlatformType:platformType date:data];
            break;
        case ShareType_Image:
            [self shareImageToPlatformType:platformType date:data];
            break;
        case ShareType_TextImage:
            [self shareImageAndTextToPlatformType:platformType date:data];
            break;
        case ShareType_WebLink:
            [self shareWebPageToPlatformType:platformType date:data];
            break;
        case ShareType_Music:
            [self shareMusicToPlatformType:platformType date:data];
            break;
        case ShareType_Video:
            [self shareVedioToPlatformType:platformType date:data];
            break;
        case ShareType_Emotion:
            [self shareEmoticonToPlatformType:platformType date:data];
            break;
        case ShareType_MinProgram:
            [self shareMiniProgramToPlatformType:platformType date:data];
            break;
            
        default:
            break;
    }
}


- (void)configUSharePreDefinePlatformType:(PlatformType)platformType
{
    if (platformType == PlatformType_Sina_WX_QQ) {
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                                   @(UMSocialPlatformType_WechatTimeLine),
                                                   @(UMSocialPlatformType_QQ),
                                                   @(UMSocialPlatformType_Qzone),
                                                   @(UMSocialPlatformType_Tim),
                                                   @(UMSocialPlatformType_Sina),
                                                   ]];
    }
    else if (platformType == PlatformType_All) {
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                                   @(UMSocialPlatformType_WechatTimeLine),
                                                   //                                                   @(UMSocialPlatformType_QQ),
                                                   //                                                   @(UMSocialPlatformType_Qzone),
                                                   //                                                   @(UMSocialPlatformType_Tim),
                                                   //                                                   @(UMSocialPlatformType_Sina),
                                                   //                                                   @(UMSocialPlatformType_Sms),
                                                   //                                                   @(UMSocialPlatformType_Email),
                                                   ]];
    }
    
    //加入copy(根据需要加入不同的自定义平台)
    //[UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+1 withPlatformIcon:[UIImage imageNamed:@"copyinter"] withPlatformName:@"复制"];
    
    //面板位置
    //[UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    //面板Item背景
    //[UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    
    //设置分享面板的显示和隐藏的代理回调
    //[UMSocialUIManager setShareMenuViewDelegate:_superVC];
}
    
    
#pragma mark
#pragma mark  ----- < 封装定制分享类型 > -----
    
#pragma mark -- 定制Text类型分享面板预定义平台
- (void)customTextShareWithVC:(id)vc
                 platformType:(PlatformType)platformType
                     textData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_Text shareData:data];
}
    
#pragma mark -- 定制Image类型分享面板预定义平台
- (void)customImageShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                    imgUrlData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_Image shareData:data];
}
    
#pragma mark -- 定制Web类型分享面板预定义平台
- (void)customWebShareWithVC:(id)vc
                platformType:(PlatformType)platformType
                     webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_WebLink shareData:data];
}

#pragma mark -- 分享图文（支持新浪微博）
- (void)customImage_textXinLangShareWithVC:(id)vc
                              platformType:(PlatformType)platformType
                                   webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_TextImage shareData:data];
}

#pragma mark -- 分享音乐
- (void)customMusicShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                       webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_Music shareData:data];
}
    
#pragma mark -- 分享视频
- (void)customVedioShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                       webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_Video shareData:data];
}
    
#pragma mark -- 分享微信表情
- (void)customEmoticonShareWithVC:(id)vc
                     platformType:(PlatformType)platformType
                          webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_Emotion shareData:data];
}
    
#pragma mark -- 分享微信小程序
- (void)customMiniProgramShareWithVC:(id)vc
                        platformType:(PlatformType)platformType
                             webData:(id)data
{
    [self configUMShareMenuWithVC:vc platformType:platformType shareType:ShareType_MinProgram shareData:data];
}
    
    
#pragma mark
#pragma mark  ----- < 分享实现 > -----
    
#pragma mark  -- 分享文本
    // 分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    NSString *text = data;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享图片
    // 分享图片 {"thumb":"thumbImgurl","original":@"originalImgurl"}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    NSDictionary *dict = data;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = dict[@"thumb"];
    [shareObject setShareImage:dict[@"original"]];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享网页
    // 分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    NSDictionary *dict = data;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    id thumImage = dict[@"thumImage"]?dict[@"thumImage"]:[UIImage imageNamed:@"eth"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:dict[@"title"] descr:dict[@"descr"] thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl =dict[@"weburl"];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享图文（支持新浪微博）
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = data[@"text"];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = data[@"thumbImage"];
    [shareObject setShareImage:data[@"shareImage"]];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享音乐
    // {"title":"xxx","descr":"xxx","thumImage":"icon","musicUrl":"url"}
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建音乐内容对象
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:data[@"logo"]]];
    //设置音乐网页播放地址
    shareObject.musicUrl = data[@"musicUrl"];
    //            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享视频
    // {"title":"xxx","descr":"xxx","thumImage":"icon","videoUrl":"url"}
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建视频内容对象
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:data[@"logo"]]];
    //设置视频网页播放地址
    shareObject.videoUrl = data[@"videoUrl"];
    //            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享微信表情
    // {"title":"xxx","descr":"xxx","thumImage":"icon","imgFile":"xxxFile","type":"gif/png/jpg"}
- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:nil];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:data[@"imgFile"]
                                                         ofType:data[@"type"]];
    NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
    shareObject.emotionData = emoticonData;
    messageObject.shareObject = shareObject;
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
#pragma mark -- 分享微信小程序
    // {"title":"xxx","descr":"xxx","webpageUrl":"兼容微信低版本网页地址","userName":"小程序username","path":"小程序页面路径，如 pages/page10007/page10007","logo":"logo.png"}
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:@"logo"]];
    shareObject.webpageUrl = data[@"webpageUrl"];
    shareObject.userName = data[@"userName"];
    shareObject.path = data[@"path"];
    messageObject.shareObject = shareObject;
    shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:data[@"logo"] ofType:@"png"]];
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
    
    [self beginShareDisposeResult:platformType messageObject:messageObject currentViewController:self.superVC];
}
    
    
    //MARK: -- 开始分享，处理分享结果
- (void)beginShareDisposeResult:(UMSocialPlatformType)platformType
                  messageObject:(UMSocialMessageObject *)messageObject
          currentViewController:(id)currentViewController
{
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id result, NSError *error) {
        
        NSString *shareResult = nil;
        if (!error) {
            shareResult = @"分享成功";
            
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = result;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",result);
            }
        }else{
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            
            NSMutableString *str = [NSMutableString string];
            if (error.userInfo) {
                for (NSString *key in error.userInfo) {
                    [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
                }
            }
            if (error) {
                shareResult = [NSString stringWithFormat:@"分享失败 error: %d\n%@",(int)error.code, str];
            }
            else{
                shareResult = [NSString stringWithFormat:@"分享失败"];
            }
        }
        
        //        [self showShareResult:shareResult];
        
        if ([shareResult isEqualToString:@"分享成功"]) {
            [MBProgressHUD showSuccessMessage:shareResult toContainer:nil];
        }
        else {
            [MBProgressHUD showErrorMessage:shareResult toContainer:nil];
        }
    }];
}

- (void)showShareResult:(NSString *)result
{
    UIAlertController *contactAC = [UIAlertController alertControllerWithTitle:@"提示" message:result preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //    [contactAC addAction:cancelAction];
    [contactAC addAction:okAction];
    
    [self.superVC presentViewController:self.superVC animated:true completion:nil];
}



//MARK: -- 复制链接
- (void)cloneUrl:(id)data
{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = data[@"weburl"];
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
}


//MARK: --  保存图片
- (void)saveImage:(id)data
{
    //从网络下载图片
    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:data[@"weburl"]]];
    UIImage *img = [UIImage imageWithData:imgData];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        ///写入图片到相册
        PHAssetChangeRequest *asset = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [MBProgressHUD showSuccessMessage:@"保存成功" toContainer:nil];
            }else{
                [MBProgressHUD showErrorMessage:@"保存失败" toContainer:nil];
            }
        });
    }];
}
    
@end
