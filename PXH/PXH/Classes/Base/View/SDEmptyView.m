//
//  SDEmptyView.m
//  PXH
//
//  Created by futurearn on 2017/11/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "SDEmptyView.h"

@implementation SDEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.emptyView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 83, CGRectGetHeight(self.frame) / 2 - 106, 165, 112)];
        [self addSubview:self.emptyView];

        
        self.emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_emptyView.frame) + 10, ScreenWidth, 20)];
        self.emptyLabel.textColor = HEX_COLOR(@"#333333");
        self.emptyLabel.textAlignment = NSTextAlignmentCenter;
        self.emptyLabel.text = @"暂无数据";
        self.emptyLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.emptyLabel];

    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    _emptyView.image = [UIImage imageNamed:imageName];
}

- (void)setText:(NSString *)text
{
    _emptyLabel.text = text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
