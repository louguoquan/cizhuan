//
//  YSTagViewCell.m
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTagViewCell.h"

@interface YSTagViewCell ()

@property (nonatomic, strong) UIView    *bgView;

@property (nonatomic, strong) UILabel   *titleLabel;

@end

@implementation YSTagViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    WS(weakSelf);

    _bgView = [UIView new];
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.borderColor = MAIN_COLOR.CGColor;
    _bgView.clipsToBounds = YES;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];

    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
}

- (void)setSpec:(YSStandard *)spec {
    _spec = spec;
    
    _titleLabel.text = _spec.value;

    if (_spec.selected) {
        _bgView.layer.borderWidth = 0;
        _bgView.backgroundColor = MAIN_COLOR;

        _titleLabel.textColor = [UIColor whiteColor];
    }else {
        _bgView.layer.borderWidth = 1;
        _bgView.backgroundColor = [UIColor whiteColor];

        _titleLabel.textColor = MAIN_COLOR;
    }
    
}

@end
