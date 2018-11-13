//
//  JYShareView.h
//  PXH
//
//  Created by LX on 2018/6/8.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPopupView.h"

typedef NS_ENUM(NSInteger, SPlatformType) {
    SPlatformType_WechatSession,
    SPlatformType_WechatTimeLine,
    SPlatformType_QQ,
    SPlatformType_Qzone,
    SPlatformType_Tim,
    SPlatformType_Sina,
    SPlatformType_CloneURL,
    SPlatformType_SaveImage,
};

typedef void(^SelectTypeBlock)(NSInteger idx, SPlatformType type);

@interface JYShareView : JYPopupView


/**
 初始化分享view，并配置分享平台
 
 @param typeArray 分享平台类型数组（为了解决微信或QQ未安装，点击时坐标错误，要与titleArray和imgArray顺序对应）
 */
-(instancetype)initWithItemTitleArray:(NSArray *)titleArray
                           imageArray:(NSArray *)imgArray
                    PlatformTypeArray:(NSArray *)typeArray
                         selTypeBlock:(SelectTypeBlock)block;


/** 点击分享按钮后的回调 */
@property (nonatomic, strong) SelectTypeBlock   selBlock;

@end
