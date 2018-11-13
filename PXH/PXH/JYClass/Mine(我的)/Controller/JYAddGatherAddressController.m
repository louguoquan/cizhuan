//
//  JYAddGatherAddressController.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAddGatherAddressController.h"

#import "JYMineService.h"

@interface JYAddGatherAddressController ()

@property (nonatomic, strong) YSCellView    *nameCell;
@property (nonatomic, strong) YSCellView    *accountBankCell;
@property (nonatomic, strong) YSCellView    *subBankCell;
@property (nonatomic, strong) YSCellView    *cardNumCell;
@property (nonatomic, strong) YSCellView    *affirmCardNumCell;
@property (nonatomic, strong) YSCellView    *gatherPwsCell;

@property (nonatomic, strong) UIView        *lastView;

@end

@implementation JYAddGatherAddressController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
    
    [self setUpBase];
}

- (void)setUpBase
{
    _nameCell.ys_textFiled.text = [JYAccountModel sharedAccount].realName;
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"添加地址";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    UILabel *promptLab = [[UILabel alloc] init];
    promptLab.textAlignment = NSTextAlignmentLeft;
    promptLab.font = [UIFont systemFontOfSize:13.f];
    promptLab.text = @"请设置您的收款支付方式，请务必使用本人实名账号";
    [self.containerView addSubview:promptLab];
    promptLab.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(40.f);
    }];
    _lastView = promptLab;
    
    _nameCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"姓名" PlaceHolder:@"请输入银行卡开户名" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:0];
    
    _accountBankCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"开户银行" PlaceHolder:@"请输入您的开户银行" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:5];
    
    _subBankCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"开户支行" PlaceHolder:@"请输入您的开户支行" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:1];
    
    _cardNumCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"银行卡号" PlaceHolder:@"请输入您的银行卡号" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:5];
    _cardNumCell.ys_textFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    _affirmCardNumCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"确认卡号" PlaceHolder:@"请再次输入您的银行卡号" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:1];
    _cardNumCell.ys_textFiled.keyboardType = UIKeyboardTypeNumberPad;
    
//    _gatherPwsCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"资金密码" PlaceHolder:@"请输入资金密码" alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES lastViewGap:5];
//    _gatherPwsCell.ys_textFiled.keyboardType = UIKeyboardTypeNumberPad;
//    _gatherPwsCell.ys_textFiled.secureTextEntry = YES;
    
    [self creatAddPresentBtn:@"保存"];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20.f);
    }];
    
    
}

- (YSCellView *)creatCellType:(YSCellViewType)type leftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder alignment:(NSTextAlignment)alignment tfRightViewWidth:(CGFloat)width contentLabelTitle:(NSString *)labTitle isLineHidden:(BOOL)isHidden lastViewGap:(CGFloat)gap
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:type];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_bottomLineHidden = isHidden;
    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_contentTextAlignment = alignment;
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentTextColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    
    if (type==YSCellViewTypeTextField) {
        cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
    }
    else {
        cell.ys_contentLabel.text = labTitle;
        cell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    }
    
    if (leftTitle) {
        cell.ys_title = leftTitle;
        cell.ys_titleWidth = 15*4;
    }
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(_lastView.mas_bottom).mas_offset(gap);
        } else {
            make.top.equalTo(self.containerView);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (void)creatAddPresentBtn:(NSString *)titles
{
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.layer.cornerRadius = 3.f;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [signInBtn setTitle:titles forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [signInBtn addTarget:self action:@selector(addPresentAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(40);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = signInBtn;
}

- (void)selectorPresentTypeAction
{
    NSLog(@"选择类型");
}

- (void)addPresentAddressAction
{
    NSLog(@"保存地址");
    
    if (![self judgmentOfLegality]) return;
    WS(weakSelf)
    [MBProgressHUD showLoadingText:@"保存中..." toContainer:nil];
    [JYMineService addReceivableAddressName:_nameCell.ys_text openBank:_accountBankCell.ys_text bankAddress:_subBankCell.ys_text cardNum:_cardNumCell.ys_text completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        !_addSuccessBlock?:_addSuccessBlock();
    }];
}

//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (isLegal) {
        isLegal = _accountBankCell.ys_text.length;
        message = @"开户银行不能为空";
    }
    
//    if (isLegal) {
//        isLegal = _subBankCell.ys_text.length;
//        message = @"开户支行不能为空";
//    }
    
    if (isLegal) {
        isLegal = _cardNumCell.ys_text.length;
        message = @"银行卡号不能为空";
    }
    
    if (isLegal) {
        isLegal = [self check_Number:_cardNumCell.ys_text length:10];
        message = @"请输入正确的银行卡号";
    }
    
    if (isLegal) {
        isLegal = [_cardNumCell.ys_text isEqualToString:_affirmCardNumCell.ys_text];
        message = @"两次输入的银行卡号不同";
    }
//
//    if (isLegal) {
//        isLegal = _gatherPwsCell.ys_text.length;
//        message = @"资金密码不能为空";
//    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}

#pragma 正则匹配数字(至少length位)
- (BOOL)check_Number:(NSString *)string length:(NSInteger)length
{
    NSString *emailRegex = [NSString stringWithFormat:@"^\\d{%ld,}$", (long)length];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

@end
