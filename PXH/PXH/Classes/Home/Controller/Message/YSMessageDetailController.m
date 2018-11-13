//
//  YSMessageDetailController.m
//  PXH
//
//  Created by futurearn on 2018/3/31.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSMessageDetailController.h"

@interface YSMessageDetailController ()

@property (nonatomic, strong) UILabel *message;

@end

@implementation YSMessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatMessageView];
    
    // Do any additional setup after loading the view.
}

- (void)setInfoMessage:(YSMessage *)infoMessage
{
    _infoMessage = infoMessage;
}

- (void)creatMessageView
{
    self.message = [UILabel new];
    _message.font = [UIFont systemFontOfSize:15];
    _message.numberOfLines = 0;
    _message.textColor = HEX_COLOR(@"#333333");
    _message.text = _infoMessage.message;
    [self.view addSubview:_message];
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(15);
        make.right.offset(-15);
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
