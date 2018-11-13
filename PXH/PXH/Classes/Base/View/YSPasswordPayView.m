//
//  YSPasswordPayView.m
//  PXH
//
//  Created by yu on 2017/8/22.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPasswordPayView.h"
#import "YSPswView.h"

@interface YSPasswordPayView ()

@property (nonatomic, strong) YSPswView     *pswView;

@property (nonatomic, copy)   YSCompleteHandler block;

@end

@implementation YSPasswordPayView

- (instancetype)initWithCompletion:(YSCompleteHandler)completion {
    self = [super init];
    if (self) {
        _block = completion;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
 
    self.type = MMPopupTypeSheet;
    self.backgroundColor = [UIColor whiteColor];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"pay_cancel"] forState:UIControlStateNormal];
    [closeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self hide];
    }];
    [self addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.width.mas_equalTo(44);
    }];
    
    UILabel *amountLabel = [UILabel new];
    amountLabel.font = [UIFont systemFontOfSize:15];
    amountLabel.textColor = HEX_COLOR(@"#333333");
    amountLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账户余额 "];
    [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", [YSAccount sharedAccount].amount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MAIN_COLOR}]];
    amountLabel.attributedText = string;
    [self addSubview:amountLabel];
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerY.equalTo(closeButton);
        make.centerX.equalTo(self);
    }];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textColor = HEX_COLOR(@"#333333");
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"请输入支付密码";
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeButton.mas_bottom);
        make.centerX.equalTo(self);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    WS(weakSelf);
    _pswView = [YSPswView new];
    _pswView.block = ^(id result, id error) {
        if (weakSelf.block) {
            weakSelf.block(result, error);
        }
        [weakSelf hide];
    };
    [self addSubview:_pswView];
    [_pswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.centerX.equalTo(self);
        make.bottom.offset(-300);
    }];
    
    [_pswView beginInput];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
