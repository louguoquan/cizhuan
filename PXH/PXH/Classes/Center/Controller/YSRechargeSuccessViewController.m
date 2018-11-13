//
//  YSRechargeSuccessViewController.m
//  PXH
//
//  Created by yu on 2017/8/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRechargeSuccessViewController.h"

#import "YSMainTabBarViewController.h"

@interface YSRechargeSuccessViewController ()

@end

@implementation YSRechargeSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [array removeObjectAtIndex:array.count - 2];
    [self.navigationController setViewControllers:array animated:YES];
    self.navigationItem.title = @"充值成功";
    
    [self setup];
}

- (void)setup {

    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"recharge_win"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(50);
        make.size.mas_equalTo(imageView.image.size);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:40];
    label.textColor = HEX_COLOR(@"#333333");
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%.2f", _price.doubleValue];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(40);
        make.centerX.offset(0);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.font = [UIFont systemFontOfSize:18];
    label1.textColor = HEX_COLOR(@"#333333");
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"充值成功";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(13);
        make.centerX.offset(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:2 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"去购买" forState:UIControlStateNormal];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        YSMainTabBarViewController *vc = (YSMainTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [vc setSelectedIndex:0];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(label1.mas_bottom).offset(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
