//
//  JYPasswordController.m
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPasswordController.h"

#import "JYSendCodeButton.h"

#import "JYMineService.h"
#import "JYLoginService.h"

@interface JYPasswordController ()

@property (nonatomic, strong) YSCellView    *loginPwsCell;
@property (nonatomic, strong) YSCellView    *AffirmPwsCell;
@property (nonatomic, strong) YSCellView    *figureValidateCell;
@property (nonatomic, strong) YSCellView    *SMSValidateCell;

@property (nonatomic, strong) UIView        *lastView;

@end

@implementation JYPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
    
    [self requestFigureValidateCode];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    if (self.pushType == PushType_LoginPsw) {
        navigationLabel.text = @"修改登录密码";
    }
    else {
        BOOL isPayPassword = [JYAccountModel sharedAccount].isPayPassword.boolValue;
        navigationLabel.text = isPayPassword?@"修改资金密码":@"设置资金密码";
    }
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    //登录密码与资金密码差异
    NSString *loginPwsStr = !self.pushType?@"新密码":@"资金密码";
    NSString *loginPwsHolderStr = !self.pushType?@"6-20位由字母与数字构成":@"请输入资金密码（6位纯数字）";
    NSString *loginPwsBtnTitleStr = !self.pushType?@"确认修改":@"确认设置";

    _loginPwsCell = [self creatCellLeftTitle:loginPwsStr PlaceHolder:loginPwsHolderStr rightView:nil isLineHidden:YES];
    _loginPwsCell.ys_textFiled.secureTextEntry = YES;
    
    _AffirmPwsCell = [self creatCellLeftTitle:@"确认密码" PlaceHolder:@"请再输入一次密码" rightView:nil isLineHidden:YES];
    _AffirmPwsCell.ys_textFiled.secureTextEntry = YES;
    
    _figureValidateCell = [self creatCellLeftTitle:@"图形验证" PlaceHolder:@"请输入图形验证码" rightView:[UIImage new] isLineHidden:YES];
    
    _SMSValidateCell = [self creatCellLeftTitle:@"短信验证" PlaceHolder:@"请输入手机验证码" rightView:@"111" isLineHidden:YES];
    
    [self creatSetUpPwsBtn:loginPwsBtnTitleStr];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20.f);
    }];
}


- (YSCellView *)creatCellLeftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder rightView:(id)obj isLineHidden:(BOOL)isHidden
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = isHidden;
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    if (leftTitle) {
        cell.ys_title = leftTitle;
        cell.ys_titleWidth = 15*4;
    }
    
    if (obj && [obj isKindOfClass:UIImage.class]) {
        
        UIImageView *imagView = [[UIImageView alloc] init];
        imagView.backgroundColor = [UIColor redColor];
        imagView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestFigureValidateCode)];
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
            make.top.equalTo(_lastView.mas_bottom).mas_offset(10.f);
        } else {
            make.top.equalTo(self.containerView);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (void)creatSetUpPwsBtn:(NSString *)titles
{
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.layer.cornerRadius = 1.f;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [signInBtn setTitle:titles forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [signInBtn addTarget:self action:@selector(setUpPwsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(30);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = signInBtn;
}


- (void)requestFigureValidateCode
{
    NSLog(@"获取图形验证码");
    
    
    WS(weakSelf)
    [JYLoginService requestFigureCheckCodeKey:nil Completion:^(id result, id error) {
        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:result options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        UIImage *image = [UIImage imageWithData:imgData];
        
       UIImageView *imgView = (UIImageView *)weakSelf.figureValidateCell.ys_accessoryView;
        imgView.image = image;
    }];
}

- (void)sendCodeAction:(JYSendCodeButton *)sender
{
    if (!(_figureValidateCell.ys_text.length>0)) {
        [MBProgressHUD showText:@"请输入图形验证码" toContainer:nil];
        return;
    }

    NSString *mobile = [JYAccountModel sharedAccount].mobile;
    NSString *type = (mobile && mobile.length>1)?@"1":@"2";
    //发送验证码
    [sender sendCodeMobile:[JYAccountModel sharedAccount].mobile yzm:_figureValidateCell.ys_text type:type];
}

- (void)setUpPwsAction:(UIButton *)sender
{
    if (![self judgmentOfLegality]) return;
    
    if (!self.pushType) {//修改登录密码
        [MBProgressHUD showLoadingText:@"正在修改" toContainer:nil];
        [JYMineService setUpLoginPassWord:_loginPwsCell.ys_text mobile:[JYAccountModel sharedAccount].mobile checkCode:_SMSValidateCell.ys_text completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"修改成功" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            !_setUpSuccessBlock?:_setUpSuccessBlock(self.pushType);
        }];
    }
    else {//设置资金密码
        [MBProgressHUD showLoadingText:@"正在设置" toContainer:nil];
        [JYMineService setUpPayPassWord:_loginPwsCell.ys_text mobile:[JYAccountModel sharedAccount].mobile checkCode:_SMSValidateCell.ys_text completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"设置成功" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            !_setUpSuccessBlock?:_setUpSuccessBlock(self.pushType);
        }];
    }
}


//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (self.pushType==PushType_LoginPsw) {//修改登录密码
        isLegal = [self check_LetterNumGroup:_loginPwsCell.ys_textFiled.text];
        message = @"密码不合法";
    }
    else {
        isLegal = [self check_Number:_loginPwsCell.ys_textFiled.text];
        message = @"密码不合法";
    }
    
    if (isLegal) {
        isLegal = [_AffirmPwsCell.ys_textFiled.text isEqualToString:_loginPwsCell.ys_textFiled.text];
        message = @"两次输入的密码不相同";
    }
    
    if (isLegal) {
        isLegal = _figureValidateCell.ys_textFiled.text.length;
        message = @"图形验证码不能为空";
    }
    
    if (isLegal) {
        isLegal = _SMSValidateCell.ys_textFiled.text.length;
        message = @"验证码不能为空";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}


#pragma 正则匹配数字、字母或下划线
- (BOOL)check_LetterUnderlineNumber:(NSString *)string
{
    NSString *pattern = @"^[0-9a-zA-Z_]{2,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:string];
}

#pragma 正则匹配数字(6位)
- (BOOL)check_Number:(NSString *)string
{
    NSString *emailRegex = @"^\\d{6}$";
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




-(void)setPushType:(PushType)pushType
{
    _pushType = pushType;
}

@end
