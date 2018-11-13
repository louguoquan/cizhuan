//
//  JYShareView.m
//  PXH
//
//  Created by LX on 2018/6/8.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYShareView.h"

@interface JYShareView ()

@property (nonatomic ,strong) NSMutableArray      *itemTitleMuArr;

@property (nonatomic ,strong) NSMutableArray      *imgMuArr;

@property (nonatomic ,strong) NSMutableArray      *typeMuArr;

@end

static NSInteger ShareBase_Tag = 500;

@implementation JYShareView




-(instancetype)initWithItemTitleArray:(NSArray *)titleArray
                           imageArray:(NSArray *)imgArray
                    PlatformTypeArray:(NSArray *)typeArray
                         selTypeBlock:(SelectTypeBlock)block
{
    self = [super init];
    if (self) {
        self.itemTitleMuArr = [titleArray mutableCopy];
        self.imgMuArr = [imgArray mutableCopy];
        self.typeMuArr = [typeArray mutableCopy];
        self.selBlock = block;
        
        [self isInstallWechetOrQQ];
        
        [self setUpUI];
    }
    return self;
}

/// 判断QQ、Wechat是否安装
- (void)isInstallWechetOrQQ
{
    BOOL isInstallWechet = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL isInstallQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    
    if (!isInstallWechet) [self ifNotInstallWechetOrQQ:1];
    if (!isInstallQQ)     [self ifNotInstallWechetOrQQ:2];
}

/**
 QQ、Wechat未安装

 @param type 1.Wechet、 2.QQ
 */
- (void)ifNotInstallWechetOrQQ:(NSInteger)type
{
    NSArray *arr = (type==1)?@[@(SPlatformType_WechatSession), @(SPlatformType_WechatTimeLine)]:@[@(SPlatformType_QQ), @(SPlatformType_Qzone)];
    
    WS(weakSelf)
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([weakSelf.typeMuArr containsObject:obj]) {
            NSInteger index = [weakSelf.typeMuArr indexOfObject:obj];
            
            [self.itemTitleMuArr removeObjectAtIndex:index];
            [self.imgMuArr removeObjectAtIndex:index];
            [self.typeMuArr removeObjectAtIndex:index];
        }
    }];
}

- (void)setUpUI
{
    __block CGFloat H = 0;
    CGFloat gap = 1;
    CGFloat W = (kScreenWidth-gap*2)/3;

    [_itemTitleMuArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        btn.frame = CGRectMake((W+gap)*(idx%3), idx/3*(W+gap), W, W);//*0.85
        btn.tag = ShareBase_Tag+idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:obj forState:0];
        [btn setImage:[UIImage imageNamed:_imgMuArr[idx]] forState:0];
        [btn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10.f];
        [self addSubview:btn];
        btn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(BUTTONTITLE) forState:0];
        
        H = CGRectGetMaxY(btn.frame)+gap;
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, H, kScreenWidth, 30.f+kStatusBarHeight);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitle:@"取消" forState:0];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    cancelBtn.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    [cancelBtn dk_setTitleColorPicker:DKColorPickerWithKey(BUTTONTITLE) forState:0];

    H = CGRectGetMaxY(cancelBtn.frame);
    
    self.frame = CGRectMake(0, kScreenHeight - H, kScreenWidth, H);
}


- (void)shareAction:(UIButton *)sender
{
    [self hide];
    
    NSInteger idx = sender.tag - ShareBase_Tag;
    
    SPlatformType type = [_typeMuArr[idx] integerValue];
    
    !_selBlock?:_selBlock(idx, type);
}


- (void)cancelAction
{
    [self hide];
}


@end
