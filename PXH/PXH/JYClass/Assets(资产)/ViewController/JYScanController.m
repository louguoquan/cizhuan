//
//  JYScanController.m
//  PXH
//
//  Created by LX on 2018/6/4.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYScanController.h"

#import "JYCameraTopView.h"

@interface JYScanController ()<DCScanBackDelegate>

@property (nonatomic, strong) JYCameraTopView *cameraTopView;

@end

@implementation JYScanController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpTopView];
    
//    [self setUpBottomView];
}

- (void)setUpBase
{
    self.scanDelegate = self;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 导航栏处理
- (void)setUpTopView
{
    _cameraTopView = [[JYCameraTopView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight)];
    [self.view addSubview:_cameraTopView];
    WS(weakSelf)
    _cameraTopView.leftItemClickBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    _cameraTopView.rightItemClickBlock = ^{
        [weakSelf flashButtonClick:weakSelf.flashButton];
    };
    
    _cameraTopView.rightRItemClickBlock = ^{
        [weakSelf jumpPhotoAlbum];
    };
}

- (void)setUpBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.frame = CGRectMake(0, kScreenHeight-kNavigationBarHeight-kStatusBarHeight, kScreenWidth, 50);
    UILabel *supLabel = [UILabel new];
    
    supLabel.text = @"支持扫描";
    supLabel.font = self.tipLabel.font;
    supLabel.textAlignment = NSTextAlignmentCenter;
    supLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    supLabel.frame = CGRectMake(0, 0, kScreenWidth, 20);
    [bottomView addSubview:supLabel];
    
    NSArray *titles = @[@"快递单",@"物价码",@"二维码"];
    NSArray *images = @[@"",@"",@""];
    CGFloat btnW = (kScreenWidth - 80) / titles.count;
    CGFloat btnH = bottomView.height - supLabel.y - 5;
    CGFloat btnX;
    CGFloat btnY = supLabel.frame.size.height + supLabel.frame.origin.y + 5;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:HEX_COLOR(@"#F5F5F5") forState:0];
        btnX = 40 + (i * btnW);
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [bottomView addSubview:button];
    }
    
    [self.view addSubview:bottomView];
}

#pragma mark - <DCScanBackDelegate>
- (void)DCScanningSucessBackWithInfor:(NSString *)message
{
    NSLog(@"扫描结果：%@", message);
    
    !_scanResultBlock?:_scanResultBlock(message);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
