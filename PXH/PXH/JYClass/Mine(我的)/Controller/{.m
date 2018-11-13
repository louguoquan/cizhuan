//
//  JYReceiveBenefitsController.m
//  PXH
//
//  Created by LX on 2018/6/6.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYReceiveBenefitsController.h"

@interface JYReceiveBenefitsController ()

@property (nonatomic, strong) UIImageView   *headimgView;

@property (nonatomic, strong) UILabel       *invCodeLab;

@end

@implementation JYReceiveBenefitsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self setUpBase];
}

- (void)setUpBase
{
    self.invCodeLab.text = @"2714208";
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"领取福利";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    //去掉导航栏底部线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setUpUI
{
    self.scrollView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.containerView addSubview:self.headimgView];
    
    UIView *bgView = [[UIView alloc] init];
    [self.containerView addSubview:bgView];
    bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
    UILabel *invCodeNameLab = [UILabel new];
    invCodeNameLab.text = @"我的邀请码：";
    invCodeNameLab.textAlignment = NSTextAlignmentLeft;
    invCodeNameLab.font = [UIFont systemFontOfSize:15];
    invCodeNameLab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
    
    UIButton *cloneBtn = [[UIButton alloc] init];
    cloneBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [cloneBtn setTitle:@"复制" forState:0];
    [cloneBtn addTarget:self action:@selector(cloneInvCodeAction:) forControlEvents:0];
    cloneBtn.layer.masksToBounds = YES;
    cloneBtn.layer.cornerRadius = 5.f;
    cloneBtn.layer.borderWidth = 2.f;
    cloneBtn.layer.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGStatusBG);
    [cloneBtn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGStatusBG) forState:0];
    
    
    
    
    [bgView addSubview:invCodeNameLab];
    [bgView addSubview:self.invCodeLab];
    [bgView addSubview:cloneBtn];
    
    
    WS(weakSelf)
    [self.headimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(230);
    }];
    
    [invCodeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.height.mas_equalTo(25);
    }];
    
    [self.invCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(invCodeNameLab);
        make.left.equalTo(invCodeNameLab.mas_right);
    }];
    
    [cloneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(invCodeNameLab);
        make.height.mas_equalTo(35);
        make.right.mas_equalTo(10);
        make.width.mas_equalTo(60);
    }];
    
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headimgView.mas_bottom);
        make.bottom.left.right.equalTo(weakSelf.view);
    }];
}

- (UIView *)creatLine:(CGFloat)heights



//Mark: --邀请好友
- (void)invitingFriendsAction
{
    NSLog(@"邀请好友");
}

//Mark: --复制邀请码
- (void)cloneInvCodeAction:(UIButton *)sender
{
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    pastboard.string = self.invCodeLab.text;
    if (pastboard.string.length) {
        [MBProgressHUD showSuccessMessage:@"复制成功" toContainer:nil];
    }
}


-(UIImageView *)headimgView
{
    if (!_headimgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(invitingFriendsAction)];
        [imgView addGestureRecognizer:tap];
        _headimgView = imgView;
        
        imgView.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    }
    
    return _headimgView;
}

-(UILabel *)invCodeLab
{
    if (!_invCodeLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        lab.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
        
        _invCodeLab = lab;
    }
    return _invCodeLab;
}

@end
