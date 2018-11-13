//
//  JYEmptyView.m
//  PXH
//
//  Created by louguoquan on 2018/5/31.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYEmptyView.h"

@interface JYEmptyView ()

@end

@implementation JYEmptyView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    [self addSubview:self.label];
    [self addSubview:self.loginBtn];
    [self addSubview:self.iconImageView];
    

    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-100);
        make.width.mas_offset(90);
        make.height.mas_offset(35);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-100);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
    
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom);
        make.height.mas_offset(12);
        make.left.right.equalTo(self);
    }];
    
    self.loginBtn.hidden = YES;
    
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconImageView.hidden = NO;
    
    self.label.text = @"暂无数据";
}

- (void)login:(UIButton *)btn{
    
      [[NSNotificationCenter defaultCenter] postNotificationName:JYTokenExpiredReLogin object:self];

}

- (void)setShowString:(NSString *)showString
{
    self.label.text = showString;
    
}

-(UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:16];
        _label.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    }
    return _label;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        [_loginBtn setTitle:@"登录账号" forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 4.0f;
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _loginBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        [_loginBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
        
    }
    return _loginBtn;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"dataNull"];
    }
    return _iconImageView;
}

@end
