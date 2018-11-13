//
//  JYSignInController.m
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYSignInController.h"
#import "JYWebController.h"

#import "JYSendCodeButton.h"

#import "JYLoginService.h"

@interface JYSignInController ()

@property (nonatomic, strong) YSCellView    *userNameCell;
@property (nonatomic, strong) YSCellView    *phoneCell;
@property (nonatomic, strong) YSCellView    *figureValidateCell;
@property (nonatomic, strong) YSCellView    *SMSValidateCell;
@property (nonatomic, strong) YSCellView    *loginPwsCell;
@property (nonatomic, strong) YSCellView    *AffirmPwsCell;
@property (nonatomic, strong) YSCellView    *invitationCodeCell;



@property (nonatomic, strong) UIView        *lastView;

@end

@implementation JYSignInController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestFigureValidateCode:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI
{
    //邮箱和手机号注册数据差异
    NSString *signPhoneStr = !self.index.integerValue?@"手机号":@"邮箱账号";
    NSString *signPhoneHolderStr = !self.index.integerValue?@"请输入手机号":@"请输入有效的邮箱地址";
    
    NSString *signSMSValStr = !self.index.integerValue?@"短信验证":@"邮箱验证";
    NSString *signSMSValHolderStr = !self.index.integerValue?@"请输入短信验证码":@"请输入短信验证码";
    
    //注册和找回密码 数据差异
    NSString *loginPwsStr = !self.pushType.integerValue?@"登录密码":@"新密码";
    NSString *signStr = !self.pushType.integerValue?@"注册":@"重置密码";
    
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);

    if (!self.pushType.integerValue) {//注册
        _userNameCell = [self creatCellLeftTitle:@"用户名" PlaceHolder:@"请输入用户名" rightView:nil isLineHidden:NO];
    }

    _phoneCell = [self creatCellLeftTitle:signPhoneStr PlaceHolder:signPhoneHolderStr rightView:nil isLineHidden:NO];
    
    _figureValidateCell = [self creatCellLeftTitle:@"图形验证" PlaceHolder:@"请输入图形验证码" rightView:[UIImage new] isLineHidden:NO];
    
    _SMSValidateCell = [self creatCellLeftTitle:signSMSValStr PlaceHolder:signSMSValHolderStr rightView:@"111" isLineHidden:NO];
    
    _loginPwsCell = [self creatCellLeftTitle:loginPwsStr PlaceHolder:@"6-20位由字母与数字构成" rightView:nil isLineHidden:NO];
    _loginPwsCell.ys_textFiled.secureTextEntry = YES;
    
    _AffirmPwsCell = [self creatCellLeftTitle:@"确认密码" PlaceHolder:@"请再输入密码" rightView:nil isLineHidden:NO];
    _AffirmPwsCell.ys_textFiled.secureTextEntry = YES;
    
    if (!self.pushType.integerValue) {//注册
        _invitationCodeCell = [self creatCellLeftTitle:@"邀请码" PlaceHolder:@"选填" rightView:nil isLineHidden:YES];
    }
    
    [self creatSignInRetrievePwsBtn:signStr];
    
    if (!self.pushType.integerValue) {//注册
        [self creatDealLab];
    }
    
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
    cell.ys_textFiled.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    if (leftTitle) {
        cell.ys_title = leftTitle;
            cell.ys_titleWidth = 15*4;
    }
    
    if (obj && [obj isKindOfClass:UIImage.class]) {
        
        UIImageView *imagView = [[UIImageView alloc] init];
        imagView.backgroundColor = [UIColor redColor];
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
            make.top.equalTo(self.containerView);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (void)creatSignInRetrievePwsBtn:(NSString *)titles
{
    //注册/重置密码
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [signInBtn jm_setCornerRadius:1 withBackgroundColor:HEX_COLOR(@"")];
    signInBtn.layer.cornerRadius = 1.f;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [signInBtn setTitle:titles forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [signInBtn addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(30);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    _lastView = signInBtn;
}

- (void)creatDealLab
{
    //协议
    UILabel *dealLab = [[UILabel alloc] init];
    dealLab.textAlignment = NSTextAlignmentCenter;
    dealLab.numberOfLines = 2;
    dealLab.font = [UIFont systemFontOfSize:13.f];
    dealLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookUpDeal)];
    [dealLab addGestureRecognizer:tap];
    dealLab.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    //不同颜色,行间距
    NSString *texts = @"点击“注册”按钮，即表示您同意\n《用户协议》";
    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:texts];
    [muArrStr addAttributes:@{
                              NSForegroundColorAttributeName:HEX_COLOR(@"#E20025"),
                              NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                              } range:NSMakeRange(texts.length-6, 6)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7.f];
    [paragraphStyle setLineBreakMode:dealLab.lineBreakMode];
    [paragraphStyle setAlignment:dealLab.textAlignment];
    [muArrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [texts length])];
    dealLab.attributedText = muArrStr;
    [self.containerView addSubview:dealLab];
    [dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(10.f);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
    }];
    _lastView = dealLab;
}


