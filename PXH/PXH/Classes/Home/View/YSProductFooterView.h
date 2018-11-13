//
//  YSProductFooterView.h
//  PXH
//
//  Created by futurearn on 2018/4/17.
//  Copyright © 2018年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSProductDetail.h"
@interface YSProductFooterView : UIView

@property (nonatomic, strong) YSProductDetail *detail;

@property (nonatomic, copy) void (^jumpToOtherProduct)(NSString *productID);

@end
