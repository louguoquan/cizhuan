//
//  YSImagesView.h
//  ZSMMember
//
//  Created by yu on 16/7/19.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageClickHandler)(NSInteger tag);

@interface YSImagesView : UIView

@property (nonatomic, assign) NSInteger column;

@property (nonatomic, assign) CGFloat   itemWidth;

@property (nonatomic, assign) CGFloat   itemMargin;

@property (nonatomic, copy) NSArray     *images;

@property (nonatomic, copy) ImageClickHandler   block;

@end
