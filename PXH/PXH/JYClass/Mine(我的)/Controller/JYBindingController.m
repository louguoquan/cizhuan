//
//  JYBindingController.m
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBindingController.h"

#import "JYSendCodeButton.h"

#import "JYLoginService.h"
#import "JYMineService.h"

@interface JYBindingController ()

@property (nonatomic, strong) YSCellView    *phoneCell;
@property (nonatomic, strong) YSCellView    *graphicsVerifCell;
@property (nonatomic, strong) YSCellView    *smsCell;

@property (nonatomic, strong) UIView        *lastView;

@end

@implementation JYBindingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
    
    [self requestFigureValidateCode:nil];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    navigationLabel.text = _navTitle;
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    //手机和邮箱数据差异
    BOOL isPhone = [self.navTitle containsString:@"手机"];
    
    NSString *phoneStr = isPhone?@"手机号":@"邮箱";
    NSString *phonePlaceHolderStr = isPhone?@"请输入手机号":@"请输入邮箱";
    
    NSString *smsVerifStr = isPhone?@"短信验证":@"邮箱验证";
    NSString *smsVerifPlaceHolderStr = isPhone?@"请输入短信验证码":@"请输入邮箱验证码";
    
    _phoneCell = [self creatCellTitle:phoneStr PlaceHolder:phonePlaceHolderStr];
    
    _graphicsVerifCell = [self creatCellTitle:@"图形验证" PlaceHolder:@"请输入图形验证码"];
    _graphicsVerifCell.ys_accessoryView = [self creatSelectImgView:UIImage.new imgViewSize:CGSizeMake(80, 30)];
    _graphicsVerifCell.ys_accessoryRightInsets = 15.f;
    
    _smsCell = [self creatCellTitle:smsVerifStr PlaceHolder:smsVerifPlaceHolderStr];
    
    JYSendCodeButton *sendCodeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
    sendCodeBtn.dk_backgroundColorPicker = DKColorPickerWithKey(VALIDATEBUTTONBG);
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(100);
    }];
    _smsCell.ys_accessoryView = sendCodeBtn;
    _smsCell.ys_accessoryRightInsets = 15.f;
    
    [self creatBindingBtn:self.navTitle];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20.f);
    }];
}

- (YSCellView *)creatCellTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentTextColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    cell.ys_titleWidth = 15*4;
    cell.ys_title = leftTitle;
    cell.ys_contentPlaceHolder = placeHolder;
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    [self.containerView addSubview:cell];
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(_lastView.mas_bottom).mas_offset(10.f);
        } else {
            make.top.equalTo(self.containerView).mas_offset(10.f);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (UIImageView *)creatSelectImgView:(UIImage *)image imgViewSize:(CGSize)size
{
    UIImageView *imagView = [[UIImageView alloc] init];
    imagView.layer.cornerRadius = 3.f;
    imagView.layer.masksToBounds = YES;
    imagView.backgroundColor = [UIColor redColor];
    imagView.image = image;
    imagView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestFigureValidateCode:)];
    [imagView addGestureRecognizer:tap];

    [imagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
    return imagView;
}

- (void)creatBindingBtn:(NSString *)titles
{
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.layer.cornerRadius = 3.f;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [signInBtn setTitle:titles forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [signInBtn addTarget:self action:@selector(bindingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(30);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = signInBtn;
}


- (void)sendCodeAction:(JYSendCodeButton *)sender
{
    NSLog(@"%@",![self.navTitle containsString:@"手机"]?@"获取短信验证码":@"获取邮箱验证码");
    
    if ([self.navTitle containsString:@"手机"] && ![self check_Number:_phoneCell.ys_text length:8]) {
        [MBProgressHUD showText:@"手机号不合法" toContainer:nil];
        return;
    }
    else if ([self.navTitle containsString:@"邮箱"] && ![self check_Mail:_phoneCell.ys_text]) {
        [MBProgressHUD showText:@"邮箱不合法" toContainer:nil];
        return;
    }
    else if (!(_graphicsVerifCell.ys_text.length>0)) {
        [MBProgressHUD showText:@"请输入图形验证码" toContainer:nil];
        return;
    }
    
    NSString *type = [self.navTitle containsString:@"手机"]?@"1":@"2";
    //发送验证码
    [sender sendCodeMobile:_phoneCell.ys_text yzm:_graphicsVerifCell.ys_text type:type];
}

- (void)requestFigureValidateCode:(UITapGestureRecognizer *)tap
{
    NSLog(@"获取图形验证码");
    
    if (tap && [self.navTitle containsString:@"手机"] && ![self check_Number:_phoneCell.ys_text length:8]) {
        [MBProgressHUD showText:@"手机号不合法" toContainer:nil];
        return;
    }
    else if (tap && [self.navTitle containsString:@"邮箱"] && ![self check_Mail:_phoneCell.ys_text]) {
        [MBProgressHUD showText:@"邮箱不合法" toContainer:nil];
        return;
    }

    WS(weakSelf)
    [JYLoginService requestFigureCheckCodeKey:nil Completion:^(id result, id error) {
        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:result options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        UIImage *image = [UIImage imageWithData:imgData];
        
        UIImageView *imgView = (UIImageView *)weakSelf.graphicsVerifCell.ys_accessoryView;
        imgView.image = image;
    }];
}


- (void)bindingAction
{
    NSLog(@"绑定");
    
    if (![self judgmentOfLegality]) return;
    
    [MBProgressHUD showLoadingToContainer:nil];
    if ([self.navTitle containsString:@"手机"]) {
        [JYMineService bindMobile:self.phoneCell.ys_text checkCode:self.smsCell.ys_text completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"绑定成功" toContainer:nil];
            [self.navigationController popViewControllerAnimated:YES];
            !_bindSuccessBlock?:_bindSuccessBlock(1, self.phoneCell.ys_text);
        }];
    }
    else {
        [JYMineService bindEmail:self.phoneCell.ys_text checkCode:self.smsCell.ys_text completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"绑定成功" toContainer:nil];
            [self.navigationController popViewControllerAnimated:YES];
            !_bindSuccessBlock?:_bindSuccessBlock(2, self.phoneCell.ys_text);
        }];
    }
}


//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    BOOL isPhone = [self.navTitle containsString:@"手机"];
    
    if (isPhone && ![self check_Number:_phoneCell.ys_text length:8]) {
        isLegal = NO;
        message = @"手机号不合法";
    }
    else if (!isPhone && ![self check_Mail:_phoneCell.ys_text]) {
        isLegal = NO;
        message = @"邮箱不合法";
    }
    else if (!(_graphicsVerifCell.ys_text.length>0)) {
        isLegal = NO;
        message = @"请输入图形验证码";
    }
    else if (_smsCell.ys_text.length==0) {
        isLegal = NO;
        message = isPhone?@"请输手机验证码":@"请输邮箱验证码";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}



-(void)setNavTitle:(NSString *)navTitle
{
    _navTitle = navTitle;
}


#pragma 正则匹配数字(6位)
- (BOOL)check_Number:(NSString *)string
{
    NSString *emailRegex = @"^\\d{6}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
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

@end
