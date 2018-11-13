//
//  YSNavTitleView.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSNavTitleView.h"
    /*type : 1 首页;  2 搜索 */
@interface YSNavTitleView()<UITextFieldDelegate>

@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong)UITextField *tf;
@end

@implementation YSNavTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = 1;
        self.userInteractionEnabled = YES;
        [self addSubview:self.apartmentButton];
        
        [self.apartmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.centerY.equalTo(self);
            make.height.equalTo(self);
            make.width.mas_equalTo(80);
        }];
        
        [self addSubview:self.messageButton];
        [_messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.offset(0);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(35);
        }];
        
        [self.messageButton addSubview:self.numlabel];
        [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.offset(7);
            make.right.offset(-5);
            make.width.height.mas_equalTo(14);
        }];
        self.numlabel.hidden = YES;
        [self searchView];

    }
    return self;
}

#pragma mark - 搜索初始化
- (id)initWithFrame:(CGRect)frame type:(NSInteger)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.userInteractionEnabled = YES;
        [self searchView];
        
    }
    return self;
}


- (void)setNum:(NSString *)num
{
    if ([num intValue] != 0) {
        self.numlabel.hidden = NO;
        self.numlabel.text = num;
    } else {
        self.numlabel.hidden = YES;
    }
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(kScreenWidth, 44);
}

- (void)searchView
{
    self.tf = [UITextField new];
    _tf.backgroundColor = HEX_COLOR(@"#f0f0f0");
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.size = CGSizeMake(30, 30);
    _tf.leftView = imageView;
    _tf.leftViewMode = UITextFieldViewModeAlways;
    _tf.delegate = self;
    _tf.returnKeyType = UIReturnKeySearch;
    _tf.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"惠" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:MAIN_COLOR}];
    [self addSubview:_tf];
    if (self.type == 1) {
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_apartmentButton.mas_right).offset(10);
            make.right.equalTo(_messageButton.mas_left).offset(-10);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
        }];
    } else if (self.type == 2) {
        [_tf becomeFirstResponder];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
            make.left.offset(0);
            make.right.offset(-44);
        }];
    } else {
        _tf.userInteractionEnabled = NO;
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
            make.left.offset(20);
            make.right.offset(-20);
        }];
    }
    
}

- (YSButton *)apartmentButton
{
    if (!_apartmentButton) {
        _apartmentButton = [YSButton buttonWithImagePosition:YSButtonImagePositionRight];
        _apartmentButton.space = 3;
        [_apartmentButton setImage:[UIImage imageNamed:@"pull-down"] forState:UIControlStateNormal];
        _apartmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_apartmentButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [_apartmentButton addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];
    }
    return _apartmentButton;
}

- (UIButton *)messageButton
{
    if (!_messageButton) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];

        [_messageButton setImage:[UIImage imageNamed:@"index_news"] forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(checkMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}

- (UILabel *)numlabel
{
    if (!_numlabel) {
        _numlabel = [UILabel new];
        _numlabel.backgroundColor = [UIColor redColor];
        _numlabel.layer.masksToBounds = YES;
        _numlabel.layer.cornerRadius = 7;
        _numlabel.textColor = [UIColor whiteColor];
        _numlabel.font = [UIFont systemFontOfSize:8];
        _numlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numlabel;
}

#pragma mark - 选择城市
- (void)changeCity
{
    self.changeCityBlock();
}

- (void)checkMessage
{
    self.messageBlock();
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.type == 1) {
        self.searchProductBlock();
        return NO;
    } else {
        return YES;
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.type == 2) {
        self.searchAllProductBlock(_tf.text);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    self.searchAllProductBlock(textField.text);
    
    return YES;
}

@end
