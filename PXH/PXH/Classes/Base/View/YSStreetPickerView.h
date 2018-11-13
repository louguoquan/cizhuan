//
//  YSStreetPickerView.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <MMPopupView/MMPopupView.h>

#import "YSRegion.h"

@interface YSStreetPickerView : MMPopupView

@property (nonatomic, copy)   YSCompleteHandler   block;

- (instancetype)initWithDistrictId:(NSString *)districtId;

@end
