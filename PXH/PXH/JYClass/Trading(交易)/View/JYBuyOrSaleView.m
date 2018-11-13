//
//  JYBuyOrSaleView.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBuyOrSaleView.h"

@interface JYBuyOrSaleView ()<UITextFieldDelegate>

@property (nonatomic,strong)UILabel *priceRightLabel;
@property (nonatomic,strong)UILabel *countRightLabel;
@property (nonatomic,strong)UILabel *canBuyCoinTypeLabel;


@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;
@property (nonatomic,strong)UILabel *label6;

@property (nonatomic,strong)UIButton *currentBtn;

@end


@implementation JYBuyOrSaleView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{

   
  
     CGFloat height = 14*kScreenHeight/667;
    
    
    [self addSubview:self.priceTF];
    [self addSubview:self.countTF];
    [self addSubview:self.pricelLabel];
    [self addSubview:self.canBuyLabel];
    [self addSubview:self.payAccountLabel];
    [self addSubview:self.poundageLabel];
    [self addSubview:self.canUseBTCCoin];
    [self addSubview:self.freeBTCCoin];
    [self addSubview:self.canUseETHCoin];
    [self addSubview:self.freeETHCoin];
    [self addSubview:self.buyOrSaleBtn];
    [self addSubview:self.canBuyCoinTypeLabel];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.label3];
    [self addSubview:self.label4];
    [self addSubview:self.label5];
    [self addSubview:self.label6];
    
    self.label1.text = @"交易额";
    self.label2.text = @"手续费";
    self.label3.text = @"可用";
    self.label4.text = @"冻结";
    self.label5.text = @"可用";
    self.label6.text = @"冻结";
    
    [self.priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13);
        make.left.equalTo(self).offset(8);
        make.width.mas_equalTo(kScreenWidth/2.0-16);
        make.height.mas_equalTo(33);
        
        
    }];
    
    
    [self.priceRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo();
        make.height.mas_equalTo(height);
    }];
    
    
    [self.pricelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceTF.mas_bottom).offset(12);
        make.left.equalTo(self).offset(14);
        make.height.mas_equalTo(height);
    }];
    
    
    [self.countTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pricelLabel.mas_bottom).offset(11);
        make.left.equalTo(self).offset(8);
        make.width.mas_equalTo(kScreenWidth/2.0-16);
        make.height.mas_equalTo(33);
    }];
    
    [self.countRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(30);
        make.height.mas_equalTo(height);
    }];
    
    [self.canBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countTF.mas_bottom).offset(15);
        make.left.equalTo(self).offset(14);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(kScreenWidth/2.0-60);
        
        
    }];
    
    [self.canBuyCoinTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canBuyLabel);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
    }];
    
    UIButton *lastBtn;
    for (int i = 0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGHalfBTNBG);
        btn.layer.cornerRadius = 3.0f;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGHalfBTNTEXT) forState:UIControlStateNormal];
        
        [btn setTitle:[NSString stringWithFormat:@"%d%%",25*(i+1)] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(tapHalf:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.canBuyLabel.mas_bottom).offset(15);
            if (i==0) {
                make.left.equalTo(self).offset(7);
            }else{
                make.left.equalTo(lastBtn.mas_right).offset(3);
            }
            
            if (i==3) {
                make.right.equalTo(self).offset(-7);
            }
            make.width.mas_equalTo((kScreenWidth/2.0-14-9)/4.0);
            make.height.mas_equalTo(27);
            
        }];
        lastBtn = btn;
    }
    
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payAccountLabel);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
    }];
    
    
    [self.payAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastBtn.mas_bottom).offset(18);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];
    
   
    [self.poundageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payAccountLabel.mas_bottom).offset(20);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];
    
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.poundageLabel);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
    }];

    
    [self.buyOrSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.poundageLabel.mas_bottom).offset(18);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(43);
    }];
    
    [self.canUseBTCCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyOrSaleBtn.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseBTCCoin);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
        
    }];

    
    [self.freeBTCCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseBTCCoin.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
         make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];

    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freeBTCCoin);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
    }];
    
    [self.canUseETHCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freeBTCCoin.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
         make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseETHCoin);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
    }];


    
    [self.freeETHCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseETHCoin.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-8);
        make.height.mas_equalTo(height);
         make.width.mas_equalTo(kScreenWidth/2.0-60);
    }];
    
    
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freeETHCoin);
        make.left.equalTo(self).offset(8);
        make.height.mas_equalTo(height);
        make.bottom.equalTo(self).offset(IS_IPHONE_X?0:-30);
    }];


    _priceTF.rightView = _priceRightLabel;
    _priceTF.rightViewMode = UITextFieldViewModeAlways;
    
    _countTF.rightView = _countRightLabel;
    _countTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    
    [_priceTF addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    [_countTF addTarget:self action:@selector(editEnd1:) forControlEvents:UIControlEventEditingChanged];
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(((string.intValue<0) || (string.intValue>9))){
        //MyLog(@"====%@",string);
        if ((![string isEqualToString:@"."])) {
            return NO;
        }
        return NO;
    }
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    NSInteger dotNum = 0;
    NSInteger flag=0;
    const NSInteger limited = 10;
    
    
    if((int)futureString.length>=1){
        
        if([futureString characterAtIndex:0] == '.'){//the first character can't be '.'
            return NO;
        }
        if((int)futureString.length>=2){//if the first character is '0',the next one must be '.'
            if(([futureString characterAtIndex:1] != '.'&&[futureString characterAtIndex:0] == '0')){
                return NO;
            }
        }
    }
    NSInteger dotAfter = 0;
    for (int i = (int)futureString.length-1; i>=0; i--) {
        if ([futureString characterAtIndex:i] == '.') {
            dotNum ++;
            dotAfter = flag+1;
            if (flag > limited) {
                return NO;
            }
            if(dotNum>1){
                return NO;
            }
        }
        flag++;
    }
    if(futureString.length - dotAfter > 9){
        //[MBProgressHUD toastMessage:@"超出最大金额"];
        return NO;
    }
    return YES;
}


