//
//  SDShareView.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/18.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "SDShareView.h"
//#import <UMSocialCore/UMSocialCore.h>

@interface SDShareView()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *shareView;

@end

const CGFloat cancelViewHeight = 50.f;
const CGFloat separateViewHeight = 1.f;
const CGFloat   animationDuration     =0.5;


@implementation SDShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        [self addSubview:self.shareView];
        
    }
    return self;
}


- (UIView *)shareView
{
    if (!_shareView) {
        NSArray *shareName =@[@"微信",@"朋友圈"];
        NSArray *shareImage = @[@"wechat", @"circle"];
        CGFloat shareViewHeight = 120 + cancelViewHeight + separateViewHeight;
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - shareViewHeight, ScreenWidth, shareViewHeight)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        
        for (int i = 0; i < shareName.count; i++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth / shareImage.count * i, 0, ScreenWidth / shareImage.count, 120)];
            view.userInteractionEnabled = YES;
            [_shareView addSubview:view];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(CGRectGetWidth(view.frame) / 2 - 30, 20, 60, 60);
            button.tag = i;
            [button setBackgroundImage:[UIImage imageNamed:shareImage[i]] forState:0];
            [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            UILabel *namelabel = [UILabel new];
            namelabel.frame = CGRectMake(0, CGRectGetMaxY(button.frame) + 5, CGRectGetWidth(view.frame), 20);
            namelabel.font = [UIFont systemFontOfSize:14];
            namelabel.textAlignment = NSTextAlignmentCenter;
            namelabel.text = shareName[i];
            [view addSubview:namelabel];
        }
        
        UIView *separateView =[[UIView alloc]initWithFrame:CGRectMake(0, 120, ScreenWidth, separateViewHeight)];
        separateView.backgroundColor = [UIColor grayColor];
        [_shareView addSubview:separateView];
        
        UIButton *cancelButton =[UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0,CGRectGetMaxY(separateView.frame), ScreenWidth, cancelViewHeight);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:cancelButton];
    }
    return _shareView;
}

- (void)shareAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSInteger platFormType;
//    if (button.tag == 0) {
//        platFormType = UMSocialPlatformType_WechatSession;
//    } else {
//        platFormType = UMSocialPlatformType_WechatTimeLine;
//    }

    self.selectPlatForm(platFormType);
}


- (void)cancelAction:(UIButton *)sender
{
    self.cancel();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.cancel();
}



@end