- (void)requestFigureValidateCode:(UITapGestureRecognizer *)tap
{
    NSLog(@"获取图形验证码");
    
    BOOL isLegal = YES;
    NSString *message = nil;

    if (isLegal && self.index.integerValue==0) {//手机
        isLegal = [self check_Number:_phoneCell.ys_textFiled.text length:8];
        message = @"手机号不合法";
    }
    else if (isLegal && self.index.integerValue==1) {//邮箱
        isLegal = [self check_Mail:_phoneCell.ys_textFiled.text];
        message = @"邮箱不合法";
    }
    
    if (!isLegal && tap) {
        [MBProgressHUD showText:message toContainer:nil];
        return;
    }
    
    [JYLoginService requestFigureCheckCodeKey:nil Completion:^(id result, id error) {
        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:result options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageView *figureImgView = (UIImageView *)_figureValidateCell.ys_accessoryView;
        figureImgView.image = image;
    }];
}

- (void)sendCodeAction:(JYSendCodeButton *)sender
{
    NSLog(@"%@",!self.index.integerValue?@"获取短信验证码":@"获取邮箱验证码");
    
    if ((self.index.integerValue==0) && ![self check_Number:_phoneCell.ys_text length:8]) {
        [MBProgressHUD showText:@"手机号不合法" toContainer:nil];
        return;
    }
    else if ((self.index.integerValue==1) && ![self check_Mail:_phoneCell.ys_text]) {
            [MBProgressHUD showText:@"邮箱不合法" toContainer:nil];
            return;
    }
    else if (!(_figureValidateCell.ys_text.length>0)) {
        [MBProgressHUD showText:@"请输入图形验证码" toContainer:nil];
        return;
    }
    
    NSString *type = [NSString stringWithFormat:@"%ld", (long)self.index.integerValue+1];
    //发送验证码
    [sender sendCodeMobile:_phoneCell.ys_text yzm:_figureValidateCell.ys_text type:type];
}

- (void)signInAction:(UIButton *)sender
{
    if (![self judgmentOfLegality]) return;
    
    NSString *type = [NSString stringWithFormat:@"%ld", _index.integerValue+1];
    
    if (!self.pushType.integerValue) {//注册
        //发送注册请求
        [MBProgressHUD showLoadingText:@"正在注册" toContainer:nil];
    
        [JYLoginService registerServiceUserName:_userNameCell.ys_text regStr:_phoneCell.ys_text figureCheckCode:nil checkCode:_SMSValidateCell.ys_text password:_loginPwsCell.ys_text recCode:_invitationCodeCell.ys_text type:type completion:^(id result, id error) {
            
            [MBProgressHUD showSuccessMessage:@"注册成功" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }];
    }
    else {//忘记密码
        //发送修改请求
        [MBProgressHUD showLoadingText:@"正在修改" toContainer:nil];
        
        [JYLoginService ForgetPasswordMobile:_phoneCell.ys_text msgCode:_SMSValidateCell.ys_text password:_loginPwsCell.ys_text type:type completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"修改成功" toContainer:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }];
    }
}

- (void)lookUpDeal
{
    NSLog(@"查看协议");
    JYWebController *vc = [[JYWebController alloc] init];
    vc.urlString = @"https://www.baidu.com";
    vc.navTitle = @"注册协议";
    [self.navigationController pushViewController:vc animated:YES];
}

//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (!self.pushType.integerValue) {//注册
//        isLegal = [self check_LetterUnderlineNumber:_userNameCell.ys_textFiled.text];
        isLegal = self.userNameCell.ys_text.length;
        message = @"用户名不能为空";
    }
    
    if (isLegal && self.index.integerValue==0) {//手机
//        isLegal = _phoneCell.ys_textFiled.text.length;
        isLegal = [self check_Number:_phoneCell.ys_textFiled.text length:8];
        message = @"手机号不合法";
    }
    else if (isLegal && self.index.integerValue==1) {//邮箱
        isLegal = [self check_Mail:_phoneCell.ys_textFiled.text];
        message = @"邮箱不合法";
    }
    
    if (isLegal) {
        isLegal = _figureValidateCell.ys_textFiled.text.length;
        message = @"图形验证码不能为空";
    }
    
    if (isLegal) {
        isLegal = _SMSValidateCell.ys_textFiled.text.length;
        message = @"短信验证码不能为空";
    }
    
    if (isLegal) {
        isLegal = [self check_LetterNumGroup:_loginPwsCell.ys_textFiled.text];
        message = @"密码不合法";
    }
    
    if (isLegal) {
        isLegal = [_AffirmPwsCell.ys_textFiled.text isEqualToString:_loginPwsCell.ys_textFiled.text];
        message = @"两次输入的密码不相同";
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


-(void)setIndex:(NSString *)index
{
    _index = index;
}

-(void)setPushType:(NSString *)pushType
{
    _pushType = pushType;
}



@end
