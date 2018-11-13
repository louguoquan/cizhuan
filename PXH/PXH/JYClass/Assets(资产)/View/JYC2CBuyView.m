//
//  JYC2CBuyView.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYC2CBuyView.h"
#import "JYTextField.h"
#import "JYAssetsService.h"



@interface JYC2CBuyView ()

@property (nonatomic,strong)JYTextField *buyPriceTF;  //买入价格
@property (nonatomic,strong)JYTextField *countTF;     //买入数量
@property (nonatomic,strong)JYTextField *priceTF;     //买入金额


@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;


@end

@implementation JYC2CBuyView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    
    UIView *head = [[UIView alloc]init];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *labeltitle = [[UILabel alloc]init];
    labeltitle.text = @"买入USDT";
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    labeltitle.font = [UIFont systemFontOfSize:13];
    [head addSubview:labeltitle];
    [labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(head);
        make.height.mas_equalTo(12);
    }];
    
    
    [self addSubview:self.buyPriceTF];
    [self addSubview:self.countTF];
    [self addSubview:self.priceTF];
    
    [self.buyPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom).offset(10);
        make.left.equalTo(head).offset(10);
        make.right.equalTo(head).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    UILabel * RightLabel = [UILabel new];
    RightLabel.text = @"CNY";
    RightLabel.font = [UIFont systemFontOfSize:13];
    RightLabel.textAlignment = NSTextAlignmentCenter;
    RightLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [RightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(11);
    }];
    
    UILabel * LeftLabel = [UILabel new];
    LeftLabel.text = @"买入价格";
    LeftLabel.font = [UIFont systemFontOfSize:13];
    LeftLabel.textAlignment = NSTextAlignmentCenter;
    LeftLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(11);
    }];
    
    self.buyPriceTF.leftView = LeftLabel;
    self.buyPriceTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.buyPriceTF.rightView = RightLabel;
    self.buyPriceTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    [self.countTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyPriceTF.mas_bottom).offset(10);
        make.left.equalTo(head).offset(10);
        make.right.equalTo(head).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    UILabel * RightLabel1 = [UILabel new];
    RightLabel1.text = @"USDT";
    RightLabel1.font = [UIFont systemFontOfSize:13];
    RightLabel1.textAlignment = NSTextAlignmentCenter;
    RightLabel1.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [RightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(11);
    }];
    
    UILabel * LeftLabel1 = [UILabel new];
    LeftLabel1.text = @"买入数量";
    LeftLabel1.font = [UIFont systemFontOfSize:13];
    LeftLabel1.textAlignment = NSTextAlignmentCenter;
    LeftLabel1.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [LeftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(11);
    }];
    
    self.countTF.leftView = LeftLabel1;
    self.countTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.countTF.rightView = RightLabel1;
    self.countTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    [self.priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countTF.mas_bottom).offset(10);
        make.left.equalTo(head).offset(10);
        make.right.equalTo(head).offset(-10);
        make.height.mas_equalTo(35);
    }];
    
    UILabel * RightLabel2 = [UILabel new];
    RightLabel2.text = @"CNY";
    RightLabel2.font = [UIFont systemFontOfSize:13];
    RightLabel2.textAlignment = NSTextAlignmentCenter;
    RightLabel2.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [RightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(11);
    }];
    
    UILabel * LeftLabel2 = [UILabel new];
    LeftLabel2.text = @"买入金额";
    LeftLabel2.font = [UIFont systemFontOfSize:13];
    LeftLabel2.textAlignment = NSTextAlignmentCenter;
    LeftLabel2.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    [LeftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(11);
    }];
    
    self.priceTF.leftView = LeftLabel2;
    self.priceTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.priceTF.rightView = RightLabel2;
    self.priceTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    [self addSubview:self.buyBtn];
    [self.buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.priceTF);
        make.top.equalTo(self.priceTF.mas_bottom).offset(18);
        make.height.mas_equalTo(33);
    }];
    
    
    UILabel *label = [UILabel new];
    label.textColor = HEX_COLOR(@"#ef0022");
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"法币交易须知";
    [self addSubview:label];
    
    _label1 = [UILabel new];
    _label1.textColor = HEX_COLOR(@"#666666");
    _label1.numberOfLines = 0;
    [_label1 sizeToFit];
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.text = @"1、进行法币交易必须完成实名认证";
    [self addSubview:_label1];
    
    _label2 = [UILabel new];
    _label2.textColor = HEX_COLOR(@"#666666");
    _label2.numberOfLines = 0;
    [_label2 sizeToFit];
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.text = @"2、法币交易转账必须为实名认证的姓名。";
    [self addSubview:_label2];
    
    _label3 = [UILabel new];
    _label3.textColor = HEX_COLOR(@"#666666");
    _label3.numberOfLines = 0;
    [_label3 sizeToFit];
    _label3.font = [UIFont systemFontOfSize:12];
    _label3.text = @"3、30分钟内未付款，订单自动取消";
    [self addSubview:_label3];
    
    
    _label4= [UILabel new];
    _label4.textColor = HEX_COLOR(@"#666666");
    _label4.font = [UIFont systemFontOfSize:12];
    _label4.numberOfLines = 0;
    [_label4 sizeToFit];
    _label4.text = @"4、工作时间，转账并确认后，如30分钟内未收到币请联系客服";
    [self addSubview:_label4];
    
    _label5 = [UILabel new];
    _label5.textColor = HEX_COLOR(@"#666666");
    _label5.numberOfLines = 0;
    [_label5 sizeToFit];
    _label5.font = [UIFont systemFontOfSize:12];
    _label5.text = @"5、下单后冒充已付款，卖方可申诉举报，一经查实将禁封交易";
    [self addSubview:_label5];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyBtn.mas_bottom).offset(11);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label3.mas_bottom).offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label4.mas_bottom).offset(1);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.greaterThanOrEqualTo(@20);
        make.bottom.equalTo(self).offset(-21);
    }];
    
    
    [self.countTF addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingChanged];
}




