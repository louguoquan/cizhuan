//
//  JYMarketAdvertiseView.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JYCmsIndexModel.h"

typedef void (^AdvertiseViewHide)();

@interface JYMarketAdvertiseView : UIView

@property (nonatomic,strong)JYCmsIndexModel *model;

@property (nonatomic,strong)AdvertiseViewHide AdvertiseViewHide;

@end
