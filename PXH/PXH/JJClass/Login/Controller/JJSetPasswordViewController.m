//
//  JJSetPasswordViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJSetPasswordViewController.h"
#import "JYSendCodeButton.h"
#import "JYWebController.h"

@interface JJSetPasswordViewController ()

@property (nonatomic, strong)UILabel * messageLabel;
@property (nonatomic, strong)UILabel * noteLabel;
@property (nonatomic, strong)UILabel * agreeLabel;
@property (nonatomic, strong)UIButton * agreeBtn;
@property (nonatomic, strong)UIButton * submitBtn;
@property (nonatomic, strong) UIView        *lastView;
@property (nonatomic, strong) YSCellView    *phoneCell;
@property (nonatomic, strong) YSCellView    *pwdCell;
@property (nonatomic, strong) YSCellView    *repPwdCell;
@property (nonatomic, strong) YSCellView    *codeCell;


@end

@implementation JJSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.noteLabel];
    [self.containerView addSubview:self.agreeLabel];
    [self.containerView addSubview:self.agreeBtn];
    [self.containerView addSubview:self.submitBtn];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(10);
        make.top.equalTo(self.containerView).offset(20);
        make.height.mas_offset(30);
    }];
    
    
    if ([self.type isEqualToString:@"4"]) {
        _phoneCell = [self creatCellLeftTitle:@"手机号" PlaceHolder:@"" rightView:nil isLineHidden:NO];
    }else if ([self.type isEqualToString:@"5"]){
        _phoneCell = [self creatCellLeftTitle:@"邮箱地址" PlaceHolder:@"" rightView:nil isLineHidden:NO];
    }
    
    
    _phoneCell.ys_text = self.mobileOrEmail;
    _phoneCell.ys_textFiled.userInteractionEnabled = NO;
    
    if (self.isResetPwd) {
        
        _pwdCell= [self creatCellLeftTitle:@"新密码" PlaceHolder:@"请填写新密码" rightView:nil isLineHidden:NO];
        _repPwdCell = [self creatCellLeftTitle:@"确认新密码" PlaceHolder:@"请确认新密码" rightView:nil isLineHidden:NO];
        
        [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(20);
            make.right.equalTo(self.containerView).offset(-20);
            make.height.mas_offset(15);
            make.top.equalTo(self.lastView.mas_bottom).offset(5);
        }];
        
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noteLabel.mas_bottom).offset(30);
            make.left.equalTo(self.containerView).offset(10);
            make.right.equalTo(self.containerView).offset(-10);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(self.containerView).offset(-10);
        }];
        
    }else{
        _pwdCell= [self creatCellLeftTitle:@"密码" PlaceHolder:@"请填写密码" rightView:nil isLineHidden:NO];
        _pwdCell.ys_textFiled.secureTextEntry = YES;
        _repPwdCell = [self creatCellLeftTitle:@"确认密码" PlaceHolder:@"请确认密码" rightView:nil isLineHidden:NO];
        _repPwdCell.ys_textFiled.secureTextEntry = YES;
        _codeCell = [self creatCellLeftTitle:@"邀请码" PlaceHolder:@"邀请码(选填)" rightView:nil isLineHidden:NO];
        
        
        [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(20);
            make.right.equalTo(self.containerView).offset(-20);
            make.height.mas_offset(15);
            make.top.equalTo(self.lastView.mas_bottom).offset(5);
        }];
        
        [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.noteLabel);
            make.width.height.mas_offset(20);
            make.top.equalTo(self.noteLabel.mas_bottom).offset(30);
        }];
        [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self.agreeBtn);
            make.left.equalTo(self.agreeBtn.mas_right).offset(5);
            make.right.equalTo(self.containerView).offset(-20);
        }];
        
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.agreeLabel.mas_bottom).offset(30);
            make.left.equalTo(self.containerView).offset(10);
            make.right.equalTo(self.containerView).offset(-10);
            make.height.mas_equalTo(50);
            make.bottom.equalTo(self.containerView).offset(-10);
        }];
        
        
    }
    
    [self setUpNav];
    
    
    
    
}

