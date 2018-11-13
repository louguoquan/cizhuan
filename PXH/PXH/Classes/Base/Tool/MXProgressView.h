//
//  MXProgressView.h
//  PXH
//
//  Created by futurearn on 2017/12/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXProgressView : UIView

@property (nonatomic, assign)CGFloat progress;

- (void)updateViewWith:(CGFloat)progress;
@end
