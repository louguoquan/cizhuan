//
//  CTProductDetailBottomView.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductDetailBottomView.h"
#import "YSButton.h"

@interface CTProductDetailBottomView ()

@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)YSButton *button;
@property (nonatomic,strong)YSButton *button1;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UILabel *bottomLabel;

@end

@implementation CTProductDetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.leftView.mas_right);
    }];
    self.rightView.backgroundColor = HEX_COLOR(@"#2E77F9");
    
    [self.rightView addSubview:self.topLabel];
    [self.rightView addSubview:self.bottomLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightView).offset(10);
        make.height.mas_offset(20);
        make.right.left.equalTo(self.rightView);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom);
        make.height.mas_offset(20);
        make.right.left.equalTo(self.rightView);
    }];
    
    
    _button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
    _button.titleLabel.font = [UIFont systemFontOfSize:11];
    [_button setTitleColor:HEX_COLOR(@"#808080") forState:UIControlStateNormal];
    [_button setTitle:@"收藏" forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
    _button.space = 5;
    MJWeakSelf;
    [_button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        
    }];
    [self.leftView addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.offset(0);
        make.width.mas_equalTo(60);
    }];
    
    _button1 = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
    
    _button1.titleLabel.font = [UIFont systemFontOfSize:11];
    [_button1 setTitleColor:HEX_COLOR(@"#808080") forState:UIControlStateNormal];
    [_button1 setTitle:@"对比" forState:UIControlStateNormal];
    [_button1 setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
    _button1.space = 5;
    [_button1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        
    }];
    [self.leftView addSubview:_button1];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(60);
        make.left.equalTo(self.button.mas_right);
        make.right.equalTo(self.leftView);
    }];
    
    self.topLabel.text = @"询底价";
    self.bottomLabel.text = @"经销商为您报价";
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ask:)];
    self.rightView.userInteractionEnabled = YES;
    [self.rightView addGestureRecognizer:tap];
    
}

- (void)ask:(UITapGestureRecognizer *)tap{
    
    if (self.CTBottomAskClick) {
        self.CTBottomAskClick();
    }
    
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
    }
    return _leftView;
}

- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
    }
    return _rightView;
}

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textColor = HEX_COLOR(@"#ffffff");
        _topLabel.font = [UIFont systemFontOfSize:17];
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textColor = HEX_COLOR(@"#ffffff");
        _bottomLabel.font = [UIFont systemFontOfSize:15];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}

@end