- (void)btnUnSelect{
    
    
    
    
    
}

- (void)editEnd:(UITextField *)tf{
    
    if (self.priceChange) {
        self.priceChange(tf.text);
    }
    
    
}

- (void)editEnd1:(UITextField *)tf{
    
    
    if (self.currentBtn.selected == YES) {
        self.currentBtn.selected = !self.currentBtn.selected;
        self.currentBtn.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGHalfBTNBG);
        [self.currentBtn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGHalfBTNTEXT) forState:UIControlStateNormal];
    }
    
    if (tf.text.length>0) {
        NSDecimalNumber* n1 = [NSDecimalNumber   decimalNumberWithString:[NSString    stringWithFormat:@"%@",_priceTF.text]];
        
        NSDecimalNumber* n2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",tf.text]];
        
        NSDecimalNumber* n3 = [n1 decimalNumberByMultiplyingBy:n2];
        
        
        _payAccountLabel.text = [NSString stringWithFormat:@"%@%@",n3,[JYDefaultDataModel sharedDefaultData].coinPayName];
        
        
        NSDecimalNumber* n4 = [NSDecimalNumber   decimalNumberWithString:[NSString    stringWithFormat:@"%@",_payAccountLabel.text]];
        
        NSDecimalNumber* n5 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"0.002"]];
        
        NSDecimalNumber* n6 = [n4 decimalNumberByMultiplyingBy:n5];
        
        
        _poundageLabel.text = [NSString stringWithFormat:@"%@%@",n6,[JYDefaultDataModel sharedDefaultData].coinPayName];

    }else{
        _poundageLabel.text = @"0.2%";
        _payAccountLabel.text = [NSString stringWithFormat:@"%@%@",@"--",[JYDefaultDataModel sharedDefaultData].coinPayName];
        
    }
    if (self.countChange) {
        self.countChange(tf.text);
    }
    
}


- (void)tapHalf:(UIButton *)btn{
    
    
    
    if (!self.currentBtn) {
        btn.selected = !btn.selected;
        self.currentBtn = btn;
        self.currentBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
        [self.currentBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateSelected];

    }else{
        if (self.currentBtn != btn) {
           
            
            btn.selected = !btn.selected;
            
            self.currentBtn.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGHalfBTNBG);
            [self.currentBtn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGHalfBTNTEXT) forState:UIControlStateSelected];
            
          
            self.currentBtn.selected = !self.currentBtn.selected;
            self.currentBtn = btn;
            
            self.currentBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
            [self.currentBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateSelected];
        }
    }
    
    
    
    
    if (self.BuyOrSaleCountHalf) {
        self.BuyOrSaleCountHalf(btn.tag - 100);
    }
    
    
    
}

