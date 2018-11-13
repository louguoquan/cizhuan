//
//  JYChargeViewController.m
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYChargeViewController.h"
//#import "JYCurrencyBriefController.h"
#import "JYContactSynopsisController.h"
#import "JYWebController.h"
#import "JYRecordController.h"

#import "JYRechargeNoticeView.h"

#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAssetChangeRequest.h>

#import <KSPhotoBrowser/KSPhotoBrowser.h>
#import <CoreImage/CoreImage.h>

#import "JYAssetsService.h"

@interface JYChargeViewController ()
{
    NSString        *noticeContent;
}

@property (nonatomic, strong) UILabel           *doCoinLab;
@property (nonatomic, strong) UILabel           *frostCoinLab;

@property (nonatomic, strong) UIImageView       *QRImgView;
@property (nonatomic, strong) UILabel           *showAddressLab;
@property (nonatomic, strong) UIButton          *cloneAddBtn;
@property (nonatomic, strong) UIButton          *saveQRBtn;
@property (nonatomic, strong) UILabel           *promptLab;

@property (nonatomic, strong) UIView            *lastView;

@property (nonatomic, strong) JYRechargeNoticeView *noticeView;

@property (nonatomic, copy) NSString            *navTitle;
@property (nonatomic, strong) JYCoinInfoModel   *coinModel;

@end

static NSString *faileAdd = @"获取地址失败";

@implementation JYChargeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
    [self.noticeView show];
    
    [self getCoinInfo:NO];
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = [self.navTitle stringByAppendingString:@"充币"];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"充币记录" forState:UIControlStateNormal];
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel sizeToFit];
    [btn addTarget:self action:@selector(seeChargeRecordAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);

    [self creatCoinStatusView];
    
    [self creatRechargeInfoView];
    
    [self cretCellView:@"币种简介" rightImage:[UIImage imageNamed:@"return"] action:@selector(coinTypeSynAction)];
    
//    [self cretCellView:@"充币须知" rightImage:nil action:@selector(rechargeCoinNoticeAction)];
    
    [self creatNoticeView];
    
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0.f);
    }];
}

- (void)creatCoinStatusView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    [self.containerView addSubview:bgView];
    
    [bgView addSubview:self.doCoinLab];
    [bgView addSubview:self.frostCoinLab];
    
    [self.doCoinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(bgView);
        make.left.mas_equalTo(10.f);
    }];
    
    [self.frostCoinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.doCoinLab);
        make.left.equalTo(self.doCoinLab.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-10);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(44.f);
    }];
    
    _lastView = bgView;
}

- (void)creatRechargeInfoView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    [self.containerView addSubview:bgView];
    
    [bgView addSubview:self.QRImgView];
    [bgView addSubview:self.showAddressLab];
    [bgView addSubview:self.cloneAddBtn];
    [bgView addSubview:self.saveQRBtn];
    [bgView addSubview:self.promptLab];
    
    
    [self.QRImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25.f);
        make.centerX.equalTo(bgView);
        make.height.width.mas_equalTo(100.f);
    }];
    
    [self.showAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QRImgView.mas_bottom).mas_offset(17.f);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
    }];
    
    [self.cloneAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showAddressLab.mas_bottom).mas_offset(25.f);
        make.centerX.equalTo(bgView);
        make.width.equalTo(bgView).multipliedBy(0.5f);
        make.height.mas_equalTo(45.f);
    }];
    
    [self.saveQRBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cloneAddBtn.mas_bottom).mas_offset(10.f);
        make.width.height.centerX.equalTo(self.cloneAddBtn);
    }];
    
    [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.saveQRBtn.mas_bottom).mas_offset(15.f);
        make.centerX.equalTo(bgView);
        make.left.mas_equalTo(10.f);
        make.bottom.mas_equalTo(-30.f);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lastView.mas_bottom).mas_offset(10.f);
        make.left.right.equalTo(self.containerView);
    }];
    
    _lastView = bgView;
}

