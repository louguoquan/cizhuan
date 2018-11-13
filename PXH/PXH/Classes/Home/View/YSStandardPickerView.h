//
//  YSProductBuyView.h
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSProductService.h"

typedef NS_ENUM(NSUInteger, YSStandardPickerType) {
    YSStandardPickerTypeAddToShoppingCart,
    YSStandardPickerTypePurchaseNow,
};

@interface YSStandardPickerView : MMPopupView

@property (nonatomic, strong) YSProductDetail   *productDetail;

@property (nonatomic, assign) YSStandardPickerType  pickerType;

@property (nonatomic, copy) void(^needLogin)();

- (instancetype)initWithProduct:(YSProductDetail *)product completion:(YSCompleteHandler)block;

@end
