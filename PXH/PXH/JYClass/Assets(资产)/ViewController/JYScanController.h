//
//  JYScanController.h
//  PXH
//
//  Created by LX on 2018/6/4.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "DCScanningViewController.h"


@interface JYScanController : DCScanningViewController

@property (nonatomic, copy) void(^scanResultBlock)(NSString *result);

@end
