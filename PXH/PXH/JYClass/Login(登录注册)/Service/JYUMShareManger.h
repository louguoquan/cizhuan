//
//  JYUMShareManger.h
//  PXH
//
//  Created by LX on 2018/6/2.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UMCommon/UMCommon.h>//基础库
#import <UMShare/UMShare.h>//分享
#import <UShareUI/UShareUI.h>//分享面板

#import "JYShareView.h"//自定义分享面板


typedef NS_ENUM(NSInteger, PlatformType)
{
    PlatformType_Sina_WX_QQ = 0,
    PlatformType_All,
};

typedef NS_ENUM(NSUInteger, ShareType)
{
    ShareType_Text = 0,//文本
    ShareType_Image,//图片
    ShareType_TextImage,//文本 + 图片
    ShareType_WebLink,//网页链接
    ShareType_Music,//音乐
    ShareType_Video,//视频
    ShareType_Emotion,//表情
    ShareType_MinProgram,//微信小程序
};

@interface JYUMShareManger : NSObject

///单例获取UMShareManger对象
+ (instancetype)sharedManger;
    
/**
 注册UM，配置分享平台
 
 在AppDelegate的didFinishLaunchingWithOptions:方法中调用
 */
- (BOOL)UMShareApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
    

///** 设置系统回调(仅支持iOS9.0及以上) */
//- (BOOL)UMShareApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
//    
/** 设置系统回调(支持所有) */
- (BOOL)UMShareApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

    
#pragma mark
#pragma mark  ----- < 分享类型 > -----

#pragma mark -- 自定义事件（copy， 保存图片等）
/**
 idx: 根据需要自己设置
 */
@property (nonatomic, copy) void(^customOperateBlock)(SPlatformType type);

#pragma mark -- 分享图片
// 分享图片 {"thumb":"thumbImgurl","original":@"originalImgurl"}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType date:(id)data;

#pragma mark -- 定制Text类型分享面板预定义平台
    /**
     文本分享
     @param vc            super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 data = @"text"
     */
- (void)customTextShareWithVC:(id)vc
                 platformType:(PlatformType)platformType
                     textData:(id)data;
    
#pragma mark -- 定制Image类型分享面板预定义平台
    /**
     图片分享
     @param vc            super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"thumb":"thumbImgurl","original":@"originalImgurl"}
     */
- (void)customImageShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                    imgUrlData:(id)data;
    
#pragma mark -- 定制Web类型分享面板预定义平台
    /**
     网页分享
     
     分享的webUrl中若有中文需转码
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"title":"","descr":"","thumImage":"","weburl":@""}
     */
- (void)customWebShareWithVC:(id)vc
                platformType:(PlatformType)platformType
                     webData:(id)data;
    
#pragma mark -- 分享图文（支持新浪微博）
    /**
     分享图文（支持新浪微博）
     
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"text":"xxx","thumbImage":"icon","shareImage":@"url"} //如果有缩略图，则设置缩略图
     */
- (void)customImage_textXinLangShareWithVC:(id)vc
                              platformType:(PlatformType)platformType
                                   webData:(id)data;
    
#pragma mark -- 分享音乐
    /**
     分享音乐
     
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","musicUrl":"url"}
     */
- (void)customMusicShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                       webData:(id)data;
    
#pragma mark -- 分享视频
    /**
     分享视频
     
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","videoUrl":"url"}
     */
- (void)customVedioShareWithVC:(id)vc
                  platformType:(PlatformType)platformType
                       webData:(id)data;
    
#pragma mark -- 分享微信表情
    /**
     分享微信表情
     
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","imgFile":"xxxFile","type":"gif/png/jpg"}
     */
- (void)customEmoticonShareWithVC:(id)vc
                     platformType:(PlatformType)platformType
                          webData:(id)data;
    
#pragma mark -- 分享微信小程序
    /**
     分享微信小程序
     
     @param vc           super VC
     @param platformType 分享平台选择
     @param data         分享类型固定参数 {"title":"xxx","descr":"xxx","webpageUrl":"兼容微信低版本网页地址","userName":"小程序username","path":"小程序页面路径，如 pages/page10007/page10007","logo":"logo.png"}
     */
- (void)customMiniProgramShareWithVC:(id)vc
                        platformType:(PlatformType)platformType
                             webData:(id)data;


@end
