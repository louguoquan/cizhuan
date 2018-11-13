//
//  YSSearchBar.m
//  YddMember
//
//  Created by yu on 2016/11/8.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSSearchBar.h"

@implementation YSSearchBar

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
    self.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchframe_search"]];
    self.leftView = imageView;
    
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:13];
    
    self.layer.cornerRadius = 1;
    self.layer.masksToBounds = YES;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(9, (bounds.size.height - 18) / 2.0, 18, 18);    
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(36, 0, bounds.size.width - 36, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(36, 0, bounds.size.width - 36, bounds.size.height);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(36, 0, bounds.size.width - 36, bounds.size.height);
}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds;
//- (CGRect)editingRectForBounds:(CGRect)bounds;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
