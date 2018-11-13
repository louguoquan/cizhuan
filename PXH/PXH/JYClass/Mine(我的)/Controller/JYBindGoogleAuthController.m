//
//  JYBindGoogleAuthController.m
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBindGoogleAuthController.h"
#import "JYBindGoogleCodeController.h"

@interface JYBindGoogleAuthController ()

@property (nonatomic, strong) UIImageView *codeImgView;
@property (nonatomic, strong) UILabel     *inviteCodeLab;

@end

@implementation JYBindGoogleAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpUI];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    navigationLabel.text = @"绑定谷歌验证";
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpUI
{
    WS(weakSelf);
    
    UILabel *bindTitleLabel = [[UILabel alloc] init];
    bindTitleLabel.textAlignment = NSTextAlignmentCenter;
    bindTitleLabel.font = [UIFont systemFontOfSize:18];
    bindTitleLabel.text = @"绑定谷歌身份验证器";
    [self.view addSubview:bindTitleLabel];
    bindTitleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    [bindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:12];
    promptLabel.text = @"请妥善备份密钥以防丢失";
    [self.view addSubview:promptLabel];
    promptLabel.dk_textColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bindTitleLabel.mas_bottom).mas_offset(30.f);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    _codeImgView = [[UIImageView alloc] init];
    _codeImgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_codeImgView];
    [_codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.mas_bottom).mas_offset(25.f);
        make.centerX.equalTo(weakSelf.view);
        make.width.height.mas_equalTo(100.f);
    }];
    
    _inviteCodeLab = [[UILabel alloc] init];
    _inviteCodeLab.textAlignment = NSTextAlignmentCenter;
    _inviteCodeLab.font = [UIFont systemFontOfSize:13.f];
    _inviteCodeLab.userInteractionEnabled = YES;
    _inviteCodeLab.text = @"KLGMGFMGGFT 复制";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyContentAction)];
    [_inviteCodeLab addGestureRecognizer:tap];
    _inviteCodeLab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    [self.view addSubview:_inviteCodeLab];
    [_inviteCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeImgView.mas_bottom).mas_offset(20.f);
        make.centerX.equalTo(weakSelf.view);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *invitePromptlab = [[UILabel alloc] init];
    invitePromptlab.textAlignment = NSTextAlignmentCenter;
    invitePromptlab.font = [UIFont systemFontOfSize:12.f];
    invitePromptlab.numberOfLines = 0;
    invitePromptlab.text = @"保存二维码到手机或复制秘钥到剪切板可能会有安全风险， 请妥善保存";
    invitePromptlab.dk_textColorPicker = DKColorPickerWithKey(LABELTEXT);
    [self.view addSubview:invitePromptlab];
    [invitePromptlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inviteCodeLab.mas_bottom).mas_offset(60.f);
        make.centerX.equalTo(weakSelf.view);
        make.left.offset(15.f);
    }];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.layer.cornerRadius = 1.f;
    nextBtn.layer.masksToBounds = YES;
    nextBtn.dk_backgroundColorPicker = DKColorPickerWithKey(LOGINBUTTONBG);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(invitePromptlab.mas_bottom).offset(30);
        make.left.equalTo(weakSelf.view).mas_offset(15.f);
        make.right.equalTo(weakSelf.view).mas_offset(-15.f);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)copyContentAction
{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        
        pBoard.string = self.inviteCodeLab.text;
        
        [MBProgressHUD showText:@"复制成功!" toContainer:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)nextAction:(UIButton *)sender
{
    NSLog(@"下一步");
    JYBindGoogleCodeController *googleCodeVC = [[JYBindGoogleCodeController alloc] init];
    [self.navigationController pushViewController:googleCodeVC animated:YES];
}

@end
