//
//  YSEditImageItem.h
//  ZSMMember
//
//  Created by yu on 16/8/15.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^deleteHandler)(NSInteger index);

@interface YSEditImageItem : UIButton

@property (nonatomic, copy) deleteHandler   block;

@property (nonatomic, strong) UIImage   *contentImage;

@property (nonatomic, assign) BOOL      editEnable;

@end