- (void)editEnd:(UITextField *)tf{
    
    
    if (tf.text.doubleValue==0) {
        [MBProgressHUD showText:@"请输入数量！" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    NSDecimalNumber* n1 = [NSDecimalNumber       decimalNumberWithString:[NSString    stringWithFormat:@"%lf",self.buyPriceTF.text.doubleValue]];
    NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",self.countTF.text.doubleValue]];
    NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
    self.priceTF.text = [NSString stringWithFormat:@"%@",n3];
    
    
}


- (void)setModel:(JYUSDTModel *)model
{
    self.buyPriceTF.text = [NSString stringWithFormat:@"%.2lf",model.sudtPrice];
    self.countTF.placeholder = [NSString stringWithFormat:@"最低购买%@",model.limit];
}

- (void)buyAction:(UIButton *)btn{
    
    
    if (self.isStop) {
        
        [MBProgressHUD showText:@"暂停买入" toContainer:[UIApplication sharedApplication].keyWindow];
        
    }else{
        
        if (_countTF.text.floatValue<=0) {
            return [MBProgressHUD showText:@"请输入数量" toContainer:self.superview];
        }
        if (_countTF.text.doubleValue<=self.model.limit.doubleValue) {
            return [MBProgressHUD showText:[NSString stringWithFormat:@"请输入不低于最低购买数"] toContainer:self.superview];
        }
        
        
        [JYAssetsService fetchCreateRechargeOrder:_countTF.text completion:^(id result, id error) {
            if (result) {
                if (self.OrderCreateSuccess) {
                    self.OrderCreateSuccess();
                }
            }
        }];
        
    }
}


- (JYTextField *)buyPriceTF
{
    if (!_buyPriceTF) {
        _buyPriceTF = [JYTextField new];
        _buyPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
        _buyPriceTF.font = [UIFont systemFontOfSize:12];
        _buyPriceTF.borderStyle = UITextBorderStyleRoundedRect;
        _buyPriceTF.userInteractionEnabled = NO;
    }
    return _buyPriceTF;
}


- (JYTextField *)countTF
{
    if (!_countTF) {
        _countTF = [JYTextField new];
        _countTF.keyboardType = UIKeyboardTypeDecimalPad;
        _countTF.font = [UIFont systemFontOfSize:12];
        _countTF.placeholder = @"最低买入100个";
        _countTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _countTF;
}


- (JYTextField *)priceTF
{
    if (!_priceTF) {
        _priceTF = [JYTextField new];
        _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTF.font = [UIFont systemFontOfSize:12];
        _priceTF.borderStyle = UITextBorderStyleRoundedRect;
        _priceTF.userInteractionEnabled = NO;
        _priceTF.text = @"0.00";
    }
    return _priceTF;
}

- (UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [UIButton new];
        _buyBtn.layer.cornerRadius = 3.0f;
        _buyBtn.layer.masksToBounds = YES;
        _buyBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
        [_buyBtn setTitle:@"确认买入" forState:UIControlStateNormal];
        [_buyBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return _buyBtn;
}

@end
