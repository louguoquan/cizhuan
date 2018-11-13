//
//  YSCartProductTableViewCell.h
//  PXH
//
//  Created by yu on 2017/8/1.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSCartProduct.h"

@interface YSCartProductTableViewCell : UITableViewCell

@property (nonatomic, strong) YSCartProduct     *product;
@property (nonatomic, assign) NSInteger  indexPath;

@property (nonatomic, copy) void (^checkAction)(NSInteger tag);

@end
