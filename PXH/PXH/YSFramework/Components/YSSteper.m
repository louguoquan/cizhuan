//
//  YSNumHelper.m
//  ZSMMember
//
//  Created by yu on 16/8/16.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSSteper.h"

@interface YSSteper ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton  *decrementButton;

@property (nonatomic, strong) UIButton  *incrementButton;


@end

@implementation YSSteper

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _minValue = 1;
        _maxValue = NSIntegerMax;
        _defaultValue = 1;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    
    _decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_decrementButton setImage:[UIImage imageNamed:@"shopping_cut"] forState:UIControlStateNormal];
    [_decrementButton addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_decrementButton];
    [_decrementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf.decrementButton.mas_height);
    }];
    
    _incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _incrementButton.tag = 10;
    [_incrementButton setImage:[UIImage imageNamed:@"shopping_add"] forState:UIControlStateNormal];
    [_incrementButton addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_incrementButton];
    [_incrementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf.decrementButton.mas_height);
    }];
    
    _tf = [UITextField new];
    _tf.font = [UIFont systemFontOfSize:18];
    _tf.textColor = HEX_COLOR(@"#666666");
    _tf.text = [NSString stringWithFormat:@"%zd", _defaultValue];
    _tf.textAlignment = NSTextAlignmentCenter;
    _tf.keyboardType = UIKeyboardTypeNumberPad;
    _tf.delegate = self;
    [self addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(weakSelf);
        make.left.equalTo(weakSelf.decrementButton.mas_right).offset(5);
        make.right.equalTo(weakSelf.incrementButton.mas_left).offset(-5);
    }];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}

- (void)dismiss {
    [_tf resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_NumChange) {
        _NumChange(textField.text.integerValue);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (_NumChange) {
        _NumChange(textField.text.integerValue);
    }
}

- (NSInteger)value {
    return [_tf.text integerValue];
}

#pragma mark - setter

- (void)setDefaultValue:(NSInteger)defaultValue {
    
    _defaultValue = defaultValue;
    _tf.text = [NSString stringWithFormat:@"%zd", _defaultValue];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_tf resignFirstResponder];
    self.defaultValue = [self.tf.text integerValue];
    if (self.tf.text == nil) {
        self.tf.text = @"1";
    }
    _NumChange(self.defaultValue);
}

- (void)changeNum:(UIButton *)button
{
    [_tf resignFirstResponder];
    NSInteger value = [self.tf.text integerValue];
    self.defaultValue = value;
    if (button.tag == 10) {
        //增加
//        value = MIN(_maxValue, value + 1);
        value++;
    }else {
//        value = MAX(_minValue, value - 1);
        value--;
    }
    
    if (value <= 0) {
        value = 0;
    }
    _tf.text = [NSString stringWithFormat:@"%zd", value];
    _defaultValue = [_tf.text integerValue];
    if (_block && value > 0) {
        _block(value, button.tag == 10 ? YES : NO);
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
