//
//  JJChangeNickNameViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/14.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJChangeNickNameViewController.h"

@interface JJChangeNickNameViewController ()

@end

@implementation JJChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setupUI];
}
- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"修改昵称";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}
- (void)setupUI{
    self.view.backgroundColor  = [UIColor sd_colorWithHexString:@"f8f4f8"];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(saveBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).mas_equalTo(0);
        make.width.mas_equalTo(self.view.width);
        make.height.mas_equalTo(50);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).mas_equalTo(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.width - 30);
        make.height.mas_equalTo(40);
    }];
    
    {
        UILabel *nickLabel = [UILabel new];
        nickLabel.text     = @"昵称";
        nickLabel.font     = [UIFont systemFontOfSize:15];
        [view addSubview:nickLabel];
        
        UITextField *textField = [UITextField new];
        textField.placeholder  = @"单行输入";
        textField.font         = [UIFont systemFontOfSize:15];
        [view addSubview:textField];
        
        [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.left.equalTo(view).mas_equalTo(30);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(30);
        }];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.left.equalTo(nickLabel.mas_right).mas_equalTo(10);
            make.right.equalTo(view).mas_equalTo(-30);
            make.height.mas_equalTo(30);
        }];
    }
    
}
- (void)saveBtnEvent{
    [self.navigationController popViewControllerAnimated:YES];
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
