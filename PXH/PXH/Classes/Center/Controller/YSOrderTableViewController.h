//
//  YSOrderTableViewController.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGroupedTableViewController.h"

@interface YSOrderTableViewController : YSGroupedTableViewController

@property (nonatomic, copy) void(^refreshBadgeValue)();

@end
