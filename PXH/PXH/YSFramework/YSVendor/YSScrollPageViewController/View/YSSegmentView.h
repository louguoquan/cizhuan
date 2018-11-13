//
//  YSSegmentView.h
//  HouseDoctorMonitor
//
//  Created by yu on 2017/4/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSSegmentItem.h"

typedef void(^SegmentUpdateHandler)(YSSegmentItem *item);

@interface YSSegmentView : UIView

@property (nonatomic, strong) UIView        *containerView;

@property (nonatomic, assign) id            itemConfigDelegate;

@property (nonatomic, assign) NSInteger     currentIndex;

- (instancetype)initWithFrame:(CGRect )frame
                 segmentStyle:(YSSegmentStyle *)segmentStyle
                   viewModels:(NSArray *)viewModels
         segmentUpdateHandler:(SegmentUpdateHandler)updateBlock
                 clickHandler:(SegmentDidClickHandler)block;

    //设置选中的标签
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;

    //设置滑动进度
- (void)adjustUIWithProgress:(CGFloat)progress
                    oldIndex:(NSInteger)oldIndex
                currentIndex:(NSInteger)currentIndex;

    //刷新
- (void)reloadTitlesWithNewViewModels:(NSArray *)viewModels;

@end
