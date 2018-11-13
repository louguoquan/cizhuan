//
//  JYRealNameAuthController.m
//  PXH
//
//  Created by LX on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYRealNameAuthController.h"
#import "JYCountryController.h"

#import "JYPicturePicker.h"

#import "JYSheetView.h"

#import "JYMineService.h"
#import "JYImageModel.h"

@interface JYRealNameAuthController ()
{
    NSString *countryId;
    NSString *papersTypeId;
}

@property (nonatomic, strong) YSCellView    *cityCell;
@property (nonatomic, strong) YSCellView    *papersTypeCell;
@property (nonatomic, strong) YSCellView    *paperNameCell;
@property (nonatomic, strong) YSCellView    *paperNumCell;

@property (nonatomic, strong) UIView        *lastView;

@property (nonatomic, strong) JYSheetView   *sheetView;
    
@property (nonatomic, strong) NSMutableDictionary *selImgMuDic;

@end

static NSInteger const RealBase_Tag = 1000;

@implementation JYRealNameAuthController

-(JYSheetView *)sheetView
{
    if (!_sheetView) {
        NSArray *arr = @[@"身份证", @"护照", @"取消"];
        JYSheetView *typeView = [[JYSheetView alloc] initWithItemTitleArray:arr selTypeBlock:^(NSString *type, NSInteger idx) {
            papersTypeId = [NSString stringWithFormat:@"%ld", idx+1];
            _papersTypeCell.ys_contentLabel.text = type;
            _papersTypeCell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        }];
        typeView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        
        _sheetView = typeView;
    }
    return _sheetView;
}

-(NSMutableDictionary *)selImgMuDic
{
    if (!_selImgMuDic) {
        _selImgMuDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    return _selImgMuDic;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"实名认证";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self creatHeadView:@"1" headTitle:@"个人基本资料"];
    
    _cityCell = [self creatCellType:YSCellViewTypeLabel leftTitle:@"国家及地区" PlaceHolder:nil alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:@"请选择" lastViewGap:0];
    [_cityCell addTarget:self action:@selector(selectorCityAction) forControlEvents:UIControlEventTouchUpInside];
    _cityCell.ys_accessoryView = [self creatSelectImgView:[UIImage imageNamed:@"return"] imgViewSize:CGSizeMake(25, 15)];
    
    _papersTypeCell = [self creatCellType:YSCellViewTypeLabel leftTitle:@"证件类型" PlaceHolder:nil alignment:NSTextAlignmentRight tfRightViewWidth:0 contentLabelTitle:@"请选择" lastViewGap:5];
    [_papersTypeCell addTarget:self action:@selector(selectorPapersTypeAction) forControlEvents:UIControlEventTouchUpInside];
    _papersTypeCell.ys_accessoryView = [self creatSelectImgView:[UIImage imageNamed:@"return"] imgViewSize:CGSizeMake(25, 15)];
    
    _paperNameCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"证件姓名" PlaceHolder:@"请输入您的真实姓名" alignment:NSTextAlignmentRight tfRightViewWidth:15 contentLabelTitle:nil lastViewGap:5];
    
    _paperNumCell = [self creatCellType:YSCellViewTypeTextField leftTitle:@"证件号码" PlaceHolder:@"请输入您的证件号码" alignment:NSTextAlignmentRight tfRightViewWidth:15 contentLabelTitle:nil lastViewGap:5];
    
    [self creatHeadView:@"2" headTitle:@"提交身份证件照"];
    
    [self creatPapersShowView:0];
    
    [self creatPapersShowView:1];
    
    [self creatPapersShowView:2];
    
    UILabel *noticeLab = [[UILabel alloc] init];
    noticeLab.font = [UIFont systemFontOfSize:13.f];
    noticeLab.text = @"上传须知:";
    [self.containerView addSubview:noticeLab];
    [noticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.height.mas_equalTo(30.f);
    }];
    _lastView = noticeLab;
    
    UIView *noticeDetailBgView = [[UIView alloc] init];
    noticeDetailBgView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UILabel *noticeDetailLab = [[UILabel alloc] init];
    noticeDetailLab.numberOfLines = 0;
    noticeDetailLab.font = [UIFont systemFontOfSize:12.f];
    NSString *texts = @"1、请确保照片的内容完整并清晰可见，证件必须在有效期内。\n2、照片内容真实有效，不做任何修改。\n3、支持jpg/peg/png格式，最大不超过2M。";
    //行间距
    NSMutableAttributedString *muArrStr = [[NSMutableAttributedString alloc] initWithString:texts];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7.f];
    [paragraphStyle setLineBreakMode:noticeDetailLab.lineBreakMode];
    [paragraphStyle setAlignment:noticeDetailLab.textAlignment];
    [muArrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [texts length])];
    noticeDetailLab.attributedText = muArrStr;
    noticeDetailLab.dk_textColorPicker = DKColorPickerWithKey(TRADINGHalfBTNTEXT);
    
    [noticeDetailBgView addSubview:noticeDetailLab];
    [self.containerView addSubview:noticeDetailBgView];
    
    [noticeDetailBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(5.f);
        make.left.right.mas_equalTo(0);
    }];
    
    [noticeDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noticeDetailBgView).mas_offset(15.f);
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(-15.f);
    }];
    _lastView = noticeDetailBgView;
    
    [self creatReferBtn:@"提交认证"];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20.f);
    }];
}

