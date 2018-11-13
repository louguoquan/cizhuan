//
//  YSPswView.m
//  DingDou
//
//  Created by yu on 2017/5/31.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YSPswView.h"

@interface YSPswViewItem : UIView

@property (nonatomic, strong) UIView    *pointView;

- (void)setPswHidden:(BOOL)hidden;

@end

@implementation YSPswViewItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.userInteractionEnabled = NO;
    
    WS(weakSelf);
    _pointView = [UIView new];
    _pointView.backgroundColor = [UIColor blackColor];
    _pointView.layer.cornerRadius = 5;
    _pointView.clipsToBounds = YES;
    [self addSubview:_pointView];
    [_pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.height.width.mas_equalTo(10);
    }];
    _pointView.hidden = YES;
}

- (void)setPswHidden:(BOOL)hidden
{
    _pointView.hidden = hidden;
}

@end

@interface YSPswView ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray   *pswViewArray;

@property (nonatomic, strong) UITextField       *pswTF;

@end

@implementation YSPswView

- (NSString *)password
{
    return _pswTF.text;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 3;
    button.layer.borderColor = BORDER_COLOR.CGColor;
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(beginInput) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(45 * 6);
        make.edges.equalTo(weakSelf);
    }];
    
    _pswViewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i ++) {
        YSPswViewItem *view = [YSPswViewItem new];
        [button addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(button);
            make.left.offset(i * 45);
            make.width.mas_equalTo(45);
        }];
        [_pswViewArray addObject:view];
        if (i != 0) {
            UIView *lineView = [UIView new];
            lineView.backgroundColor = BORDER_COLOR;
            [view addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(view);
                make.left.equalTo(view);
                make.width.mas_equalTo(0.5);
            }];
        }
        
    }
    
    _pswTF = [UITextField new];
//    _pswTF.keyboardType = UIKeyboardTypeNumberPad;
    _pswTF.delegate = self;
    [self addSubview:_pswTF];
    [_pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.offset(0);
    }];
    _pswTF.hidden = YES;
}

- (void)beginInput
{
    [_pswTF becomeFirstResponder];
}

- (void)updatePswView:(NSString *)text
{
    for (NSInteger i = 0; i < [_pswViewArray count]; i ++) {
        YSPswViewItem *view = _pswViewArray[i];
        if (text.length > i) {
            [view setPswHidden:NO];
        }else {
            [view setPswHidden:YES];
        }
    }
    
    if (text.length == 6) {
        if (self.block) {
            self.block(text, nil);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //在textFiled中限制输入位数
    if ([string isEqualToString:@""]) {
        [self updatePswView:text];
        return YES;
    }
    
    if (text.length > 6) {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:text]) {
        [self updatePswView:text];
        return YES;
    }
    
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
