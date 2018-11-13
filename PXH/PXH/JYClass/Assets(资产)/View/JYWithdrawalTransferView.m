//
//  JYWithdrawalTransferView.m
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYWithdrawalTransferView.h"

#import "JYGatherAddManagerController.h"

#import "JYDownMenuView.h"
#import "JYSendCodeButton.h"
#import "JYAssetsService.h"
#import "JYLoginService.h"
#import "JYAssetsModel.h"
#import "JYMineService.h"
#import "JYGatherAddModel.h"

@interface JYWithdrawalTransferView ()<UITextFieldDelegate> {
    BOOL        isGainCurType;  //记录是否获取币种
    NSInteger   idx;            //记录选择资产索引
    NSString    *myBankId;      //(银行卡号id)收款账户id
    NSString    *keyId;         //记录币主键
}

@property (nonatomic,strong)UILabel   *codeLabel;
@property (nonatomic,strong)UITextField *figureCodeTF;
@property (nonatomic,strong)UIButton  *submitBtn;
@property (nonatomic, strong) UIImageView *figureImgView;
@property (nonatomic, strong) JYSendCodeButton *codeBtn;
@property (nonatomic, strong) JYDownMenuView *menuView;

@property (nonatomic, strong) NSArray<JYAssetsModel *> *currencyTypeArr;

@end

@implementation JYWithdrawalTransferView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        isGainCurType = YES;
        
        [self initView];
        
        [self defaultGatheringAccount];
        [self gainCurrencyType:NO];
        [self requestFigureValidateCode:nil];
    }
    return self;
}

- (void)initView{
    
    UILabel *label1 = [UILabel new];
    label1.text = @"资产";
    label1.textAlignment = NSTextAlignmentRight;
    label1.font = [UIFont systemFontOfSize:13];
    label1.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"转账数量";
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:13];
    label2.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    
    UILabel *label3 = [UILabel new];
    label3.text = @"转账费用";
    label3.textAlignment = NSTextAlignmentRight;
    label3.font = [UIFont systemFontOfSize:13];
    label3.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label3];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    
    UILabel *bankLab = [UILabel new];
    bankLab.text = @"银行卡号";
    bankLab.textAlignment = NSTextAlignmentRight;
    bankLab.font = [UIFont systemFontOfSize:13];
    bankLab.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:bankLab];
    
    [bankLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    
    UILabel *label4 = [UILabel new];
    label4.text = @"收款人账号";
    label4.textAlignment = NSTextAlignmentRight;
    label4.font = [UIFont systemFontOfSize:13];
    label4.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label4];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankLab.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    
    UILabel *label5 = [UILabel new];
    label5.text = @"资金密码";
    label5.textAlignment = NSTextAlignmentRight;
    label5.font = [UIFont systemFontOfSize:13];
    label5.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label5];
    
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    UILabel *label6 = [UILabel new];
    label6.text = @"图形验证码";
    label6.textAlignment = NSTextAlignmentRight;
    label6.font = [UIFont systemFontOfSize:13];
    label6.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label6];
    
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    UILabel *label7 = [UILabel new];
    label7.text = @"验证码";
    label7.textAlignment = NSTextAlignmentRight;
    label7.font = [UIFont systemFontOfSize:13];
    label7.dk_textColorPicker = DKColorPickerWithKey(AssetsMessageTEXT);
    [self addSubview:label7];
    
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label6.mas_bottom).offset(11);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(70);
    }];
    
    
    [self addSubview:self.coinTypeTF];
    [self addSubview:self.coinCountTF];
    [self addSubview:self.coinworthLabel];
    [self addSubview:self.bankNumTF];
    [self addSubview:self.accountTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.figureCodeTF];
    [self addSubview:self.figureImgView];
    [self addSubview:self.codeTF];
