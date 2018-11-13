//
//  SDPayWayView.h
//  QingTao
//
//  Created by yu on 16/5/26.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDPayWayCell.h"

@interface SDPayWayView : UIView

@property (nonatomic, assign) SDPayWay  payWay;

- (instancetype)initWithTypes:(NSArray *)types;

@end
