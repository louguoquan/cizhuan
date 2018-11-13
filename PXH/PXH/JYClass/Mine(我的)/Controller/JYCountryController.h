//
//  JYCountryController.h
//  PXH
//
//  Created by LX on 2018/6/15.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSPlainTableViewController.h"

@interface JYCountryController : YSPlainTableViewController

@property (nonatomic, copy) void(^selectEndBlock)(NSString *country, NSString *Id);

@end