//    [self addSubview:self.self.codeLabel];
    [self addSubview:self.codeBtn];
    [self addSubview:self.submitBtn];
    
    
    [self.coinTypeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    self.coinTypeTF.delegate = self;
    
    UIImageView * LeftView  = [[UIImageView alloc]init];
    LeftView.image = [UIImage imageNamed:@"arror_down"];
    [LeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(20);
    }];
    self.coinTypeTF.rightView = LeftView;
    self.coinTypeTF.rightViewMode = UITextFieldViewModeAlways;

    
    [self.coinCountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    [self.coinworthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    
    [self.bankNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankLab);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(bankLab.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    UIImageView * bankLeftView  = [[UIImageView alloc]init];
    bankLeftView.contentMode = UIViewContentModeScaleAspectFit;
    bankLeftView.userInteractionEnabled = YES;
    bankLeftView.image = [UIImage imageNamed:@"return"];
    [bankLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(20);
    }];
    self.bankNumTF.rightView = bankLeftView;
    self.bankNumTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5);
        make.right.equalTo(self).offset(-15);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    [self.figureImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label6);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    [self.figureCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label6);
        make.right.equalTo(self.figureImgView.mas_left).offset(-8);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label7);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(100);
    }];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label7);
        make.right.equalTo(self.codeBtn.mas_left).offset(-8);
        make.left.equalTo(label1.mas_right).offset(15);
        make.height.mas_equalTo(36);
    }];

    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTF.mas_bottom).offset(11);
        make.left.equalTo(self.codeTF);
        make.right.equalTo(self.codeBtn.mas_left);
        make.height.mas_equalTo(36);
        make.bottom.equalTo(self).offset(-50);
    }];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.coinTypeTF) {
//        if (!self.currencyTypeArr && isGainCurType) {
//            [self gainCurrencyType:YES];
//            isGainCurType = NO;
//            return NO;
//        }
//
//        if (self.currencyTypeArr) {
//            [self.menuView show];
//        }else {
//            [MBProgressHUD showText:@"您当前没有可提现资产" toContainer:nil];
//        }
        return NO;
    }
    else if (textField == self.bankNumTF) {
        UIViewController *vc = [self getCurrentVC];
        if (vc) {
            JYGatherAddManagerController *gatherVC = [JYGatherAddManagerController new];
            [vc.navigationController pushViewController:gatherVC animated:YES];
            gatherVC.c2cSelBankNumBlock = ^(NSString *bankNum, NSString *bankId) {
                self.bankNumTF.text = bankNum;
                myBankId = bankId;
            };
        }
        return NO;
    }
    
    return YES;
}

//MARK: -- 转账费用
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.coinCountTF) {
        if (textField.text.length==0) {
            self.coinworthLabel.text = @"0";
            return;
        }
        else if ([textField.text isEqualToString:@" "]) {
            self.coinCountTF.text = nil;
            return;
        }
        else if (textField.text.integerValue > self.currencyTypeArr[idx].total.integerValue){
            self.coinCountTF.text = self.currencyTypeArr[idx].total;
            
            NSString *total = [NSString stringWithFormat:@"%@可转账数量为%@", self.currencyTypeArr[idx].coinCode, self.currencyTypeArr[idx].total];
            [MBProgressHUD showText:total toContainer:nil];
        }

        [JYAssetsService transferFees:keyId num:_coinCountTF.text completion:^(id result, id error) {
            self.coinworthLabel.text = [NSString stringWithFormat:@"%@", result];
        }];
    }
}

//MARK: -- 默认收款账户
- (void)defaultGatheringAccount
{
    WS(weakSelf)
    [JYMineService getReceivableAddressListCompletion:^(id result, id error) {
        NSArray *bankArr = [result mutableCopy];
        [bankArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL ifdefault = [(JYGatherAddModel *)bankArr[idx] ifDefault].boolValue;
            if (ifdefault) {
                weakSelf.bankNumTF.text = [(JYGatherAddModel *)bankArr[idx] cardNum];
                return;
            }
        }];
    }];
}

//MARK: -- 获取我的币种
- (void)gainCurrencyType:(BOOL)isMeunView
{
    WS(weakSelf)
    [JYAssetsService fetchMyCoins:1 page:1 completion:^(id result, id error) {
        NSDictionary *dict = result;
        NSArray *array = [JYAssetsModel mj_objectArrayWithKeyValuesArray:dict[@"result"]];
        if (array.count) {
            weakSelf.currencyTypeArr = [array mutableCopy];
//            设置默认
//            JYAssetsModel *assetsModel = weakSelf.currencyTypeArr[0];
//            self.coinTypeTF.text = [NSString stringWithFormat:@"%@（%@）", assetsModel.coinCode, assetsModel.coinName];
//            self.coinCountTF.placeholder = [NSString stringWithFormat:@"可用%@", assetsModel.total];
//            self.keyId = assetsModel.coinTypeId;
//            idx = 0;
//            if (isMeunView) [self.menuView show];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JYAssetsModel *assetsModel = (JYAssetsModel *)obj;
                if ([assetsModel.coinCode isEqualToString:@"USDT"]) {
                    self.coinTypeTF.text = [NSString stringWithFormat:@"%@（%@）", assetsModel.coinCode, assetsModel.coinName];
                    self.coinCountTF.placeholder = [NSString stringWithFormat:@"可用%@", assetsModel.total];
                    keyId = assetsModel.coinTypeId;
                }
            }];
        }
        else {
            weakSelf.currencyTypeArr = nil;
            self.coinTypeTF.text = @"没有可提现资产";
        }
    }];
}

