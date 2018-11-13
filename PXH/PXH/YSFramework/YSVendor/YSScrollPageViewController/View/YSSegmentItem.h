//
//  YSSegmentItem.h
//  HouseDoctorMonitor
//
//  Created by yu on 2017/4/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSSegmentStyle.h"

@class YSSegmentItem;

typedef void(^SegmentDidClickHandler)(YSSegmentItem *item);

@interface YSSegmentItemViewModel : NSObject

@property (nonatomic, strong) id    normalIcon;

@property (nonatomic, strong) id    selectIcon;

@property (nonatomic, strong) id    title;

@property (nonatomic, strong) id    subTitle;

@end

@interface YSSegmentItem : UIView

@property (nonatomic, strong) UILabel       *titleLabel;

@property (nonatomic, strong) UILabel       *subTitleLabel;

@property (nonatomic, assign) BOOL          selected;

//缩放等级  默认 1.0 不缩放  只针对标题
@property (nonatomic, assign) CGFloat   currentTransformSx;

- (instancetype)initWithStyle:(YSSegmentStyle *)style
                    viewModel:(YSSegmentItemViewModel *)viewModel
                 clickHandler:(SegmentDidClickHandler)block;

- (void)setCurrentTransformSx:(CGFloat)currentTransformSx;

- (void)updateTextColorWithCurrentProgress:(CGFloat)progress selected:(BOOL)selected;

@end
