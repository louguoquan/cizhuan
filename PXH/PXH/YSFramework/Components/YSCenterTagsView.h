//
//  YSCenterTagsView.h
//  PXH
//
//  Created by yu on 2017/3/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCenterTagsView : UIView

@property (nonatomic, strong) UIColor   *textColor;

@property (nonatomic, strong) UIFont    *textFont;

@property (nonatomic, strong) UIColor   *borderColor;

@property (nonatomic, assign) CGFloat   itemHeight;

@property (nonatomic, assign) CGFloat   lineSpacing;

@property (nonatomic, assign) CGFloat   columnSpacing;

- (void)setTags:(NSArray *)tags;

@end