- (UIView *)cretCellView:(NSString *)leftTitle rightImage:(UIImage *)image action:(nullable SEL)action
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
        make.top.equalTo(_lastView.mas_bottom).mas_offset(10.f);
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

//MARK: -- 查看充币记录
- (void)seeChargeRecordAction
{
    JYRecordController *vc = [[JYRecordController alloc] init];
    vc.type = RecordType_Recharge;
    vc.coinId = self.asModel.coinTypeId;
    vc.coinCode = self.asModel.coinCode;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cloneAddressAction
{
    NSLog(@"复制充值地址");
    
    if ([self.showAddressLab.text isEqualToString:faileAdd]) {
        [MBProgressHUD showText:faileAdd toContainer:nil];
        return;
    }

    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.showAddressLab.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)saveQRCodeAction
{
    NSLog(@"保存二维码");
    
    if ([self.showAddressLab.text isEqualToString:faileAdd]) {
        [MBProgressHUD showText:faileAdd toContainer:nil];
        return;
    }
    
    // 保存图片到相册中
//    UIImageWriteToSavedPhotosAlbum(img, self, nil, nil);
    
    //从网络下载图片
//    NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://image.baidu.com/search/down?tn=download&ipn=dwnl&word=download&ie=utf8&fr=result&url=http%3A%2F%2Fimg18.3lian.com%2Fd%2Ffile%2F201709%2F18%2F37f669ed5f962967411b8b583c1954d6.jpg&thumburl=https%3A%2F%2Fss1.bdstatic.com%2F70cFvXSh_Q1YnxGkpoWK1HF6hhy%2Fit%2Fu%3D2632437614%2C3914003817%26fm%3D27%26gp%3D0.jpg"]];
//     UIImage *img = [UIImage imageWithData:imgData];
    
    UIImage *img = self.QRImgView.image;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        ///写入图片到相册
        PHAssetChangeRequest *asset = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [MBProgressHUD showSuccessMessage:@"保存成功" toContainer:nil];
            }else{
                [MBProgressHUD showErrorMessage:@"保存失败" toContainer:nil];
            }
        });
    }];
}

- (void)lookUpQRAction
{
    NSLog(@"查看二维码");
    
    if ([self.showAddressLab.text isEqualToString:faileAdd]) {
        [MBProgressHUD showText:faileAdd toContainer:nil];
        return;
    }
    
    KSPhotoItem *item = [KSPhotoItem itemWithSourceView:UIImageView.new image:self.QRImgView.image];
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:@[item] selectedIndex:0];
    [browser showFromViewController:self];
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

//- (void)rechargeCoinNoticeAction
//{
//    NSLog(@"充币须知");
//    //    [self.noticeView show];
//}

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


-(void)setAsModel:(JYAssetsModel *)asModel
{
    _asModel = asModel;
    
    _navTitle = asModel.coinCode;
    
    self.doCoinLab.text = [NSString stringWithFormat:@"可用：%@ %@", asModel.balance, _navTitle];
    
    self.frostCoinLab.text = [NSString stringWithFormat:@"冻结：%@ %@", asModel.freezeBalance, _navTitle];
    
    if (asModel.walletAddress.length) {
        self.showAddressLab.text = asModel.walletAddress;
        self.showAddressLab.textColor = [UIColor blackColor];
       
        self.QRImgView.image = [self createFilter:asModel.walletAddress size:300];
    }
    else {
        self.showAddressLab.text = faileAdd;
        self.showAddressLab.textColor = [UIColor redColor];
    }
    
    noticeContent = [NSString stringWithFormat:@"1.禁止向%@地址充值任何非%@资产，任何充入该地址的其他资产将不可找回。\n2.%@充值需要整个网络进行确认，达到3个确认后会自动充值到您的账户中。\n3.最小接受充值金额是0.001%@，为快速到账，您可以向网络支付少量手续费。\n4.此地址是您唯一切独自使用的充值地址，您可以同时进行多次充值。", _navTitle, _navTitle, _navTitle, _navTitle];
}


