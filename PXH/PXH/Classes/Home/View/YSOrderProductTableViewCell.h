//
//  YSOrderProductTableViewCell.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSOrderSettleModel.h"
#import "YSOrderProduct.h"

@interface YSOrderProductTableViewCell : UITableViewCell

@property (nonatomic, strong) YSSettleProduct   *product;

@property (nonatomic, strong) YSOrderProduct    *orderProduct;

@end
