//
//  YSCateHeaderView.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateHeaderView.h"
#import "YSButton.h"

#import "YSCategory.h"

@interface YSCateHeaderView ()

@property (nonatomic, strong) NSMutableArray    *buttonArray;

@end

@implementation YSCateHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setCateArray:(NSArray *)cateArray {
    _cateArray = cateArray;
    
    [self removeAllSubviews];
    
    NSInteger count = MIN(_cateArray.count, 8);
    
    CGFloat height = 104.f;
    CGFloat width = self.width / 4.0;
    for (NSInteger i = 0; i < count; i ++) {
        NSInteger x = i % 4;
        NSInteger y = i / 4;
        YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
        button.imageViewSize = CGSizeMake(60, 60);
        button.space = 12;
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:HEX_COLOR(@"666666") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 7) {
            button.imageView.contentMode = UIViewContentModeCenter;
            [button setImage:[UIImage imageNamed:@"cate_more"] forState:UIControlStateNormal];
            [button setTitle:@"查看更多" forState:UIControlStateNormal];
        }else {
            YSCategory *cate = _cateArray[i];
            [button sd_setImageWithURL:[NSURL URLWithString:cate.logo] forState:UIControlStateNormal];
            [button setTitle:cate.name forState:UIControlStateNormal];
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.left.offset(x * width);
            make.top.offset(y * height);
        }];
        
        [_buttonArray addObject:button];
    }
    
    NSInteger row = (count + 3) / 4;
    self.height = row * height;
}


- (void)btnDidClick:(UIButton *)button {
    if (self.block) {
        self.block(button.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
