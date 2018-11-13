//
//  JJTransferViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJTransferViewController.h"
#import "JYSendCodeButton.h"

@interface JJTransferViewController ()

@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UITextField *mobileTf;
@property (nonatomic,strong)UITextField *countTf;
@property (nonatomic,strong)UILabel *poundageLabel;
@property (nonatomic,strong)UILabel *totalpoundageLabel;
@property (nonatomic, strong) YSCellView    *SMSValidateCell;

@property (nonatomic, strong) UIView        *lastView;
@property (nonatomic, strong) UIButton *   submitBtn;
@property (nonatomic,strong)YSCellView *busPwd;


@end

@implementation JJTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setUI];
    [self isSetPayPwd];
}

- (void)isSetPayPwd{
    
    [JJMineService JJMobileMemberJudgePasswordJDGCompletion:^(id result, id error) {
        if (error) {
            SDError *err = error;
            [MBProgressHUD showErrorMessage:err.errorMessage toContainer:[UIApplication sharedApplication].keyWindow];
        }
    }];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = [NSString stringWithFormat:@"%@站内互转",self.coinName];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUI{
    
    
    UIView *head = [UIView new];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.containerView addSubview:head];
    
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        //        make.height.mas_equalTo(100);
        //        make.bottom.equalTo(self.containerView).offset(10);
    }];
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"可转账数量";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = HEX_COLOR(@"#989B9E");
    [head addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head).offset(20);
        make.left.right.equalTo(head);
        make.height.mas_equalTo(16);
    }];
    
    [head addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(head);
        make.height.mas_offset(40);
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.bottom.equalTo(head).offset(-20);
    }];
    
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"对方账户";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom).offset(10);
        make.left.equalTo(head).offset(10);
        make.height.mas_equalTo(16);
    }];
    
    
    
    [self.containerView addSubview:self.mobileTf];
    [self.mobileTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2);
        make.top.equalTo(label2.mas_bottom).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_offset(40);
        
    }];
    
    
    
    
    
    UILabel *label3 = [UILabel new];
    label3.text = @"实际到账";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileTf.mas_bottom).offset(10);
        make.left.right.equalTo(label2);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UIView *countBgView = [[UIView alloc]init];
    countBgView.layer.borderWidth = 1.0f;
    countBgView.layer.borderColor = HEX_COLOR(@"#989B9E").CGColor;
    [self.containerView addSubview:countBgView];
    [countBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mobileTf);
        make.top.equalTo(label3.mas_bottom).offset(10);
        make.height.mas_offset(40);
    }];
    
    
    
    UILabel *label5 = [UILabel new];
    label5.text = @"全部转账";
    label5.textAlignment = NSTextAlignmentRight;
    label5.font = [UIFont systemFontOfSize:16];
    label5.textColor = GoldColor;
    [countBgView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countBgView);
        make.right.equalTo(countBgView).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_offset(75);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allInClick:)];
    label5.userInteractionEnabled = YES;
    [label5 addGestureRecognizer:tap];
    
    
    UILabel *label4 = [UILabel new];
    label4.text = self.coinName;
    //    label4.backgroundColor = [UIColor redColor];
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = [UIFont systemFontOfSize:14];
    label4.textColor = HEX_COLOR(@"#ADADAE");
    [countBgView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countBgView);
        make.right.equalTo(label5.mas_left).offset(-5);
        make.height.mas_equalTo(16);
        make.width.mas_offset(50);
    }];
    
    [countBgView addSubview:self.countTf];
    [self.countTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countBgView).offset(20);
        make.top.bottom.equalTo(countBgView);
        make.right.equalTo(label4.mas_left).offset(-10);
    }];
    
    
    UILabel *label6 = [UILabel new];
    label6.text = @"手续费";
    label6.textAlignment = NSTextAlignmentLeft;
    label6.font = [UIFont systemFontOfSize:14];
    label6.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countBgView.mas_bottom).offset(10);
        make.left.equalTo(label2);
        make.height.mas_equalTo(16);
        
    }];
    
    
    [self.containerView addSubview:self.poundageLabel];
    
    [self.poundageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label6.mas_right).offset(5);
        make.top.equalTo(label6);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *label7 = [UILabel new];
    label7.text = @"实际扣费";
    label7.textAlignment = NSTextAlignmentLeft;
    label7.font = [UIFont systemFontOfSize:14];
    label7.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countBgView.mas_bottom).offset(10);
        make.centerX.equalTo(self.containerView);
        make.height.mas_equalTo(16);
        
    }];
    
    [self.containerView addSubview:self.totalpoundageLabel];
    [self.totalpoundageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label7.mas_right).offset(5);
        make.top.equalTo(label7);
        make.height.mas_equalTo(16);
    }];
    
    
    UILabel *label8 = [UILabel new];
    label8.text = @"安全验证";
    label8.textAlignment = NSTextAlignmentLeft;
    label8.font = [UIFont systemFontOfSize:14];
    label8.textColor = HEX_COLOR(@"#333333");
    [self.containerView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label6.mas_bottom).offset(10);
        make.left.equalTo(label6);
        make.height.mas_equalTo(16);
        
        
    }];
    
    
    
    
    _SMSValidateCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:_SMSValidateCell];
    _SMSValidateCell.backgroundColor = [UIColor whiteColor];
    _SMSValidateCell.layer.borderWidth = 1.0f;
    _SMSValidateCell.layer.borderColor = HEX_COLOR(@"#989B9E").CGColor;
    _SMSValidateCell.ys_contentTextAlignment = NSTextAlignmentLeft;
    _SMSValidateCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _SMSValidateCell.ys_titleColor = HEX_COLOR(@"#333333");
    _SMSValidateCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _SMSValidateCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _SMSValidateCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _SMSValidateCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    //    cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    //    cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    _SMSValidateCell.ys_contentPlaceHolder = @"请输入手机验证码";
    
    [_SMSValidateCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label8.mas_bottom).mas_offset(10);
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_equalTo(40);
        
    }];
    
    
    
    
    JYSendCodeButton *sendCodeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
    sendCodeBtn.backgroundColor = GoldColor;
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    _SMSValidateCell.ys_accessoryView = sendCodeBtn;
    _SMSValidateCell.ys_accessoryRightInsets =0;
    
    
    [self.containerView addSubview:self.busPwd];
    [self.busPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_SMSValidateCell.mas_bottom).offset(20);
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_offset(40);
    }];
    
    
    [self.containerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.busPwd.mas_bottom).offset(20);
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_offset(40);
        
        
        make.bottom.equalTo(self.containerView);
    }];
    
    
    
    
    
    NSString *string2 = [NSString stringWithFormat:@"%@ %@",self.model.ReleaseAssets,self.coinName];
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:string2];
    [string3 addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"#989B9E") range:NSMakeRange(self.model.ReleaseAssets.length+1,self.coinName.length)];
    [string3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(self.model.ReleaseAssets.length+1,self.coinName.length)];
    self.countLabel.attributedText = string3;
    
    self.poundageLabel.text = [NSString stringWithFormat:@"0%@",self.model.code];
    self.totalpoundageLabel.text = [NSString stringWithFormat:@"0%@",self.model.code];
    
}


