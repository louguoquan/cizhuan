//
//  JYTextField.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTextField.h"

@implementation JYTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect leftRect = [super leftViewRectForBounds:bounds];
    leftRect.origin.x += 10; //右边偏10
    return leftRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rightRect = [super rightViewRectForBounds:bounds];
    rightRect.origin.x -= 10; //左边偏10
    return rightRect;
}



@end
