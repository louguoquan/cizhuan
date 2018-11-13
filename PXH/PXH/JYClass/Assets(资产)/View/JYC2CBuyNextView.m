//
//  JYC2CBuyNextView.m
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYC2CBuyNextView.h"



@interface JYC2CBuyNextView ()

@property (nonatomic,strong)UIView   *bankView;
@property (nonatomic,strong)UILabel  *accountLabel;
@property (nonatomic,strong)UILabel  *bankNameLabel;
@property (nonatomic,strong)UILabel  *bankNumberLabel;
@property (nonatomic,strong)UILabel  *bankTypeLabel;
@property (nonatomic,strong)UILabel  *bankNoteLabel;

@property (nonatomic,strong)UILabel  *copyNameLabel;
@property (nonatomic,strong)UILabel  *copybankNumberLabel;
@property (nonatomic,strong)UILabel  *copyNoteLabel;


@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;





@end

@implementation JYC2CBuyNextView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
//    self.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    
    
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.text = @"请汇款至以下账户";
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    headLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:headLabel];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(4);
        make.height.mas_equalTo(12);
    }];
    
    
    [self addSubview:self.bankView];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(headLabel.mas_bottom).offset(14);
        make.height.mas_offset(175);
    }];
    
    
    UIView *head = [[UIView alloc]init];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.bankView addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(headLabel.mas_bottom).offset(14);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *labeltitle = [[UILabel alloc]init];
    labeltitle.text = @"C2C充币";
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    labeltitle.font = [UIFont systemFontOfSize:13];
    [head addSubview:labeltitle];
    [labeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(head);
        make.height.mas_equalTo(12);
    }];
    
    
    
    [self.bankView addSubview:self.accountLabel];
    [self.bankView addSubview:self.bankNameLabel];
    [self.bankView addSubview:self.bankNumberLabel];
    [self.bankView addSubview:self.bankTypeLabel];
    [self.bankView addSubview:self.bankNoteLabel];
    
    
    [self.bankView addSubview:self.copyNameLabel];
    [self.bankView addSubview:self.copybankNumberLabel];
    [self.bankView addSubview:self.copyNoteLabel];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"账户名";
    label1.font = [UIFont systemFontOfSize:12];
    label1.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.bankView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom).offset(13);
        make.left.equalTo(self.bankView).offset(20);
        make.width.mas_equalTo(65);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"收款银行";
    label2.font = [UIFont systemFontOfSize:12];
    label2.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.bankView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(13);
        make.left.equalTo(self.bankView).offset(20);
        make.width.mas_equalTo(65);
    }];
    
    UILabel *label3 = [UILabel new];
    label3.text = @"账户号";
    label3.font = [UIFont systemFontOfSize:12];
    label3.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.bankView addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(13);
        make.left.equalTo(self.bankView).offset(20);
        make.width.mas_equalTo(65);
    }];
    
    
    UILabel *label4 = [UILabel new];
    label4.text = @"开户行";
    label4.font = [UIFont systemFontOfSize:12];
    label4.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.bankView addSubview:label4];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(13);
        make.left.equalTo(self.bankView).offset(20);
        make.width.mas_equalTo(65);
    }];
    
    
    UILabel *label5 = [UILabel new];
    label5.text = @"备注参考号";
    label5.font = [UIFont systemFontOfSize:12];
    label5.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.bankView addSubview:label5];
    
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(13);
        make.left.equalTo(self.bankView).offset(20);
        make.width.mas_equalTo(65);
        make.bottom.equalTo(self.bankView).offset(-14);
    }];
    
    
    [self.copyNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bankView).offset(-17);
        make.top.equalTo(label4.mas_bottom).offset(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom).offset(13);
        make.height.mas_equalTo(14);
        make.left.equalTo(label1.mas_right).offset(13);
    }];
    
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(14);
        make.left.equalTo(label1.mas_right).offset(13);
    }];
    
    [self.bankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(14);
        make.left.equalTo(label1.mas_right).offset(13);
    }];
    
    [self.bankTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNumberLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(14);
        make.left.equalTo(label1.mas_right).offset(13);
    }];
    
    [self.bankNoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankTypeLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(14);
        make.left.equalTo(label1.mas_right).offset(13);
    }];
    
    
    [self.copyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bankView).offset(-17);
        make.top.equalTo(self.accountLabel);
        make.height.mas_equalTo(13);
    }];
    
    [self.copybankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bankView).offset(-17);
        make.top.equalTo(self.bankNumberLabel);
        make.height.mas_equalTo(13);
    }];
    
    
    
    
    [self addSubview:self.buyTableView];
    [self.buyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankView.mas_bottom).offset(12);
        make.left.right.equalTo(self);
        make.height.mas_offset(300);
    }];
    
    
    
    [self addSubview:self.noteView];
    [self.noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.left.equalTo(self);
        make.top.equalTo(self.buyTableView.mas_bottom).offset(20);
//        make.bottom.equalTo(self).offset(-10);
    }];
    
    
    UILabel *label = [UILabel new];
    label.dk_textColorPicker = DKColorPickerWithKey(AssetsNoteTEXT);
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"转账说明";
    [self.noteView addSubview:label];
    
    _label1 = [UILabel new];
    _label1.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    _label1.numberOfLines = 0;
    [_label1 sizeToFit];
    _label1.font = [UIFont systemFontOfSize:13];
    _label1.text = @"1、转账时备注请务必填写备注参考号，否则不能及时到账。";
    [self.noteView addSubview:_label1];
    
    _label2 = [UILabel new];
    _label2.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    _label2.numberOfLines = 0;
    [_label2 sizeToFit];
    _label2.font = [UIFont systemFontOfSize:13];
    _label2.text = @"2、17:00以后及非工作日时间，每笔请拆分5万内进行转账， 否则将延迟到账。";
    [self.noteView addSubview:_label2];
    
    _label3 = [UILabel new];
    _label3.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    _label3.numberOfLines = 0;
    [_label3 sizeToFit];
    _label3.font = [UIFont systemFontOfSize:13];
    _label3.text = @"3、交易时间：10：00-21:00，其他时间的交易到账可能会 延迟到下个交易时间段到账，请您知悉。";
    [self.noteView addSubview:_label3];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noteView).offset(21);
        make.left.equalTo(self.noteView).offset(16);
        make.right.equalTo(self.noteView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(1);
        make.left.equalTo(self.noteView).offset(16);
        make.right.equalTo(self.noteView).offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).offset(1);
        make.left.equalTo(self.noteView).offset(16);
        make.right.equalTo(self.noteView).offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).offset(1);
        make.left.equalTo(self.noteView).offset(16);
        make.right.equalTo(self.noteView).offset(-10);
        make.height.greaterThanOrEqualTo(@20);
        make.bottom.equalTo(self.noteView).offset(-50);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyName:)];
    self.copyNameLabel.userInteractionEnabled = YES;
    [self.copyNameLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyBank:)];
    self.copybankNumberLabel.userInteractionEnabled = YES;
    [self.copybankNumberLabel addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyNote:)];
    self.copyNoteLabel.userInteractionEnabled = YES;
    [self.copyNoteLabel addGestureRecognizer:tap2];

    
    
}