- (YSCellView *)creatCellLeftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder rightView:(id)obj isLineHidden:(BOOL)isHidden
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = isHidden;
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_titleFont = [UIFont systemFontOfSize:17];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:17];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    cell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    if (leftTitle) {
        cell.ys_title = leftTitle;
        
        if (self.isResetPwd) {
            cell.ys_titleWidth = 18*5;
        }else{
            cell.ys_titleWidth = 18*4;
            
        }
    }
    
    if (obj && [obj isKindOfClass:UIImage.class]) {
        
        UIImageView *imagView = [[UIImageView alloc] init];
//        imagView.backgroundColor = [UIColor redColor];
        imagView.userInteractionEnabled = YES;
        imagView.layer.cornerRadius = 3.f;
        imagView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestFigureValidateCode:)];
        [imagView addGestureRecognizer:tap];
        
        [imagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
        }];
        cell.ys_accessoryView = imagView;
        cell.ys_accessoryRightInsets = 15;
    }
    else if (obj) {
        JYSendCodeButton *sendCodeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
        sendCodeBtn.dk_backgroundColorPicker = DKColorPickerWithKey(VALIDATEBUTTONBG);
        [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(100);
        }];
        
        cell.ys_accessoryView = sendCodeBtn;
        cell.ys_accessoryRightInsets = 15;
    }
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(_lastView.mas_bottom);
        } else {
            make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
        }
        make.right.equalTo(self.containerView).offset(-10);
        make.left.equalTo(self.containerView).offset(10);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (void)submit:(UIButton *)btn{
    
    
    if (_pwdCell.ys_text.length == 0) {
        
        [MBProgressHUD showText:@"请填写密码" toContainer:self.view];
        return;
        
    }else if (_repPwdCell.ys_text.length == 0){
        
        [MBProgressHUD showText:@"请填写确认密码" toContainer:self.view];
        return;
        
    }else if (![self judgePassWordLegal:_pwdCell.ys_text]||![self judgePassWordLegal:_repPwdCell.ys_text]){
        
        [MBProgressHUD showText:@"密码格式不正确" toContainer:self.view];
        return;
        
    }
    else if (![_pwdCell.ys_text isEqualToString:_repPwdCell.ys_text])
    {
        [MBProgressHUD showText:@"两次密码不一致" toContainer:self.view];
        return;
    }
    

    
    
    
    if (self.isResetPwd) {
        //忘记密码
        
        [JJLoginService requestMobileMemberChangePassword:_pwdCell.ys_text mobile:self.mobileOrEmail Completion:^(id result, id error) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MBProgressHUD showText:@"密码重置成功" toContainer:[UIApplication sharedApplication].keyWindow];

        }];
        
        
    }else{
        
        
//        if (_codeCell.ys_text.length == 0) {
//            [MBProgressHUD showText:@"请输入邀请码" toContainer:self.view];
//            return;
//        }
        
        if (!self.agreeBtn.selected) {
            [MBProgressHUD showText:@"请勾选同意协议" toContainer:self.view];
            return;
        }

        //注册
        
        [JJLoginService requestMobileMemberRegist:self.mobileOrEmail password:_pwdCell.ys_text recCode:_codeCell.ys_text userName:self.mobileOrEmail type:self.type.integerValue == 4?@"1":@"2" Completion:^(id result, id error) {
                        
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MBProgressHUD showText:@"注册成功" toContainer:[UIApplication sharedApplication].keyWindow];
            
            
        }];
        
        
    }

    
}

- (void)agree:(UIButton *)btn{
    
    btn.selected = !btn.selected;

}

- (void)lookUpDeal
{
    NSLog(@"查看协议");
    JYWebController *vc = [[JYWebController alloc] init];
    vc.urlString = @"https://www.baidu.com";
    vc.navTitle = @"注册协议";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    
    if (self.isResetPwd) {
        navigationLabel.text = @"重置密码";
    }else{
        navigationLabel.text = @"设置密码";
    }
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}


- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        
        if (self.isResetPwd) {
            _messageLabel.text = @"请重置MACH密码";
        }else{
            _messageLabel.text = @"请设置MACH密码";
        }
        
        _messageLabel.font = [UIFont systemFontOfSize:20];
        _messageLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _messageLabel;
}

- (UILabel *)noteLabel
{
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.text = @"密码必须是8-16位数字、字符组合(不能纯数字)";
        _noteLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _noteLabel;
}



-(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;

}


- (UILabel *)agreeLabel
{
    if (!_agreeLabel) {
        _agreeLabel = [[UILabel alloc]init];
        
        _agreeLabel.textColor = HEX_COLOR(@"#333333");
        _agreeLabel.font = [UIFont systemFontOfSize:13.f];
        _agreeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookUpDeal)];
        [_agreeLabel addGestureRecognizer:tap];
        _agreeLabel.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
        //不同颜色,行间距
        NSString *texts = @"我同意《用户协议及隐私政策》";
        NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:texts];
        [muArrStr addAttributes:@{
                                  NSForegroundColorAttributeName:GoldColor,
                                  NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                  } range:NSMakeRange(texts.length-11, 11)];
        _agreeLabel.attributedText = muArrStr;
        
    }
    return _agreeLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 2.f;
        
        if (self.isResetPwd) {
            [_submitBtn setTitle:@"重置" forState:UIControlStateNormal];
        }else{
            [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
            
        }
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.backgroundColor = GoldColor;
    }
    return _submitBtn;
}

- (UIButton *)agreeBtn
{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.layer.masksToBounds = YES;
        _agreeBtn.layer.cornerRadius = 2.f;
        //        [_agreeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"home_button_bg"] forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"select_gold"] forState:UIControlStateSelected];
        _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
        _agreeBtn.backgroundColor = GoldColor;
    }
    return _agreeBtn;
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
