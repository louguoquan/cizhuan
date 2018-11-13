//
//  JJCooperationViewController.m
//  PXH
//
//  Created by louguoquan on 2018/10/10.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCooperationViewController.h"

@interface JJCooperationViewController ()

@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)YSCellView *nameCell;
@property (nonatomic,strong)YSCellView *phoneCell;
@property (nonatomic,strong)YSCellView *emallCell;
@property (nonatomic,strong)UIButton *submitBtn;

@end

@implementation JJCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.textView];
    [self.containerView addSubview:self.nameCell];
    [self.containerView addSubview:self.phoneCell];
    [self.containerView addSubview:self.emallCell];
    [self.containerView addSubview:self.submitBtn];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(15);
        make.top.equalTo(self.containerView).offset(20);
        make.height.mas_offset(20);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageLabel.mas_right).offset(10);
        make.top.equalTo(self.messageLabel);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(150);
    }];
    
    
    
    [self.nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.top.equalTo(self.textView.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(50);
    }];
    
    
    [self.phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.top.equalTo(self.nameCell.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(50);
    }];
    
    [self.emallCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.top.equalTo(self.phoneCell.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(50);
    
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(20);
        make.right.equalTo(self.containerView).offset(-20);
        make.top.equalTo(self.emallCell.mas_bottom).offset(30);
        make.height.mas_offset(45);
        make.bottom.equalTo(self.containerView);
    }];
    
    
    [self setUpNavUI];
    
}

- (void)setUpNavUI
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"合作入驻";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)submit:(UIButton *)btn{
    
    
    if (self.textView.text.length == 0) {
        return [MBProgressHUD showText:@"请输入项目内容" toContainer:self.view];
    }else if (self.nameCell.ys_text.length == 0){
        return [MBProgressHUD showText:@"请输入联系人姓名" toContainer:self.view];
    }else if (self.phoneCell.ys_text.length == 0){
        return [MBProgressHUD showText:@"请输入联系号码" toContainer:self.view];
    }else if (self.emallCell.ys_text.length == 0){
        return [MBProgressHUD showText:@"请输入邮箱号" toContainer:self.view];
    }
    
    
    [MBProgressHUD showLoadingToContainer:self.view];
    
    [JJFoundService JJMobileCmsCooperation:self.textView.text name:self.nameCell.ys_text email:self.emallCell.ys_text mobile:self.phoneCell.ys_text Completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:self.view];
        if (!error) {
            [MBProgressHUD showText:@"提交成功" toContainer:[UIApplication sharedApplication].keyWindow];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
    
    
    
}

- (YSCellView *)nameCell
{
    if (!_nameCell) {
        _nameCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _nameCell.backgroundColor = [UIColor whiteColor];
        _nameCell.ys_bottomLineHidden = NO;
        _nameCell.ys_separatorColor = HEX_COLOR(@"#ededed");
        _nameCell.ys_titleFont = [UIFont systemFontOfSize:14];
        _nameCell.ys_titleColor = HEX_COLOR(@"#333333");
        _nameCell.ys_contentFont = [UIFont systemFontOfSize:14];
        _nameCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _nameCell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _nameCell.ys_contentPlaceHolder = @"请输入联系人姓名";
        _nameCell.ys_title = @"联系人";
        _nameCell.ys_titleWidth = 15*4;
//        _nameCell.ys_textFiled.secureTextEntry = YES;
    }
    return _nameCell;
}

- (YSCellView *)phoneCell
{
    if (!_phoneCell) {
        _phoneCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _phoneCell.backgroundColor = [UIColor whiteColor];
        _phoneCell.ys_bottomLineHidden = NO;
        _phoneCell.ys_separatorColor = HEX_COLOR(@"#ededed");
        _phoneCell.ys_titleFont = [UIFont systemFontOfSize:14];
        _phoneCell.ys_titleColor = HEX_COLOR(@"#333333");
        _phoneCell.ys_contentFont = [UIFont systemFontOfSize:14];
        _phoneCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _phoneCell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _phoneCell.ys_contentPlaceHolder = @"请输入联系号码";
        _phoneCell.ys_title = @"联系电话";
        _phoneCell.ys_titleWidth = 15*4;
//        _phoneCell.ys_textFiled.secureTextEntry = YES;
    }
    return _phoneCell;
}

- (YSCellView *)emallCell
{
    if (!_emallCell) {
        _emallCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
        _emallCell.backgroundColor = [UIColor whiteColor];
        _emallCell.ys_bottomLineHidden = NO;
        _emallCell.ys_separatorColor = HEX_COLOR(@"#ededed");
        _emallCell.ys_titleFont = [UIFont systemFontOfSize:14];
        _emallCell.ys_titleColor = HEX_COLOR(@"#333333");
        _emallCell.ys_contentFont = [UIFont systemFontOfSize:14];
        _emallCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emallCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        _emallCell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _emallCell.ys_contentPlaceHolder = @"请输入邮箱地址";
        _emallCell.ys_title = @"邮  箱";
        _emallCell.ys_titleWidth = 15*4;
//        _emallCell.ys_textFiled.secureTextEntry = YES;
    }
    return _emallCell;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textColor = HEX_COLOR(@"#333333");
        _messageLabel.text = @"项目详情";
    }
    return _messageLabel;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.layer.borderColor = HEX_COLOR(@"#666666").CGColor;
        _textView.layer.borderWidth = 0.5f;
    }
    return _textView;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:0];
        [_submitBtn setBackgroundColor:GoldColor];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
