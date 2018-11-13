//
//  YSPayViewController.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBaseScrollViewController.h"

@interface YSPayViewController : YSBaseScrollViewController

@property (nonatomic, strong) NSString  *orderId;

@property (nonatomic, assign) CGFloat   totalPrice;


@end
