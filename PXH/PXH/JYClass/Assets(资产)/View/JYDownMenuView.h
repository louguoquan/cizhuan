//
//  JYDownMenuView.h
//  PXH
//
//  Created by LX on 2018/6/12.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYDownMenuView : UIView

/**  数据源 */
@property (nonatomic, strong) NSArray *dataSource;

/** 选中cell的回调 */
@property (nonatomic, copy) void (^selectedCellBlack)(JYDownMenuView *menuView, NSInteger index, NSString *content);

/** 显示下拉列表*/
- (void)show;

/** 隐藏下拉列表*/
- (void)hide;


-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end