//MARK: -- 生成二维码
- (UIImage *)createFilter:(NSString *)contentStr size:(CGFloat)sizes
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    CIImage *image = [filter outputImage];
    
    // 4. 获取高清二维码
    CGAffineTransform transform = CGAffineTransformMakeScale(10.0f, 10.0f);
    CIImage *output = [image imageByApplyingTransform:transform];
    UIImage *newImage = [UIImage imageWithCIImage:output scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    //修改大小
    if (sizes>0) {
        CGFloat scale = [[UIScreen mainScreen]scale];
        //UIGraphicsBeginImageContext(newSize);
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizes, sizes), NO, scale);
        [newImage drawInRect:CGRectMake(0,0,sizes,sizes)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newImage;
}


-(UILabel *)doCoinLab
{
    if (!_doCoinLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        lab.text = @"可用：0.0000000BTC";
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
        lab.text = @"冻结：0.0000000BTC";
        _frostCoinLab = lab;
    }
    return _frostCoinLab;
}

-(UIImageView *)QRImgView
{
    if (!_QRImgView) {
        _QRImgView = [[UIImageView alloc] init];
        _QRImgView.contentMode = UIViewContentModeScaleAspectFit;
        _QRImgView.userInteractionEnabled = YES;
        _QRImgView.backgroundColor = [UIColor redColor];
//        _QRImgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookUpQRAction)];
        [_QRImgView addGestureRecognizer:tap];
    }
    return _QRImgView;
}

-(UILabel *)showAddressLab
{
    if (!_showAddressLab) {
        _showAddressLab = [[UILabel alloc] init];
        _showAddressLab.font = [UIFont systemFontOfSize:14.f];
        _showAddressLab.textAlignment = NSTextAlignmentCenter;
    }
    return _showAddressLab;
}

-(UIButton *)cloneAddBtn
{
    if (!_cloneAddBtn) {
        _cloneAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cloneAddBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_cloneAddBtn setTitle:@"复制充币地址" forState:0];
        [_cloneAddBtn addTarget:self action:@selector(cloneAddressAction) forControlEvents:UIControlEventTouchUpInside];
        _cloneAddBtn.layer.cornerRadius = 3.f;
        _cloneAddBtn.layer.masksToBounds = YES;
        [_cloneAddBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVTEXT) forState:0];
        _cloneAddBtn.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    }
    return _cloneAddBtn;
}

-(UIButton *)saveQRBtn
{
    if (!_saveQRBtn) {
        _saveQRBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveQRBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_saveQRBtn setTitle:@"保存二维码" forState:0];
        [_saveQRBtn addTarget:self action:@selector(saveQRCodeAction) forControlEvents:UIControlEventTouchUpInside];
        _saveQRBtn.layer.cornerRadius = 3.f;
        _saveQRBtn.layer.masksToBounds = YES;
        _saveQRBtn.layer.borderWidth = 1.f;
        _saveQRBtn.layer.dk_borderColorPicker = DKColorPickerWithKey(NAVBG);
        [_saveQRBtn dk_setTitleColorPicker:DKColorPickerWithKey(NAVBG) forState:0];
    }
    return _saveQRBtn;
}

-(UILabel *)promptLab
{
    if (!_promptLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
        lab.text = @"*复制充币地址或保存二维码扫描充币";
        _promptLab = lab;
    }
    return _promptLab;
}

-(JYRechargeNoticeView *)noticeView
{
    BOOL isPrompt = [[NSUserDefaults standardUserDefaults] boolForKey:JYAferForPromptKey];
    if (isPrompt) return nil;
    
    if (!_noticeView) {
        _noticeView = [[JYRechargeNoticeView alloc] initWithNoticeContent:noticeContent];
        _noticeView.animationType = ViewAnimationType_Center;
        _noticeView.afterForPromptBlock = ^(BOOL sel) {
            [[NSUserDefaults standardUserDefaults] setBool:sel forKey:JYAferForPromptKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        };
    }
    return _noticeView;
}

@end