- (void)allInClick:(UITapGestureRecognizer *)tap{
    
    
    self.countTf.text = self.model.ReleaseAssets;
    
    
}

- (void)sendCodeAction:(JYSendCodeButton *)btn{
    
    
    [JJLoginService requestMobileCodeSend:[JYAccountModel sharedAccount].mobile type:@"2" category:@"1" Completion:^(id result, id error) {
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:@"60s" forState:UIControlStateNormal];
        btn.seconds = 60;
        [btn setUpTimer];
        
    }];
    
    
}


- (void)submit:(UIButton *)btn{
    
    
    if (self.mobileTf.text.length == 0) {
        [MBProgressHUD showText:@"请输入转账账号" toContainer:self.view];
        return;
    }
    
    if (self.countTf.text.length == 0) {
        [MBProgressHUD showText:@"请输入转账数量" toContainer:self.view];
        return;
    }

    if (_SMSValidateCell.ys_text.length == 0) {
        [MBProgressHUD showText:@"请输入验证码" toContainer:self.view];
        return;
    }
    if (_busPwd.ys_text.length == 0) {
        [MBProgressHUD showText:@"请输入支付密码" toContainer:self.view];
        return;
    }

    
    
    [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
    [JJWalletService requestMobileMemberOrderTransferAccounts:self.mobileTf.text money:self.countTf.text msgCode:_SMSValidateCell.ys_text password:_busPwd.ys_text  Completion:^(id result, id error) {
        
        [MBProgressHUD showText:@"转账成功" toContainer:[UIApplication sharedApplication].keyWindow];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}



-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:20];
        _countLabel.textColor = GoldColor;
    }
    return _countLabel;
}


-(UILabel *)poundageLabel
{
    if (!_poundageLabel) {
        _poundageLabel = [UILabel new];
        _poundageLabel.textAlignment = NSTextAlignmentCenter;
        _poundageLabel.font = [UIFont systemFontOfSize:14];
        _poundageLabel.textColor = GoldColor;
    }
    return _poundageLabel;
}

-(UILabel *)totalpoundageLabel
{
    if (!_totalpoundageLabel) {
        _totalpoundageLabel = [UILabel new];
        _totalpoundageLabel.textAlignment = NSTextAlignmentCenter;
        _totalpoundageLabel.font = [UIFont systemFontOfSize:14];
        _totalpoundageLabel.textColor = GoldColor;
    }
    return _totalpoundageLabel;
}



- (UITextField *)mobileTf
{
    if (!_mobileTf) {
        _mobileTf = [[UITextField alloc]init];
        _mobileTf.layer.borderColor = HEX_COLOR(@"#989B9E").CGColor;
        _mobileTf.layer.borderWidth = 1.0f;
        _mobileTf.placeholder = @"请输入对方手机号";
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        leftview.userInteractionEnabled = NO;
        _mobileTf.leftViewMode = UITextFieldViewModeAlways;
        _mobileTf.leftView = leftview;
        
    }
    return _mobileTf;
}

- (UITextField *)countTf
{
    if (!_countTf) {
        _countTf = [[UITextField alloc]init];
        _countTf.placeholder = @"请输入转账金额";
    }
    return _countTf;
}



- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitle:@"立即转账" forState:UIControlStateNormal];
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
        _busPwd.ys_bottomLineHidden = YES;
        _busPwd.layer.borderWidth = 1.0f;
        _busPwd.layer.borderColor = HEX_COLOR(@"#989B9E").CGColor;
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
