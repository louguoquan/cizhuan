//
//  YSScrollPageViewController.h
//  HouseDoctorMonitor
//
//  Created by yu on 16/8/27.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseViewController.h"

#import "YSSegmentView.h"

@class YSScrollPageViewController;

@protocol YSScrollPageViewControllerDataSource <NSObject>

/**
 获取标题数组   可以是NSAttributedString/NSString
 */
- (NSArray *)titlesForPageViewController;

/**
 获取子视图类型数组
*/
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index;

@optional

/**
 获取子标题数组   可以是NSAttributedString/NSString
 */
- (NSArray<NSString *> *)subTitlesForPageViewController;

/**
 图片数组  可以是UIImage/image.url
 */
- (NSArray *)iconImageForPageViewController;

/**
 图片数组  可以是UIImage/image.url
 */
- (NSArray *)selectedIconImagePageViewController;

- (YSSegmentStyle *)segmentStyleForPageViewController;

/**
 为子视图传递参数
 */
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index;


/**
 外部调整item选中与非选中的状态
 */
- (void)adjustSegementItem:(YSSegmentItem *)item;

@end

@interface YSScrollPageViewController : YSBaseScrollViewController<YSScrollPageViewControllerDataSource>

@property (nonatomic, assign) NSInteger         currentIndex;

@property (nonatomic, strong) YSSegmentView     *segmentView;

- (void)renderUI;

/*通知所有子视图刷新   想要刷新的子视图也需要实现此方法*/
- (void)refresh;

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**  给外界重新设置视图内容的标题的方法 */
- (void)reloadChildVcs;

- (void)reloadTitles;

@end