//MARK: -- 图形验证码
- (void)requestFigureValidateCode:(UITapGestureRecognizer *)tap
{
    NSLog(@"获取图形验证码");
    WS(weakSelf)
    [JYLoginService requestFigureCheckCodeKey:nil Completion:^(id result, id error) {
        NSData *imgData = [[NSData alloc] initWithBase64EncodedString:result options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        weakSelf.figureImgView.image = [UIImage imageWithData:imgData];
    }];
}

//MARK: -- SMS验证码
- (void)sendCodeAction:(JYSendCodeButton *)sender
{
    if (!self.figureCodeTF.text.length) {
        [MBProgressHUD showText:@"请输入图形验证码" toContainer:nil];
        return;
    }
    
    //发送验证码
    [sender sendCodeMobile:[JYAccountModel sharedAccount].mobile yzm:self.figureCodeTF.text type:@"1"];
}

//MARK: -- 提交
- (void)submitAction:(UIButton *)sender
{
    if (![self judgmentOfLegality]) return;
    
    [MBProgressHUD showLoadingText:@"提交中..." toContainer:nil];
    [JYAssetsService commitTransferAsk:keyId num:self.coinCountTF.text myBankId:myBankId accountNo:self.accountTF.text payPassword:self.passwordTF.text yzm:self.codeTF.text completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"提交成功" toContainer:nil];
        
        //重置数据
        isGainCurType = YES;
        [self gainCurrencyType:NO];
    }];
}

//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (!self.coinTypeTF.text.length) {
        isLegal = NO;
        message = @"请选择资产";
    }
    else if (isLegal && [self.coinTypeTF.text isEqualToString:@"没有可提现资产"]) {
        isLegal = NO;
        message = @"没有可提现资产";
    }
    else if (isLegal && !self.coinCountTF.text.length) {
        isLegal = NO;
        message = @"请输入转账数量";
    }
    else if (isLegal && !self.bankNumTF.text.length) {
        isLegal = NO;
        message = @"请选择(添加)收款银行卡号";
    }
    else if (isLegal && !self.accountTF.text.length) {
        isLegal = NO;
        message = @"请输入收款人账号(邮箱)";
    }
    else if (isLegal && ![self check_Mail:self.accountTF.text]) {
        isLegal = NO;
        message = @"邮箱格式不正确";
    }
    else if (isLegal && !self.passwordTF.text.length) {
        isLegal = NO;
        message = @"请输入资金密码";
    }
    else if (isLegal && !self.figureCodeTF.text.length) {
        isLegal = NO;
        message = @"请输入图形验证码";
    }
    
    else if (isLegal && !self.codeTF.text.length) {
        isLegal = NO;
        message = @"请输入验证码";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}

#pragma 正则匹配邮箱号
- (BOOL)check_Mail:(NSString *)string
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

