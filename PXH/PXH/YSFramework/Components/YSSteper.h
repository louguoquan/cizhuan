//
//  YSNumHelper.h
//  ZSMMember
//
//  Created by yu on 16/8/16.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NumChangeHandler)(NSInteger num, BOOL isIncrement);

@interface YSSteper : UIView

@property (nonatomic, copy)   NumChangeHandler  block;

@property (nonatomic, copy) void(^NumChange)(NSInteger num);

@property (nonatomic, assign) NSInteger minValue;

@property (nonatomic, assign) NSInteger maxValue;

@property (nonatomic, assign) NSInteger defaultValue;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) UITextField       *tf;


@end
