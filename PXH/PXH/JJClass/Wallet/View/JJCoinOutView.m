//
//  JJCoinOutView.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCoinOutView.h"

@interface JJCoinOutView ()

@property (nonatomic,strong)UIButton *submitBtn;

@end


@implementation JJCoinOutView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"转账数量";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEX_COLOR(@"#333333");
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15);
        make.height.mas_offset(15);
    }];
    
    _countCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self addSubview:_countCell];
    _countCell.backgroundColor = [UIColor whiteColor];
    _countCell.ys_contentTextAlignment = NSTextAlignmentLeft;
    _countCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _countCell.ys_titleColor = HEX_COLOR(@"#333333");
    _countCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _countCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _countCell.ys_bottomLineHidden = NO;
    _countCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _countCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    //    cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    //    cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    _countCell.ys_contentPlaceHolder = @"请输入转账数量";
    _countCell.ys_textFiled.keyboardType = UIKeyboardTypeDecimalPad;
    
    [_countCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).mas_offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(40);
     
    }];
    
    [self addSubview: self.padingLabel];
    [self.padingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_countCell);
        make.top.equalTo(_countCell.mas_bottom).offset(5);
        make.height.mas_offset(15);
    }];
    
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"转账地址";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = HEX_COLOR(@"#333333");
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_countCell);
        make.top.equalTo(self.padingLabel.mas_bottom).offset(30);
        make.height.mas_offset(15);
    }];
    
    
    
    _addressCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self addSubview:_addressCell];
    _addressCell.backgroundColor = [UIColor whiteColor];
    _addressCell.ys_contentTextAlignment = NSTextAlignmentLeft;
    _addressCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _addressCell.ys_titleColor = HEX_COLOR(@"#333333");
    _addressCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _addressCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _addressCell.ys_bottomLineHidden = NO;
    _addressCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    //    cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    //    cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    _addressCell.ys_contentPlaceHolder = @"请输入转账地址";
    
    [_addressCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).mas_offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(40);
        
    }];
    
    [self addSubview:self.busPwd];
    [self.busPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressCell.mas_bottom).offset(10);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.equalTo(_addressCell);
    }];
    
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(40);
        make.top.equalTo(self.busPwd.mas_bottom).offset(20);
        make.bottom.equalTo(self).offset(-30);
    }];
    
}

- (void)submit:(UIButton *)btn{
    
    
    
    if (self.countCell.ys_text.length == 0) {
        return [MBProgressHUD showText:@"请输入转账数量" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
    if (self.addressCell.ys_text.length == 0) {
       return [MBProgressHUD showText:@"请输入转账地址" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
    if (self.busPwd.ys_text.length == 0) {
       return [MBProgressHUD showText:@"请输入交易密码" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
    if (self.jjTransformClick) {
        self.jjTransformClick();
    }
    
}


- (UILabel *)padingLabel
{
    if (!_padingLabel) {
        _padingLabel = [[UILabel alloc]init];
        _padingLabel.textColor = HEX_COLOR(@"#999999");
        _padingLabel.text = @"手续费:￥0.00";
        _padingLabel.font = [UIFont systemFontOfSize:13];
    }
    return _padingLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitle:@"确认转账" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        
    }
    return _submitBtn;
}

- (YSCellView *)busPwd
{
    if (!_busPwd) {
        _busPwd = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _busPwd.backgroundColor = [UIColor whiteColor];
        _busPwd.ys_bottomLineHidden = NO;
        _busPwd.ys_separatorColor = HEX_COLOR(@"#ededed");
        _busPwd.ys_titleFont = [UIFont systemFontOfSize:14];
        _busPwd.ys_titleColor = HEX_COLOR(@"#333333");
        _busPwd.ys_contentFont = [UIFont systemFontOfSize:14];
        _busPwd.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _busPwd.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _busPwd.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _busPwd.ys_contentPlaceHolder = @"请输入交易密码";
        _busPwd.ys_title = @"交易密码";
        _busPwd.ys_titleWidth = 15*4;
        _busPwd.ys_textFiled.secureTextEntry = YES;
    }
    return _busPwd;
}


@end