- (void)setType:(NSInteger)type
{
    
    
    self.priceRightLabel.text = [JYDefaultDataModel sharedDefaultData].coinPayName;
    
    
    self.countRightLabel.text = [JYDefaultDataModel sharedDefaultData].coinBaseName;
    self.canBuyCoinTypeLabel.text = self.countRightLabel.text;
    
    self.pricelLabel.text = @"≈￥0.00";
    
    self.canBuyLabel.text = @"可买0.00";
    
    
    self.payAccountLabel.text = [NSString stringWithFormat:@"--%@",[JYDefaultDataModel sharedDefaultData].coinPayName];
    self.poundageLabel.text = @"0.2%";
    
    self.canUseBTCCoin.text = [NSString stringWithFormat:@"%@%@",@"0.00",[JYDefaultDataModel sharedDefaultData].coinPayName];
    self.freeBTCCoin.text = [NSString stringWithFormat:@"%@%@",@"0.00",[JYDefaultDataModel sharedDefaultData].coinPayName];
    
    self.canUseETHCoin.text = [NSString stringWithFormat:@"%@%@",@"0.00",[JYDefaultDataModel sharedDefaultData].coinBaseName];
    self.freeETHCoin.text = [NSString stringWithFormat:@"%@%@",@"0.00",[JYDefaultDataModel sharedDefaultData].coinBaseName];
    
    [self.buyOrSaleBtn addTarget:self action:@selector(buyOrSale:) forControlEvents:UIControlEventTouchUpInside];
    
    if (type == 1) {
        
        
        self.buyOrSaleBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
        [self.buyOrSaleBtn setTitle:[JYAccountModel sharedAccount].token.length==0 ? @"登录":@"买入" forState:UIControlStateNormal];
        
        
        
    }else if(type ==2){
        
        
        self.buyOrSaleBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        [self.buyOrSaleBtn setTitle:[JYAccountModel sharedAccount].token.length==0 ? @"登录":@"卖出" forState:UIControlStateNormal];
        
    }
    
    
    
    
}


- (void)buyOrSale:(UIButton *)btn{
    
    if ([[btn currentTitle]isEqualToString:@"登录"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JYTokenExpiredReLogin object:self];
        return;
    }
    
    if (self.BuyOrSale) {
        self.BuyOrSale([[btn currentTitle]isEqualToString:@"买入"]?YES:NO);
    }
    
}




