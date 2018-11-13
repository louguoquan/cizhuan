//
//  JYWithdrawController.m
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYWithdrawController.h"
//#import "JYCurrencyBriefController.h"
#import "JYContactSynopsisController.h"
#import "JYScanController.h"
#import "JYWebController.h"
#import "JYRecordController.h"

#import "JYSendCodeButton.h"
#import "JYRechargeNoticeView.h"

#import "JYLoginService.h"
#import "JYAssetsService.h"

@interface JYWithdrawController ()
{
    NSString        *noticeContent;
    NSString        *disCoinNumPlaceHolder;
}

@property (nonatomic, strong) UILabel       *doCoinLab;
@property (nonatomic, strong) UILabel       *frostCoinLab;

@property (nonatomic, strong) YSCellView    *disCoinAddCell;
@property (nonatomic, strong) YSCellView    *disCoinNumCell;
@property (nonatomic, strong) YSCellView    *fundPwsCell;
@property (nonatomic, strong) YSCellView    *figureValidateCell;
@property (nonatomic, strong) YSCellView    *SMSValidateCell;

@property (nonatomic, strong) UILabel       *poundageLab;
@property (nonatomic, strong) UILabel       *actualAccLab;

@property (nonatomic, strong) UIView        *lastView;

@property (nonatomic, strong) JYRechargeNoticeView *noticeView;

@property (nonatomic, copy) NSString            *navTitle;
@property (nonatomic, strong) JYCoinInfoModel   *coinModel;

@end

static NSString *zero = @"0.00000";


@implementation JYWithdrawController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
    
    [self getCoinInfo:NO];
    
    [self requestFigureValidateCode];
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = [self.navTitle stringByAppendingString:@"提币"];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"提币记录" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel sizeToFit];
    [btn addTarget:self action:@selector(seeChargeRecordAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self creatCoinStatusViewBgColor:UIColor.new leftLabel:self.doCoinLab rightLabel:self.frostCoinLab];
    
    _disCoinAddCell = [self creatCellleftTitle:@"提币地址" PlaceHolder:@"请选择提币地址或扫描输入" lastViewGap:10.f];
    _disCoinAddCell.ys_accessoryView = [self creatSelectImgView:[UIImage imageNamed:@"saoyisao"] imgViewSize:CGSizeMake(40, 40) action:@selector(disCoinAddQRAction)];
    _disCoinAddCell.ys_accessoryRightInsets = 10;
    
    _disCoinNumCell = [self creatCellleftTitle:@"提币数量" PlaceHolder:disCoinNumPlaceHolder lastViewGap:10.f];
    _disCoinNumCell.ys_textFiled.keyboardType = UIKeyboardTypeDecimalPad;
    [_disCoinNumCell.ys_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self creatCoinStatusViewBgColor:nil leftLabel:self.poundageLab rightLabel:self.actualAccLab];
    
    _fundPwsCell = [self creatCellleftTitle:@"资金密码" PlaceHolder:@"请输入资金密码" lastViewGap:0];
    _fundPwsCell.ys_textFiled.keyboardType = UIKeyboardTypeNumberPad;
    _fundPwsCell.ys_textFiled.secureTextEntry = YES;
    
    _figureValidateCell = [self creatCellleftTitle:@"图形验证" PlaceHolder:@"请输入图形验证码" lastViewGap:10.f];
    _figureValidateCell.ys_accessoryView = [self creatSelectImgView:nil imgViewSize:CGSizeMake(80, 30) action:@selector(requestFigureValidateCode)];
    _figureValidateCell.ys_accessoryRightInsets = 15;
    
    _SMSValidateCell = [self creatCellleftTitle:@"短信验证" PlaceHolder:@"请输入手机验证码" lastViewGap:10.f];
    
    JYSendCodeButton *sendCodeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
    sendCodeBtn.dk_backgroundColorPicker = DKColorPickerWithKey(VALIDATEBUTTONBG);
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(100);
    }];
    _SMSValidateCell.ys_accessoryView = sendCodeBtn;
    _SMSValidateCell.ys_accessoryRightInsets = 15.f;
    
    [self creatAskWithdrawBtn:@"申请提现"];
    
    [self cretCellView:@"币种简介" rightImage:[UIImage imageNamed:@"return"] topGap:50.f action:@selector(coinTypeSynAction)];
    
