//
//  MMAddressView.h
//  QingTao
//
//  Created by yu on 16/4/22.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "MMPopupView.h"

#import "YSRegion.h"

typedef void(^SelectRegionHandler)(YSRegion *provice,YSRegion *city,YSRegion *district);

@interface MMAddressView : MMPopupView

@property (nonatomic, copy) SelectRegionHandler block;

@end
