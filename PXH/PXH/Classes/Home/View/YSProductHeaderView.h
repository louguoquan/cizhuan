//
//  YSProductHeaderView.h
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSButton.h"

#import "UIView+YSRecalculate.h"

#import "YSProductDetail.h"
#import "JJShopModel.h"

@interface YSProductHeaderView : UIView

@property (nonatomic, strong) YSProductDetail   *detail;

@property (nonatomic, strong) JJShopModel   *detailJJ;

@property (nonatomic, strong) YSButton  *collectionButton;

@property (nonatomic, copy) void (^changeState)(NSInteger tag);

@end
