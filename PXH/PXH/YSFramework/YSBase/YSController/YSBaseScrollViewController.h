//
//  YSBaseScrollViewController.h
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseViewController.h"
#import "YSScrollView.h"

@interface YSBaseScrollViewController : YSBaseViewController<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIView        *containerView;

@property (nonatomic, strong)   YSScrollView    *scrollView;

//设置导航栏全透明
- (UIImageView *)makeClearNavigationController;
@end
