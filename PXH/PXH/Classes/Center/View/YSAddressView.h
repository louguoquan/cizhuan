//
//  YSAddressView.h
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSAddress.h"
#import "YSServiceStation.h"

@interface YSAddressView : UIView

@property (nonatomic, strong) YSAddress     *address;

@property (nonatomic, strong) YSServiceStation     *station;

@property (nonatomic, strong) UILabel   *titleLabel;

@end
