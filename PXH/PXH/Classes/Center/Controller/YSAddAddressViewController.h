//
//  YSAddAddressViewController.h
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBaseScrollViewController.h"

#import "YSAddressService.h"

@interface YSAddAddressViewController : YSBaseScrollViewController

@property (nonatomic, strong) YSAddress  *address;

@property (nonatomic, copy) void(^saveAddress)(id result);

@property (nonatomic, assign)NSInteger type;

@end
