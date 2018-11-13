//
//  YSButton.h
//  HouseDoctorMember
//
//  Created by yu on 2017/7/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YSButtonImagePosition) {
    YSButtonImagePositionLeft = 0,
    YSButtonImagePositionRight,
    YSButtonImagePositionTop,
    YSButtonImagePositionBottom,
};

@interface YSButton : UIButton

+ (instancetype)buttonWithImagePosition:(YSButtonImagePosition)imagePosition;

/** 默认 CGSizeZero */
@property (nonatomic, assign) CGSize    imageViewSize;

@property (nonatomic, assign) CGFloat   space;

@property (nonatomic, strong) NSIndexPath   *indexPath;

@property (nonatomic, strong) UIImageView   *ysImageView;

- (void)setBadgeValue:(NSInteger)value;

@end