- (JYTextField *)priceTF
{
    if (!_priceTF) {
        _priceTF = [JYTextField new];
        _priceTF.placeholder = @"委托价格";
        _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTF.font = [UIFont systemFontOfSize:13];
        _priceTF.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _priceTF;
    
}

- (JYTextField *)countTF
{
    if (!_countTF) {
        _countTF = [JYTextField new];
        _countTF.placeholder = @"委托数量";
        _countTF.delegate = self;
        _countTF.keyboardType = UIKeyboardTypeDecimalPad;
        _countTF.font = [UIFont systemFontOfSize:13];
        _countTF.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _countTF;
    
}

- (UILabel *)priceRightLabel{
    if (!_priceRightLabel) {
        _priceRightLabel = [UILabel new];
        _priceRightLabel.font = [UIFont systemFontOfSize:13];
        _priceRightLabel.textAlignment = NSTextAlignmentCenter;
        _priceRightLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _priceRightLabel;
    
}

- (UILabel *)countRightLabel{
    if (!_countRightLabel) {
        _countRightLabel = [UILabel new];
        _countRightLabel.font = [UIFont systemFontOfSize:13];
        _countRightLabel.textAlignment = NSTextAlignmentCenter;
        _countRightLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _countRightLabel;
}

- (UILabel *)pricelLabel
{
    if (!_pricelLabel) {
        _pricelLabel = [UILabel new];
        _pricelLabel.font = [UIFont systemFontOfSize:13];
        _pricelLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _pricelLabel;
}

- (UILabel *)canBuyLabel
{
    if (!_canBuyLabel) {
        _canBuyLabel = [UILabel new];
        _canBuyLabel.font = [UIFont systemFontOfSize:13];
        _canBuyLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _canBuyLabel.adjustsFontSizeToFitWidth = YES;
        _canBuyLabel.minimumFontSize = 0.1;
    }
    return _canBuyLabel;
}


- (UILabel *)payAccountLabel
{
    if (!_payAccountLabel) {
        _payAccountLabel = [UILabel new];
        _payAccountLabel.font = [UIFont systemFontOfSize:13];
        _payAccountLabel.textAlignment = NSTextAlignmentRight;
        _payAccountLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _payAccountLabel.adjustsFontSizeToFitWidth = YES;
        _payAccountLabel.minimumFontSize = 0.1;
    }
    return _payAccountLabel;
}

- (UILabel *)poundageLabel
{
    if (!_poundageLabel) {
        _poundageLabel = [UILabel new];
        _poundageLabel.font = [UIFont systemFontOfSize:13];
        _poundageLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _poundageLabel.textAlignment = NSTextAlignmentRight;
        _poundageLabel.adjustsFontSizeToFitWidth = YES;
        _poundageLabel.minimumFontSize = 0.1;
    }
    return _poundageLabel;
}

- (UILabel *)canUseBTCCoin
{
    if (!_canUseBTCCoin) {
        _canUseBTCCoin = [UILabel new];
        _canUseBTCCoin.font = [UIFont systemFontOfSize:13];
        _canUseBTCCoin.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _canUseBTCCoin.textAlignment = NSTextAlignmentRight;
    }
    return _canUseBTCCoin;
}

- (UILabel *)freeBTCCoin
{
    if (!_freeBTCCoin) {
        _freeBTCCoin = [UILabel new];
        _freeBTCCoin.font = [UIFont systemFontOfSize:13];
        _freeBTCCoin.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _freeBTCCoin.textAlignment = NSTextAlignmentRight;
    }
    return _freeBTCCoin;
}

- (UILabel *)canUseETHCoin
{
    if (!_canUseETHCoin) {
        _canUseETHCoin = [UILabel new];
        _canUseETHCoin.font = [UIFont systemFontOfSize:13];
        _canUseETHCoin.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _canUseETHCoin.textAlignment = NSTextAlignmentRight;
    }
    return _canUseETHCoin;
}

- (UILabel *)freeETHCoin
{
    if (!_freeETHCoin) {
        _freeETHCoin = [UILabel new];
        _freeETHCoin.font = [UIFont systemFontOfSize:13];
        _freeETHCoin.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
        _freeETHCoin.textAlignment = NSTextAlignmentRight;
    }
    return _freeETHCoin;
}


- (UILabel *)canBuyCoinTypeLabel
{
    if (!_canBuyCoinTypeLabel) {
        _canBuyCoinTypeLabel = [UILabel new];
        _canBuyCoinTypeLabel.font = [UIFont systemFontOfSize:13];
        _canBuyCoinTypeLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _canBuyCoinTypeLabel;
}


- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.font = [UIFont systemFontOfSize:13];
        _label1.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label1;
}

- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.font = [UIFont systemFontOfSize:13];
        _label2.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label2;
}

- (UILabel *)label3
{
    if (!_label3) {
        _label3 = [UILabel new];
        _label3.font = [UIFont systemFontOfSize:13];
        _label3.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label3;
}

- (UILabel *)label4
{
    if (!_label4) {
        _label4 = [UILabel new];
        _label4.font = [UIFont systemFontOfSize:13];
        _label4.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label4;
}

- (UILabel *)label5
{
    if (!_label5) {
        _label5 = [UILabel new];
        _label5.font = [UIFont systemFontOfSize:13];
        _label5.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label5;
}

- (UILabel *)label6
{
    if (!_label6) {
        _label6 = [UILabel new];
        _label6.font = [UIFont systemFontOfSize:13];
        _label6.dk_textColorPicker = DKColorPickerWithKey(TRADINGTEXT);
    }
    return _label6;
}


- (UIButton *)buyOrSaleBtn
{
    if (!_buyOrSaleBtn) {
        _buyOrSaleBtn = [UIButton new];
        _buyOrSaleBtn.layer.cornerRadius = 3.0f;
        _buyOrSaleBtn.layer.masksToBounds = YES;
        _buyOrSaleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _buyOrSaleBtn.titleLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    }
    return _buyOrSaleBtn;
}




@end
