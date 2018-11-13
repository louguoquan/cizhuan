//
//  YSBaseViewController.h
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+Sunday.h"

typedef void(^PopBackHandler)(id object);

@interface YSBaseViewController : UIViewController

@property (nonatomic, strong) PopBackHandler    block;

@property (nonatomic, assign) NSInteger     pageIndex;

- (BOOL)prefersNavigationBarHidden;

- (void)judgeLoginActionWith:(NSInteger)type;

- (void)setNav;

- (void)back;


@end
