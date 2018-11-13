//
//  YSConfirmOrderHeaderView.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+YSRecalculate.h"
#import "YSAddress.h"

@interface YSConfirmOrderHeaderView : UIView

@property (nonatomic, strong) YSAddress    *address;

@property (nonatomic, copy)   YSCompleteHandler     block;

@property (nonatomic, copy) YSCompleteHandler newAddress;
@end