//    [self cretCellView:@"充币须知" rightImage:nil topGap:10.f action:@selector(rechargeCoinNoticeAction)];
    
    [self creatNoticeView];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0.f);
    }];
}


- (YSCellView *)creatCellleftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder lastViewGap:(CGFloat)gap
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_contentTextAlignment = NSTextAlignmentLeft;
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentTextColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
//    cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
//    cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
    
    cell.ys_contentPlaceHolder = placeHolder;
    cell.ys_title = leftTitle;
    cell.ys_titleWidth = 15*4;
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(gap);
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (UIImageView *)creatSelectImgView:(UIImage *)image imgViewSize:(CGSize)size action:(nullable SEL)action
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.userInteractionEnabled = YES;
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.image = image;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [imgView addGestureRecognizer:tap];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
    return imgView;
}

- (void)creatAskWithdrawBtn:(NSString *)titles
{
    UIButton *signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBtn.layer.cornerRadius = 1.f;
    signInBtn.layer.masksToBounds = YES;
    signInBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [signInBtn setTitle:titles forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [signInBtn addTarget:self action:@selector(askWithdrawAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(30);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = signInBtn;
}

- (void)creatCoinStatusViewBgColor:(UIColor *)colors leftLabel:(UILabel *)leftLab rightLabel:(UILabel *)rightLab
{
    UIView *bgView = [[UIView alloc] init];
    bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    if (!colors) {
        bgView.backgroundColor = [UIColor clearColor];
    }
    [self.containerView addSubview:bgView];
    
    [bgView addSubview:leftLab];
    [bgView addSubview:rightLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(bgView);
        make.left.mas_equalTo(10.f);
    }];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(leftLab);
        make.left.equalTo(leftLab.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-10);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(_lastView.mas_bottom);
        } else {
            make.top.equalTo(self.containerView);
        }
        
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(44.f);
    }];
    
    _lastView = bgView;
}

- (UIView *)cretCellView:(NSString *)leftTitle rightImage:(UIImage *)image topGap:(CGFloat)gap action:(nullable SEL)action
{
    UIView *cellView = [[UIView alloc] init];
    cellView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [cellView addGestureRecognizer:tap];
    
    [self.containerView addSubview:cellView];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.userInteractionEnabled = YES;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:14.f];
    lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    lab.text = leftTitle;
    [cellView addSubview:lab];
    
    if (image) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = image;
        [cellView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cellView);
            make.right.mas_equalTo(-10.f);
            make.width.mas_equalTo(20.f);
            make.height.mas_equalTo(15.f);
        }];
    }
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(cellView);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(100.f);
    }];
    
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(gap);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44.f);
    }];
    
    _lastView = cellView;
    
    return cellView;
}

- (void)creatNoticeView
{
    UIView *noticeBgView = [[UIView alloc] init];
    noticeBgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    [self.containerView addSubview:noticeBgView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:14.f];
    titleLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    titleLab.text = @"充币须知";
    [noticeBgView addSubview:titleLab];
    
    UILabel *countentLab = [[UILabel alloc] init];
    countentLab.numberOfLines = 0;
    countentLab.textAlignment = NSTextAlignmentLeft;
    countentLab.font = [UIFont systemFontOfSize:13.f];
    countentLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    [noticeBgView addSubview:countentLab];
    //行间距
    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:noticeContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7.f];
    [paragraphStyle setLineBreakMode:countentLab.lineBreakMode];
    [paragraphStyle setAlignment:countentLab.textAlignment];
    [muArrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, noticeContent.length)];
    countentLab.attributedText = muArrStr;
    
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.height.mas_equalTo(44);
    }];
    
    [countentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.bottom.mas_equalTo(-15.f);
    }];
    
    [noticeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(10.f);
        make.left.right.mas_equalTo(0);
    }];
    
    _lastView = noticeBgView;
}

