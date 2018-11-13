//
//  JYAddPresentAddressController.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAddPresentAddressController.h"

#import "JYSheetView.h"
#import "JYSendCodeButton.h"

#import "JYAssetsService.h"
#import "JYMineService.h"

#import "JYAssetsModel.h"


@interface JYAddPresentAddressController ()
{
    NSString *keyId;//记录币主键
    BOOL     isGainCoinType;//记录是否获取币种
}

@property (nonatomic, strong) YSCellView    *typeCell;
@property (nonatomic, strong) YSCellView    *addNameCell;
@property (nonatomic, strong) YSCellView    *addressCell;
@property (nonatomic, strong) YSCellView    *fundPwsCell;
@property (nonatomic, strong) YSCellView    *smsCell;

@property (nonatomic, strong) UIView        *lastView;

@property (nonatomic, strong) JYSheetView   *sheetView;

@property (nonatomic, strong) NSArray<JYAssetsModel *>   *coinTypeArr;

@end

@implementation JYAddPresentAddressController

-(JYSheetView *)sheetView
{
    if (!_sheetView) {
        __block NSMutableArray *nameArr = [NSMutableArray array];
        [self.coinTypeArr enumerateObjectsUsingBlock:^(JYAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *name = [NSString stringWithFormat:@"%@（%@）", obj.coinCode, obj.coinName];
            [nameArr addObject:name];
            if (self.coinTypeArr.count-1 == idx) {
                [nameArr addObject:@"取消"];
            }
        }];
        
        JYSheetView *typeView = [[JYSheetView alloc] initWithItemTitleArray:nameArr selTypeBlock:^(NSString *type, NSInteger idx) {
            _typeCell.ys_contentLabel.text = type;
            _typeCell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
            keyId = self.coinTypeArr[idx].coinTypeId;
        }];
        typeView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        
        _sheetView = typeView;
    }
    return _sheetView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isGainCoinType = YES;
    
    [self setUpNav];
    [self setUpUI];
    
    [self gainCurrencyType:NO];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"添加提币地址";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);

    _typeCell = [self creatCellType:YSCellViewTypeLabel leftTitle:@"类型" PlaceHolder:nil alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:@"请选择" isLineHidden:YES];
    [_typeCell addTarget:self action:@selector(selectorPresentTypeAction) forControlEvents:UIControlEventTouchUpInside];
    _typeCell.ys_accessoryView = [self creatSelectImgView:[UIImage imageNamed:@"return"] imgViewSize:CGSizeMake(25, 15)];
    
//    UIButton *typeAccBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [typeAccBtn setImage:[UIImage imageNamed:@"return"] forState:0];
//    [typeAccBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
//    [typeAccBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(40.f);
//    }];
//    _typeCell.ys_accessoryView = typeAccBtn;
    
    _addNameCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"地址名称" PlaceHolder:@"填写您的地址" alignment:NSTextAlignmentRight tfRightViewWidth:15 contentLabelTitle:nil isLineHidden:YES];
    
    _addressCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"地址" PlaceHolder:@"请输入提现地址" alignment:NSTextAlignmentRight tfRightViewWidth:15 contentLabelTitle:nil isLineHidden:YES];

/*
    _fundPwsCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"资金密码" PlaceHolder:@"请输入资金密码" alignment:NSTextAlignmentRight tfRightViewWidth:15 contentLabelTitle:nil isLineHidden:YES];
    _fundPwsCell.ys_textFiled.secureTextEntry = YES;
    
    _smsCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"短信验证" PlaceHolder:@"请输入验证码" alignment:NSTextAlignmentLeft tfRightViewWidth:0 contentLabelTitle:nil isLineHidden:YES];

    JYSendCodeButton *sendCodeBtn = [[JYSendCodeButton alloc] initWithSeconds:60 currentVC:self action:@selector(sendCodeAction:)];
    [sendCodeBtn dk_setTitleColorPicker:DKColorPickerWithKey(LOGINBUTTONBG) forState:0];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(100);
    }];
    _smsCell.ys_accessoryView = sendCodeBtn;
    _smsCell.ys_accessoryRightInsets = 15;
*/
    
    [self creatAddPresentBtn:@"确认添加"];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20.f);
    }];
}

- (YSCellView *)creatCellType:(YSCellViewType)type leftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder alignment:(NSTextAlignment)alignment tfRightViewWidth:(CGFloat)width contentLabelTitle:(NSString *)labTitle isLineHidden:(BOOL)isHidden
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
        cell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGDetailHead);
    }
    
    if (leftTitle) {
        cell.ys_title = leftTitle;
        cell.ys_titleWidth = 15*4;
    }
    
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(_lastView.mas_bottom).mas_offset(1.f);
        } else {
            make.top.equalTo(self.containerView);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(51.f);
    }];
    
    _lastView = cell;
    
    return cell;
}

- (UIImageView *)creatSelectImgView:(UIImage *)image imgViewSize:(CGSize)size
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = image;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
    return imgView;
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
        make.top.equalTo(_lastView.mas_bottom).offset(50);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = signInBtn;
}

- (void)selectorPresentTypeAction
{
    if (!self.coinTypeArr && isGainCoinType) {
        [self gainCurrencyType:YES];
        isGainCoinType = NO;
        return;
    }
    
    if (self.coinTypeArr) {
        [self.sheetView show];
    }else {
        [MBProgressHUD showText:@"您当前没有可提现资产" toContainer:nil];
    }
}

- (void)sendCodeAction:(JYSendCodeButton *)sender
{
    NSString *mobile = [JYAccountModel sharedAccount].mobile;
    //发送验证码
    [sender sendCodeMobile:mobile yzm:nil type:@"1"];
}

- (void)addPresentAddressAction
{
    NSLog(@"添加");
    if (![self judgmentOfLegality]) return;
    
    [MBProgressHUD showLoadingText:@"添加中..." toContainer:nil];
    [JYMineService saveCoinAddressId:keyId address:self.addressCell.ys_text remark:self.addNameCell.ys_text completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
        [self.navigationController popViewControllerAnimated:YES];
        !_addSuccessBlock?:_addSuccessBlock();
    }];
}

//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if (isLegal) {
        isLegal = _typeCell.ys_contentLabel.text.length;
        message = @"请选择币类型";
    }
    
    if (isLegal) {
        isLegal = _addressCell.ys_text.length;
        message = @"请输入提币地址";
    }
    
    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}


//MARK: -- 获取我的币种
- (void)gainCurrencyType:(BOOL)isSheet
{
    WS(weakSelf)
    [JYAssetsService fetchMyCoins:0 page:1 completion:^(id result, id error) {
        NSDictionary *dict = result;
        NSArray *array = [JYAssetsModel mj_objectArrayWithKeyValuesArray:dict[@"result"]];
        if (array.count) {
            weakSelf.coinTypeArr = [array mutableCopy];
            //设置默认
            JYAssetsModel *assetsModel = weakSelf.coinTypeArr[0];
            weakSelf.typeCell.ys_contentLabel.text = [NSString stringWithFormat:@"%@（%@）", assetsModel.coinCode, assetsModel.coinName];
            weakSelf.typeCell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
            keyId = assetsModel.coinTypeId;
            
            if (isSheet) [self.sheetView show];
        }
        else {
            weakSelf.coinTypeArr = nil;
            [MBProgressHUD showText:@"您当前没有可提币类型" toContainer:nil];
        }
    }];
}

@end
