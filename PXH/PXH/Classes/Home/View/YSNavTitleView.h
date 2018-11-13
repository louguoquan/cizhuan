//
//  YSNavTitleView.h
//  PXH
//
//  Created by 刘鹏程 on 2017/11/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSButton.h"

@interface YSNavTitleView : UIView

@property (nonatomic, strong) YSButton *apartmentButton;
@property (nonatomic, strong) UIButton *messageButton;

//@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, strong) UILabel *numlabel;

@property (nonatomic, copy) void(^changeCityBlock)();
@property (nonatomic, copy) void(^messageBlock)();
@property (nonatomic, copy) void(^searchProductBlock)();
@property (nonatomic, copy) void(^searchAllProductBlock)(NSString * name);

- (id)initWithFrame:(CGRect)frame type:(NSInteger)type;

@end