- (UIView *)creatHeadView:(NSString *)serialNum headTitle:(NSString *)titles
{
    UIView *headView = [[UIView alloc] init];
    [self.containerView addSubview:headView];
    
    UILabel *serialLab = [[UILabel alloc] init];
    serialLab.layer.cornerRadius = 10.f;
    serialLab.layer.masksToBounds = YES;
    serialLab.textAlignment = NSTextAlignmentCenter;
    serialLab.font = [UIFont systemFontOfSize:13.f];
    serialLab.text = serialNum;
    [headView addSubview:serialLab];
    serialLab.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    serialLab.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:13.f];
    titleLab.text = titles;
    [headView addSubview:titleLab];
    titleLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_lastView) {
            make.top.equalTo(self.lastView.mas_bottom);
        }else{
            make.top.equalTo(self.containerView);
        }
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(40.f);
    }];
    
    [serialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.mas_equalTo(15.f);
        make.width.height.mas_equalTo(20.f);
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.equalTo(serialLab.mas_right).mas_offset(10);
        make.right.mas_equalTo(15);
    }];
    
    _lastView = headView;
    
    return headView;
}

- (YSCellView *)creatCellType:(YSCellViewType)type leftTitle:(NSString *)leftTitle PlaceHolder:(NSString *)placeHolder alignment:(NSTextAlignment)alignment tfRightViewWidth:(CGFloat)width contentLabelTitle:(NSString *)labTitle lastViewGap:(CGFloat)gap
{
    YSCellView *cell = [[YSCellView alloc] initWithStyle:type];
    [self.containerView addSubview:cell];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.ys_bottomLineHidden = isHidden;
//    cell.ys_separatorColor = HEX_COLOR(@"#ededed");
    cell.ys_contentTextAlignment = alignment;
    cell.ys_titleFont = [UIFont systemFontOfSize:14];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_contentTextColor = HEX_COLOR(@"#333333");
    cell.ys_contentFont = [UIFont systemFontOfSize:14];
    
    if (placeHolder) cell.ys_contentPlaceHolder = placeHolder;
    
    if (type==YSCellViewTypeTextField) {
        cell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        cell.ys_textFiled.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        cell.ys_textFiled.rightViewMode = UITextFieldViewModeAlways;
        cell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else {
        cell.ys_contentLabel.text = labTitle;
        cell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(TRADINGDetailHead);
    }
    
    if (leftTitle) {
        cell.ys_title = leftTitle;
        cell.ys_titleWidth = 15*5;
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

- (void)creatReferBtn:(NSString *)titles
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 3.f;
    btn.layer.masksToBounds = YES;
    btn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [btn setTitle:titles forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(referAction) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).offset(40);
        make.left.equalTo(self.containerView).mas_offset(15.f);
        make.right.equalTo(self.containerView).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
    _lastView = btn;
}

/**
 @param index 0:正面照，1：背面照，2：手持证件照
 */
- (void)creatPapersShowView:(NSInteger)index
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.contentMode = UIViewContentModeScaleToFill;
    bgView.userInteractionEnabled = YES;
    bgView.layer.cornerRadius = 8.f;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderWidth = 1.f;
    [self.containerView addSubview:bgView];
    
    bgView.tag = RealBase_Tag+index;
    
    bgView.layer.dk_borderColorPicker = DKColorPickerWithKey(KBORDERLINE);
    bgView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = RealBase_Tag+index;
    [btn setImage:[UIImage imageNamed:@"DSLRCamera"] forState:0];
//    [btn setImage:[UIImage imageNamed:@"finish"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(selectPapersImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:13.f];
    NSString *textStr = @"上传证件正面照";
    switch (index) {
        case 1: textStr = @"上传证件背面照"; break;
        case 2: textStr = @"上传手持证件照"; break;
    }
    lab.text = textStr;
    [bgView addSubview:lab];
    lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(index?20:0);
        make.left.mas_equalTo(20.f);
        make.right.mas_equalTo(-20.f);
        make.height.equalTo(bgView.mas_width).multipliedBy(0.63f);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.bottom.equalTo(bgView.mas_centerY);
        make.width.mas_equalTo(60.f);
        make.height.mas_equalTo(49.f);
    }];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView.mas_centerY).mas_offset(20);
    }];
    
    _lastView = bgView;
}


