//
//  JYGatherAddManagerController.h
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSPlainTableViewController.h"

@interface JYGatherAddManagerController : YSPlainTableViewController

@property (nonatomic, copy) void(^c2cSelBankNumBlock)(NSString *bankNum, NSString *bankId);

@end
