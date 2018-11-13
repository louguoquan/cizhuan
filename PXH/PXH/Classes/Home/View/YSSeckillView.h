//
//  YSSeckillView.h
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSSeckillProduct.h"

@interface YSSeckillView : UIView


@property (nonatomic, strong) YSSeckillProduct  *seckillProduct;
//type 0为限量秒杀  1为首页和商品详情
@property (nonatomic, assign) NSInteger type;

@end