- (NSAttributedString *)setUpText:(NSString *)texts isPoundage:(BOOL)isPoundage
{
    NSString *poundage = isPoundage?@"网络手续费":@"实际到账";
    NSString *text = [NSString stringWithFormat:@"%@ %@%@", poundage, texts, _navTitle];
    NSInteger length = isPoundage?5:4;

    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:text];
    [muArrStr addAttributes:@{
                              NSForegroundColorAttributeName:HEX_COLOR(@"#B2B2B2"),
//                              NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                              } range:NSMakeRange(0, length)];

    return muArrStr;
}

//MARK: -- 查看记录
- (void)seeChargeRecordAction:(UIButton *)sender
{
    JYRecordController *vc = [[JYRecordController alloc] init];
    vc.type = RecordType_coin;
    vc.coinId = self.asModel.coinTypeId;
    vc.coinCode = self.asModel.coinCode;
    vc.isPopRootVC = (sender==nil)?YES:NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)disCoinAddQRAction
{
    NSLog(@"扫描提币地址");
    
    JYScanController *vc = [[JYScanController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    WS(weakSelf)
    vc.scanResultBlock = ^(NSString *result) {
        weakSelf.disCoinAddCell.ys_text = result;
    };
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
    
    //发送验证码
    [sender sendCodeMobile:[JYAccountModel sharedAccount].mobile yzm:_figureValidateCell.ys_text type:@"1"];
}

- (void)askWithdrawAction
{
    NSLog(@"申请提现");
    
    if (![self judgmentOfLegality]) return;
    
    //发送提现请求
    [MBProgressHUD showLoadingText:@"申请中..." toContainer:nil];
    [JYAssetsService submintCoinExchangeWithAddress:_disCoinAddCell.ys_text num:_disCoinNumCell.ys_text coinId:self.asModel.ID password:_fundPwsCell.ys_text msgCode:_SMSValidateCell.ys_text completion:^(id result, id error) {
        [MBProgressHUD showText:@"申请成功" toContainer:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self seeChargeRecordAction:nil];
        });
    }];
}

- (void)coinTypeSynAction
{
    NSLog(@"币种简介");
    JYContactSynopsisController *vc = [[JYContactSynopsisController alloc] init];
    vc.coinId = self.asModel.coinTypeId;
    vc.cuntactName = self.asModel.coinCode;
    [self.navigationController pushViewController:vc animated:YES];
    
//    if (self.coinModel) {
//        if (self.coinModel.coinDesc.length) {
//            [self pushWebVC];
//        }else{
//            [MBProgressHUD showText:@"获取信息失败，请稍后重试" toContainer:nil];
//        }
//    }
//    else {
//        [self getCoinInfo:YES];
//    }
}

- (void)getCoinInfo:(BOOL)isHUD
{
    !isHUD?:[MBProgressHUD showLoadingToContainer:nil];
    WS(weakSelf)
    [JYAssetsService getCoinById:self.asModel.ID completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        weakSelf.coinModel = (JYCoinInfoModel *)result;
        
        if (isHUD) [self pushWebVC];
    }];
}

