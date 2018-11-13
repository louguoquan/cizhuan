//
//  YSProductTableViewCell.h
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSProduct.h"

@interface YSProductTableViewCell : UITableViewCell

@property (nonatomic, strong) YSProduct     *product;

@property (nonatomic, copy) void(^addShopCart)(NSString *ID);

@end