- (void)copyNote:(UITapGestureRecognizer *)tap{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.copyNoteLabel.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
}

- (void)copyName:(UITapGestureRecognizer *)tap{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
    
        pBoard.string = self.accountLabel.text;
  
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
    
}

- (void)copyBank:(UITapGestureRecognizer *)tap{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.bankNumberLabel.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
}


- (void)setModel:(JYBankModel *)model
{
    self.accountLabel.text = model.payee;
    self.bankNameLabel.text = model.bank;
    self.bankNumberLabel.text = model.cardNumber;
    self.bankTypeLabel.text = model.branch;
    self.bankNoteLabel.text = model.remarks;
}

- (UIView *)bankView
{
    if (!_bankView) {
        _bankView = [UIView new];
        _bankView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        _bankView.layer.cornerRadius = 4.0f;
        _bankView.layer.masksToBounds = YES;
    }
    return _bankView;
}


- (UIView *)noteView
{
    if (!_noteView) {
        _noteView = [UIView new];
        _noteView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    }
    return _noteView;
}



- (UILabel *)accountLabel
{
    if (!_accountLabel) {
        _accountLabel = [UILabel new];
        _accountLabel.font = [UIFont systemFontOfSize:14];
        _accountLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _accountLabel;
}

- (UILabel *)bankNameLabel
{
    if (!_bankNameLabel) {
        _bankNameLabel = [UILabel new];
        _bankNameLabel.font = [UIFont systemFontOfSize:14];
        _bankNameLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _bankNameLabel;
}

- (UILabel *)bankNumberLabel
{
    if (!_bankNumberLabel) {
        _bankNumberLabel = [UILabel new];
        _bankNumberLabel.font = [UIFont systemFontOfSize:14];
        _bankNumberLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _bankNumberLabel;
}

- (UILabel *)bankTypeLabel
{
    if (!_bankTypeLabel) {
        _bankTypeLabel = [UILabel new];
        _bankTypeLabel.font = [UIFont systemFontOfSize:14];
        _bankTypeLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _bankTypeLabel;
}

- (UILabel *)bankNoteLabel
{
    if (!_bankNoteLabel) {
        _bankNoteLabel = [UILabel new];
        _bankNoteLabel.font = [UIFont systemFontOfSize:14];
        _bankNoteLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _bankNoteLabel;
}

- (UILabel *)copyNameLabel
{
    if (!_copyNameLabel) {
        _copyNameLabel = [UILabel new];
        _copyNameLabel.text = @"复制";
        _copyNameLabel.font = [UIFont systemFontOfSize:14];
        _copyNameLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _copyNameLabel;
}

- (UILabel *)copyNoteLabel
{
    if (!_copyNoteLabel) {
        _copyNoteLabel = [UILabel new];
        _copyNoteLabel.text = @"复制";
        _copyNoteLabel.font = [UIFont systemFontOfSize:14];
        _copyNoteLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _copyNoteLabel;
}

- (UILabel *)copybankNumberLabel
{
    if (!_copybankNumberLabel) {
        _copybankNumberLabel = [UILabel new];
        _copybankNumberLabel.text = @"复制";
        _copybankNumberLabel.font = [UIFont systemFontOfSize:14];
        _copybankNumberLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONTEXT);
    }
    return _copybankNumberLabel;
}


- (JYBuyTableView *)buyTableView
{
    if (!_buyTableView) {
        _buyTableView = [[JYBuyTableView alloc]init];
    }
    return _buyTableView;
}
@end
