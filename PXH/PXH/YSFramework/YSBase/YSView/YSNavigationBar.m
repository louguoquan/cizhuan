//
//  YSNavigationView.m
//  ZSMMember
//
//  Created by yu on 16/8/11.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSNavigationBar.h"

@implementation YSNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.translucent = YES;
    
    self.navigationItem = [[UINavigationItem alloc] init];
    [self pushNavigationItem:self.navigationItem animated:YES];
    
    [self ys_setBgAlpha:0];

}

- (void)ys_setBgAlpha:(CGFloat)alpha
{
    UIView *view = [self.subviews firstObject];
    view.alpha = alpha;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
