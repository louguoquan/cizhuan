//
//  JJSettledViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/14.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJSettledViewController.h"

@interface JJSettledViewController ()

@end

@implementation JJSettledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setupUI];
}
- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"企业入驻";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}
- (void)setupUI{
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    
    UIView *nameView = [self setupTextView:@"姓名"];
    UIView *phoneView = [self setupTextView:@"电话"];
    
    UILabel *desLabel = [UILabel new];
    desLabel.text     = @"PS:工作人员会在3个工作日内联系您，请注意接听来电!";
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font     = [UIFont systemFontOfSize:15];
    desLabel.numberOfLines = 0;
    [self.view addSubview:desLabel];
    
    UIButton *settledBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settledBtn.backgroundColor = [UIColor blueColor];
    [settledBtn setTitle:@"立即入驻" forState:UIControlStateNormal];
    [self.view addSubview:settledBtn];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_centerY).mas_equalTo(60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.width - 20);
        make.height.mas_equalTo(50);
    }];
    
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).mas_equalTo(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.width - 20);
        make.height.mas_equalTo(50);
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.view).mas_equalTo(10);
        make.right.equalTo(self.view).mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    [settledBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.view).mas_equalTo(10);
        make.right.equalTo(self.view).mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
}
- (UIView *)setupTextView:(NSString *)name{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label = [UILabel new];
    label.text     = name;
    label.font     = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UITextField *textField = [UITextField new];
    [view addSubview:textField];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.equalTo(view).mas_equalTo(20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.equalTo(label.mas_right).mas_equalTo(10);
        make.right.equalTo(view).mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    return view;
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