//MARK: -- 选择国家
- (void)selectorCityAction
{
    JYCountryController *vc = [[JYCountryController alloc] init];
    vc.selectEndBlock = ^(NSString *country, NSString *Id) {
        self.cityCell.ys_contentLabel.text = country;
        self.cityCell.ys_contentLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        countryId = Id;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK: -- 选择证件类型
- (void)selectorPapersTypeAction
{
    [self.sheetView show];
}

//MARK: -- 选取证件照
- (void)selectPapersImageAction:(UIButton *)sender
{
    [[JYPicturePicker sharedPicturePicker] pickUpCameraOrPhotoAlbum:self selImageBlock:^(UIImage *selImage) {
        NSLog(@"++++++selImage: %@\n", selImage);
        
        NSString *key = [NSString stringWithFormat:@"%ld", sender.tag-RealBase_Tag];
        [self.selImgMuDic setValue:selImage forKey:key];
        
        UIImageView *imgView = (UIImageView*)[self.containerView viewWithTag:sender.tag];
        imgView.image = selImage;
        
        sender.selected = !sender.selected;
    }];
}


- (void)referAction
{
    NSLog(@"提交认证");
    
    if (![self judgmentOfLegality]) return;
    
    //因上传图片返回数组顺序与传入顺序相同，为区分证件照而排序（升序）
    NSArray *keyArr = [self.selImgMuDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:3];
    for (NSString *idx in keyArr) {
        [imageArr addObject:self.selImgMuDic[idx]];
    }
    
    //1. 上传照片
    [MBProgressHUD showLoadingText:@"提交中..." toContainer:nil];
    [JYMineService uploadImage:imageArr completion:^(id result, id error) {
        NSLog(@"图片上传成功");
        
        NSArray *imgArr = (NSArray *)result;
    //2. 提交认证资料
        [JYMineService userAuthenticationWithProviceId:countryId type:papersTypeId name:self.paperNameCell.ys_text idNumber:self.paperNumCell.ys_text certificatesA:[(JYImageModel *)imgArr[0] viewPath] certificatesB:[(JYImageModel *)imgArr[1] viewPath] certificatesAB:[(JYImageModel *)imgArr[2] viewPath] completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"正在审核" toContainer:nil];
            [self.navigationController popViewControllerAnimated:YES];
            !_setUpSuccessBlock?:_setUpSuccessBlock();
            
        }];
    }];
}


//判断合法性
- (BOOL)judgmentOfLegality
{
    BOOL isLegal = YES;
    NSString *message = nil;
    
    if ([_cityCell.ys_contentLabel.text isEqualToString:@"请选择"]) {
        isLegal = NO;
        message = @"请选择国家及地区";
    }
    else if (isLegal && [_cityCell.ys_contentLabel.text isEqualToString:@"请选择"]) {
        isLegal = NO;
        message = @"请选择证件类型";
    }
    else if (isLegal && _paperNameCell.ys_text.length==0) {
        isLegal = NO;
        message = @"请填写证件上的姓名";
    }
    else if (isLegal && _paperNumCell.ys_text.length==0) {
        isLegal = NO;
        message = @"请填写证件号码";
    }
    else if (isLegal && (self.selImgMuDic.count!=3)) {
        if (self.selImgMuDic.count==0) {
            isLegal = NO;
            message = @"请上传证件照";
        }
        else{
            NSArray *keyArr = self.selImgMuDic.allKeys;
            if (![keyArr containsObject:@"0"]) {
                isLegal = NO;
                message = @"请上传证件正面照";
            }
            else if (![keyArr containsObject:@"1"]){
                isLegal = NO;
                message = @"请上传证件背面照";
            }
            else if (![keyArr containsObject:@"2"]){
                isLegal = NO;
                message = @"请上传手持证件照";
            }
        }
    }

    if (!isLegal) [MBProgressHUD showText:message toContainer:nil];
    
    return isLegal;
}

@end
