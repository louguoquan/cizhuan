//
//  JJBDEmailViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBDEmailViewController.h"
#import "JJBDEmailNextViewController.h"

@interface JJBDEmailViewController ()

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)YSCellView *mobileCell;
@property (nonatomic,strong)UIButton *submitBtn;


@end

@implementation JJBDEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    
    [self.containerView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(20);
        make.left.equalTo(self.containerView).offset(20);
        make.height.mas_offset(20);
    }];
    
    _mobileCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:_mobileCell];
    _mobileCell.backgroundColor = [UIColor whiteColor];
    _mobileCell.ys_contentTextAlignment = NSTextAlignmentLeft;
    _mobileCell.ys_titleFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_titleColor = HEX_COLOR(@"#333333");
    _mobileCell.ys_bottomLineHidden = NO;
    _mobileCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _mobileCell.ys_contentFont = [UIFont systemFontOfSize:14];
    _mobileCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _mobileCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    if ([self.type isEqualToString:@"1"]) {
        _mobileCell.ys_contentPlaceHolder = @"输入手机号码";
        self.typeLabel.text = @"手机";
    }else if ([self.type isEqualToString:@"2"]){
        self.typeLabel.text = @"邮箱";
        _mobileCell.ys_contentPlaceHolder = @"输入邮箱地址";
    }
    
    
    [_mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_equalTo(40);
        
    }];
    
    [self.containerView addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileCell.mas_bottom).offset(30);
        make.centerX.equalTo(self.containerView);
        make.width.mas_offset(120);
        make.height.mas_offset(40);
        make.bottom.equalTo(self.containerView);
    }];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    if ([self.type isEqualToString:@"1"]) {
         navigationLabel.text = @"手机绑定" ;
    }else{
         navigationLabel.text = @"邮箱绑定";
    }
   
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}

- (void)submit:(UIButton *)btn{
    
    if ([self.type isEqualToString:@"1"]) {
        
        if (_mobileCell.ys_text.length == 0) {
            [MBProgressHUD showText:@"请输入手机号码" toContainer:self.view];
            return;
        }else if (![self check_Number:_mobileCell.ys_text length:8]){
            [MBProgressHUD showText:@"手机号不合法" toContainer:self.view];
            return;
        }
        
        
    }else if ([self.type isEqualToString:@"2"]){
        
        if (_mobileCell.ys_text.length == 0) {
            [MBProgressHUD showText:@"请输入邮箱地址" toContainer:self.view];
            return;
        }else if ( ![self check_Mail:_mobileCell.ys_text]){
            
            [MBProgressHUD showText:@"邮箱不合法" toContainer:nil];
            return;
        }
        
    }
    
    
    
    if ([self.type isEqualToString:@"1"]) {
        //绑定手机
        [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
        //发送手机验证码
        [JJLoginService requestMobileCodeSend:_mobileCell.ys_text type:@"3" category:@"1" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            
            JJBDEmailNextViewController *vc = [[JJBDEmailNextViewController alloc]init];
            vc.type = self.type;
            vc.mobileOrEmail = _mobileCell.ys_text;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }else if ([self.type isEqualToString:@"2"]){
        //绑定邮箱
        [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
        //发送手机验证码
        [JJLoginService requestMobileCodeSend:_mobileCell.ys_text type:@"3" category:@"2" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            
            JJBDEmailNextViewController *vc = [[JJBDEmailNextViewController alloc]init];
            vc.type = self.type;
            vc.mobileOrEmail = _mobileCell.ys_text;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    
    
  
    
}


#pragma 正则匹配数字、字母或下划线
- (BOOL)check_LetterUnderlineNumber:(NSString *)string
{
    NSString *pattern = @"^[0-9a-zA-Z_]{2,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:string];
}

#pragma 正则匹配数字(至少length位)
- (BOOL)check_Number:(NSString *)string length:(NSInteger)length
{
    NSString *emailRegex = [NSString stringWithFormat:@"^\\d{%ld,}$", (long)length];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma 正则匹配邮箱号
- (BOOL)check_Mail:(NSString *)string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma 正则匹配6-20位数字和字母组合
- (BOOL)check_LetterNumGroup:(NSString *)string
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:string];
}




- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        
    }
    return _submitBtn;
}


- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:20];
        _typeLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _typeLabel;
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