- (void)pushWebVC
{
    JYWebController *vc = [[JYWebController alloc] init];
    vc.urlString = self.coinModel.coinDesc;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.disCoinNumCell.ys_textFiled) {
        
        NSString *minNum = self.asModel.minExchangeNum ? self.asModel.minExchangeNum:@"0";
        
        if (textField.text.length==0 || [textField.text isEqualToString:@" "]) {
            textField.text = @"";
        }
        else if (textField.text.doubleValue <= minNum.doubleValue){
            [MBProgressHUD showText:[NSString stringWithFormat:@"提币量需大于%@", self.asModel.minExchangeNum] toContainer:nil];
            textField.text = @"";
        }
        else if (textField.text.doubleValue > self.asModel.balance.doubleValue){
            textField.text = self.asModel.balance;
            
            NSString *total = [NSString stringWithFormat:@"%@可转账数量为%@", _navTitle, self.asModel.balance];
            [MBProgressHUD showText:total toContainer:nil];
        }
        
        //计算 手续费、实际到账
        double arrival = textField.text.doubleValue - minNum.doubleValue;
        NSString *actual = [NSString stringWithFormat:@"%f", arrival];
        NSString *pound = minNum;
        
        if (textField.text.length==0) {
            actual = zero;
            pound  = zero;
        }
        self.poundageLab.attributedText = [self setUpText:pound isPoundage:YES];
        self.actualAccLab.attributedText = [self setUpText:actual isPoundage:NO];
    }
}


//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;

    if (isLegal) {
        isLegal = _disCoinAddCell.ys_text.length;
        message = @"提币地址不能为空";
    }
    
    if (isLegal) {
        isLegal = _disCoinNumCell.ys_textFiled.text.length;
        message = @"提币数量不能为空";
    }
    
    if (isLegal) {
        isLegal = [self check_Number:_fundPwsCell.ys_text length:6];
        message = @"资金密码为6位数字";
    }
    
    if (isLegal) {
        isLegal = _figureValidateCell.ys_text.length;
        message = @"图形验证码不能为空";
    }
    
    if (isLegal) {
        isLegal = _SMSValidateCell.ys_text.length;
        message = @"短信验证码";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}

#pragma 正则匹配length位数字
- (BOOL)check_Number:(NSString *)string length:(NSInteger)length
{
    NSString *emailRegex = [NSString stringWithFormat:@"^\\d{%ld}$", (long)length];
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}


- (void)setAsModel:(JYAssetsModel *)asModel
{
    _asModel = asModel;
    
    _navTitle = asModel.coinCode;
    
    self.doCoinLab.text = [NSString stringWithFormat:@"可用：%@%@", asModel.balance, _navTitle];
    self.frostCoinLab.text = [NSString stringWithFormat:@"冻结：%@%@", asModel.freezeBalance, _navTitle];
    
    NSString *minNum = (asModel.minExchangeNum)?asModel.minExchangeNum:@"0";
    disCoinNumPlaceHolder = [NSString stringWithFormat:@"%@%@≥单笔>%@%@", asModel.balance, _navTitle, minNum, _navTitle];
    
    self.poundageLab.attributedText = [self setUpText:zero isPoundage:YES];
    self.actualAccLab.attributedText = [self setUpText:zero isPoundage:NO];
    
    noticeContent = [NSString stringWithFormat:@"1.禁止向%@地址充值任何非%@资产，任何充入该地址的其他资产将不可找回。\n2.%@充值需要整个网络进行确认，达到3个确认后会自动充值到您的账户中。\n3.最小接受充值金额是0.001%@，为快速到账，您可以向网络支付少量手续费。\n4.此地址是您唯一切独自使用的充值地址，您可以同时进行多次充值。", _navTitle, _navTitle, _navTitle, _navTitle];
}


-(UILabel *)doCoinLab
{
    if (!_doCoinLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _doCoinLab = lab;
    }
    return _doCoinLab;
}

-(UILabel *)frostCoinLab
{
    if (!_frostCoinLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _frostCoinLab = lab;
    }
    return _frostCoinLab;
}

-(UILabel *)poundageLab
{
    if (!_poundageLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _poundageLab = lab;
    }
    return _poundageLab;
}

-(UILabel *)actualAccLab
{
    if (!_actualAccLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        _actualAccLab = lab;
    }
    return _actualAccLab;
}

-(JYRechargeNoticeView *)noticeView
{
    if (!_noticeView) {
        _noticeView = [[JYRechargeNoticeView alloc] init];
        _noticeView.animationType = ViewAnimationType_Center;
    }
    return _noticeView;
}

@end
