//
//  YSTextField.m
//  HouseDoctorMember
//
//  Created by yu on 2017/6/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTextField.h"

@implementation YSTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    
    CGFloat left = self.textInsets.left;
    CGFloat right = self.textInsets.right;
    CGFloat top = self.textInsets.top;
    CGFloat bottom = self.textInsets.bottom;
    rect.origin.x += left;
    rect.origin.y += top;
    rect.size.width -= (left + right);
    rect.size.height -= (top + bottom);
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    
    CGRect rect = [super textRectForBounds:bounds];
    
    CGFloat left = self.textInsets.left;
    CGFloat right = self.textInsets.right;
    CGFloat top = self.textInsets.top;
    CGFloat bottom = self.textInsets.bottom;
    rect.origin.x += left;
    rect.origin.y += top;
    rect.size.width -= (left + right);
    rect.size.height -= (top + bottom);
    
    
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
