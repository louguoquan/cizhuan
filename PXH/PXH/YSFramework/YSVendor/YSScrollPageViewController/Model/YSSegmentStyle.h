//
//  YSSegmentStyle.h
//  HouseDoctorMonitor
//
//  Created by yu on 16/8/26.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YSSegmentItemType) {
    YSSegmentItemTypeForText = 0,
    YSSegmentItemTypeForImage,
    YSSegmentItemTypeForTextAndImage,
    YSSegmentItemTypeForSubTitle,
};


@interface YSSegmentStyle : NSObject

/**
    SegmentItem 类型
 */
@property (nonatomic, assign) YSSegmentItemType     segmentItemType;

/**
    SegmentItem 图片尺寸
 */
@property (nonatomic, assign) CGSize    iconSize;

/**
    SegmentItem 标题与图片的间距
 */
@property (nonatomic, assign) CGFloat   lineSpacing;

/** 是否滚动标题 默认为NO 设置为NO的时候所有的标题将不会滚动, 和系统的segment效果相似 */
@property (nonatomic, assign) BOOL      canScrollTitle;

@property (nonatomic, assign) CGFloat   itemWidth;

@property (nonatomic, assign) CGFloat   itemHeight;

/** 标题之间的间隙 默认为15.0 */
@property (assign, nonatomic) CGFloat   itemMargin;

    /*-------------------------------字体相关------------------------*/
/** 标题的字体 默认为14 */
@property (nonatomic, strong) UIFont    *titleFont;

//子标题
@property (nonatomic, strong) UIFont    *subTitleFont;

@property (nonatomic, strong) UIColor   *normalSubTitleColor;

@property (nonatomic, strong) UIColor   *selectedSubTitleColor;
//子标题结束

/** 标题缩放倍数, 默认1.3 */
@property (nonatomic, assign) CGFloat   titleBigScale;

/** 是否缩放标题 默认为NO*/
@property (nonatomic, assign) BOOL      scaleTitle;

/** 标题一般状态的颜色 */
@property (nonatomic, strong) UIColor   *normalTitleColor;

/** 标题选中状态的颜色 */
@property (nonatomic, strong) UIColor   *selectedTitleColor;

/** 标题一般状态的背景颜色 */
@property (nonatomic, strong) UIColor   *normalBgColor;

/** 标题选中状态的背景颜色 */
@property (nonatomic, strong) UIColor   *selectedBgColor;

/** 是否颜色渐变 默认为NO*/
@property (nonatomic, assign) BOOL      gradualChangeTitleColor;

    /*-------------------------------MaskView------------------------*/
/** MaskView背景颜色 */
@property (nonatomic, strong) UIColor   *maskViewColor;

/** 是否展示maskView 默认不展示 */
@property (nonatomic, assign) BOOL      showMaskView;

@property (nonatomic, assign) CGFloat   maskViewWidth;

/** 是否显示滚动条 默认为YES*/
@property (nonatomic, assign) BOOL      showScrollLine;

/** 滚动条颜色*/
@property (nonatomic, strong) UIColor   *scrollLineColor;

@property (nonatomic, strong) UIImage   *scrollLineImage;

@property (nonatomic, assign) CGSize    scrollLineSize;

/** segmentView背景颜色 */
@property (nonatomic, strong) UIColor   *backgroundColor;

@property (nonatomic, strong) UIColor   *containerBackgroundColor;

@property (nonatomic, strong) UIColor   *bottomLineColor;

@property (nonatomic, assign) CGFloat   segmentBottomInsets;

@end
