
//
//  YSTagHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTagHeaderView.h"

@interface YSTagHeaderView ()

@property (nonatomic, strong) UILabel   *titleLabel;

@end

@implementation YSTagHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    WS(weakSelf);
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = HEX_COLOR(@"#555555");
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(weakSelf);
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = _title;
}

@end