#pragma 正则匹配数字(6位)
- (BOOL)check_Number:(NSString *)string
{
    NSString *emailRegex = @"^\\d{6}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}



- (void)setModel:(JYWithdrawalTransferModel *)model
{
    self.coinTypeTF.text = @"Tether USD（USDT）";
    
    self.coinCountTF.placeholder = @"可用0.00";
    
    self.coinworthLabel.text = @"0";
    
    self.bankNumTF.placeholder = @"请选择收款银行卡号";
    
    self.accountTF.placeholder = @"收款人注册邮箱";
    
    self.passwordTF.placeholder = @"请输入资金密码";
    
    self.figureCodeTF.placeholder = @"图形验证码";
    
    self.codeTF.placeholder = @"短信验证码";
    
//    keyId = @"1";
}


- (JYTextField *)coinTypeTF
{
    if (!_coinTypeTF) {
        _coinTypeTF = [JYTextField new];
        _coinTypeTF.font = [UIFont systemFontOfSize:13];
        _coinTypeTF.borderStyle = UITextBorderStyleRoundedRect;
        _coinTypeTF.textAlignment = NSTextAlignmentCenter;
    }
    return _coinTypeTF;
    
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//
//{
//
//    UIView *view = textField.superview;
//
//    while (![view isKindOfClass:[UITableViewCell class]]) {
//
//        view = [view superview];
//
//    }
//
//    UITableViewCell *cell = (UITableViewCell*)view;
//
//    CGRect rect = [cell convertRect:cell.frame toView:self];
//
//    if (rect.origin.y / 2 + rect.size.height> = kScreenHeight -216) {
//
//        _tabelView.contentInset = UIEdgeInsetsMake(0, 0, 216, 0);
//
//        [_tabelView scrollToRowAtIndexPath:[_tabelView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//
//    }
//
//    return YES;
//
//}


- (UITextField *)coinCountTF
{
    if (!_coinCountTF) {
        _coinCountTF = [UITextField new];
        _coinCountTF.font = [UIFont systemFontOfSize:13];
        _coinCountTF.borderStyle = UITextBorderStyleRoundedRect;
        [_coinCountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _coinCountTF;
    
}

-(JYTextField *)bankNumTF
{
    if (!_bankNumTF) {
        _bankNumTF = [JYTextField new];
        _bankNumTF.font = [UIFont systemFontOfSize:13];
        _bankNumTF.borderStyle = UITextBorderStyleRoundedRect;
        _bankNumTF.delegate = self;
    }
    return _bankNumTF;
}


- (UITextField *)accountTF
{
    if (!_accountTF) {
        _accountTF = [UITextField new];
        _accountTF.font = [UIFont systemFontOfSize:13];
        _accountTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _accountTF;
    
}

- (UITextField *)passwordTF
{
    if (!_passwordTF) {
        _passwordTF = [UITextField new];
        _passwordTF.font = [UIFont systemFontOfSize:13];
        _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _passwordTF;
    
}

-(UITextField *)figureCodeTF
{
    if (!_figureCodeTF) {
        _figureCodeTF = [UITextField new];
        _figureCodeTF.font = [UIFont systemFontOfSize:13];
        _figureCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _figureCodeTF;
}

- (UITextField *)codeTF
{
    if (!_codeTF) {
        _codeTF = [UITextField new];
        _codeTF.font = [UIFont systemFontOfSize:13];
        _codeTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _codeTF;
    
}

- (UILabel *)coinworthLabel
{
    if (!_coinworthLabel) {
        _coinworthLabel = [UILabel new];
        _coinworthLabel.font = [UIFont systemFontOfSize:13];
        _coinworthLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
    }
    return _coinworthLabel;
    
}

- (UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel new];
        _codeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithBtnBG);
        _codeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsBtnTEXT);
        _codeLabel.font = [UIFont systemFontOfSize:13];
        _codeLabel.textAlignment = NSTextAlignmentCenter;
        _codeLabel.text = @"获取验证码";
    }
    return _codeLabel;
}

-(UIImageView *)figureImgView
{
    if (!_figureImgView) {
        UIImageView *imagView = [[UIImageView alloc] init];
        imagView.layer.cornerRadius = 3.f;
        imagView.layer.masksToBounds = YES;
        imagView.backgroundColor = [UIColor redColor];
        imagView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestFigureValidateCode:)];
        [imagView addGestureRecognizer:tap];
        
        _figureImgView = imagView;
    }
    return _figureImgView;
}

- (JYSendCodeButton *)codeBtn
{
    if (!_codeBtn) {
        _codeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
        _codeBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithBtnBG);
    }
    return _codeBtn;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        _submitBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithBtnBG);
        [_submitBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (JYDownMenuView *)menuView
{
    if (!_menuView) {
        WS(weakSelf)
        
        __block NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:20];
        
        [self.currencyTypeArr enumerateObjectsUsingBlock:^(JYAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *name = [NSString stringWithFormat:@"%@（%@）", obj.coinCode, obj.coinName];
            [nameArr addObject:name];
        }];
        
        _menuView = [[JYDownMenuView alloc] initWithFrame:CGRectZero dataSource:nameArr];
        _menuView.selectedCellBlack = ^(JYDownMenuView *menuView, NSInteger index, NSString *content) {
            weakSelf.coinTypeTF.text = content;
            weakSelf.coinCountTF.placeholder = [NSString stringWithFormat:@"可用%@", weakSelf.currencyTypeArr[index].total];
            keyId = weakSelf.currencyTypeArr[index].coinTypeId;
            idx = index;
            
            [weakSelf textFieldDidChange:weakSelf.coinCountTF];
        };
    }
    
    //获取控件相对屏幕的位置
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self.coinTypeTF convertRect:self.coinTypeTF.bounds toView:window];
    
    _menuView.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetWidth(rect), 200);
    
    return _menuView;
}

@end
