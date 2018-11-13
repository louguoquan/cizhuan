//
//  JYSearchView.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYSearchView.h"

@interface JYSearchView ()

@property (nonatomic, strong) UITextField   *textField;

@property (nonatomic, strong) UIButton      *searchBtn;

@end


@implementation JYSearchView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    WS(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.mas_equalTo(20.f);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(30.f);
    }];
    
    
    [self.textField addTarget:self action:@selector(beginSearch) forControlEvents:UIControlEventEditingChanged];
}


-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont fontWithName:@"ArialMT" size:15.f];
        _textField.placeholder = @"请输入币种简称搜索";
        
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)searchBtn
{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:0];
        [_searchBtn addTarget:self action:@selector(beginSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchBtn];
    }
    return _searchBtn;
}

- (void)beginSearch
{
    !_SearchCurrencyBlock?:_SearchCurrencyBlock(self, _textField.text);
}

@end
