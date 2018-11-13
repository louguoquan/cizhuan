//
//  JJRegistNextViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJRegistNextViewController.h"
#import "CodeView.h"
#import "JJSetPasswordViewController.h"


@interface JJRegistNextViewController ()

@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic,strong)UILabel *mobileLabel;
@property (nonatomic,strong)UILabel *codeLabel;

@property (nonatomic,strong)NSString *codeStr;

@end

@implementation JJRegistNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.view endEditing:YES];
    
    
    [self.containerView addSubview: self.messageLabel];
    [self.containerView addSubview: self.mobileLabel];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.containerView).offset(20);
        make.right.equalTo(self.containerView).offset(-20);
        make.height.greaterThanOrEqualTo(@20);
    }];
    self.messageLabel.numberOfLines = 0;
    [self.messageLabel sizeToFit];
    
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
        make.height.mas_offset(15);
    }];
    
    
    
    CodeView *verView = [[CodeView alloc] initWithFrame:CGRectMake(20, 65+30, kScreenWidth-40, 60)
                                                    num:6
                                              lineColor:GoldColor
                                               textFont:50];
    //下划线
    verView.hasUnderLine = YES;
    //分割线
    verView.hasSpaceLine = NO;
    
    //输入风格
    verView.codeType = CodeViewTypeCustom;
    
    verView.EndEditBlcok = ^(NSString *str) {
        NSLog(@"%@",str);
        self.codeStr = str;
    };
    [self.containerView addSubview:verView];
    
    
    [self setUpNav];
    
    
    [self getNumBtnAction];
    
    
    
    [self.containerView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verView.mas_bottom).offset(20);
        make.left.equalTo(self.messageLabel);
        make.height.mas_offset(30);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 2.f;
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = GoldColor;
    [self.containerView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLabel.mas_bottom).offset(30);
        make.left.equalTo(self.containerView).offset(10);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.containerView).offset(-10);
    }];
    
    
    if ([self.type isEqualToString:@"4"]) {
        _messageLabel.text = @"我们已经发送了验证码到您的手机";
        _mobileLabel.text = self.mobileOrEmail;
    }else if([self.type isEqualToString:@"5"]){
        _messageLabel.text = [NSString stringWithFormat:@"已经发送验证码到您的%@邮箱,请输入邮箱验证码",self.mobileOrEmail];
        _mobileLabel.text = @"若未收到邮件，请检查邮箱垃圾箱";
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.codeLabel.userInteractionEnabled = NO;
    [self.codeLabel addGestureRecognizer:tap];
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    
    if (self.isResetPwd) {
        
        
        //忘记密码
        [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
        //发送手机验证码
        [JJLoginService requestMobileCodeSend:self.mobileOrEmail type:@"1" category:@"1" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            [self getNumBtnAction];
            
            
        }];
        
    }else{
        
        //注册
        [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
        //发送手机验证码
        [JJLoginService requestMobileCodeSend:self.mobileOrEmail type:@"0" category:@"1" Completion:^(id result, id error) {
            
            [MBProgressHUD showText:@"验证码已发送" toContainer:[UIApplication sharedApplication].keyWindow];
            [self getNumBtnAction];
            
            
        }];
    }
    
    
    
}

- (void)nextStep:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.codeStr.length == 0) {
            [MBProgressHUD showText:@"请输入验证码" toContainer:self.view];
            return;
        }
        
        
        [MBProgressHUD showLoadingToContainer:[UIApplication sharedApplication].keyWindow];
        [JJLoginService requestMobileMemberCheckCode:self.mobileOrEmail identifyingCode:self.codeStr type:self.isResetPwd?@"1":@"0" Completion:^(id result, id error) {
            
            [MBProgressHUD dismissForContainer:[UIApplication sharedApplication].keyWindow];
            
            if ([self.type isEqualToString:@"4"]) {
                //         @"手机注册" ;
                JJSetPasswordViewController  *vc = [[JJSetPasswordViewController alloc]init];
                vc.isResetPwd = self.isResetPwd;
                vc.type = self.type;
                vc.mobileOrEmail = self.mobileOrEmail;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([self.type isEqualToString:@"5"]){
                //    @"邮箱注册";
                
                JJSetPasswordViewController  *vc = [[JJSetPasswordViewController alloc]init];
                vc.isResetPwd = self.isResetPwd;
                vc.type = self.type;
                vc.hidesBottomBarWhenPushed = YES;
                vc.mobileOrEmail = self.mobileOrEmail;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }];
        
        
    });
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"填写验证码" ;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
}


- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textColor = HEX_COLOR(@"#333333");
        _messageLabel.text = @"我们已经发送了验证码到您的手机";
        _messageLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _messageLabel;
}

- (UILabel *)mobileLabel
{
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.textColor = HEX_COLOR(@"666666");
        _mobileLabel.text = @"15757836166";
        _mobileLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _mobileLabel;
}

- (UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textColor = HEX_COLOR(@"666666");
        _codeLabel.text = @"60秒后重新发送";
        _codeLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _codeLabel;
}

- (void)getNumBtnAction{
    
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                
                self.codeLabel.text = [NSString stringWithFormat:@"%ld秒后重新发送",second];
                self.codeLabel.userInteractionEnabled = NO;
                self.codeLabel.backgroundColor = [UIColor whiteColor];
                self.codeLabel.textColor = HEX_COLOR(@"666666");
                second--;
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                self.codeLabel.text = @"重新获取验证码";
                self.codeLabel.userInteractionEnabled = YES;
                self.codeLabel.backgroundColor = GoldColor;
                self.codeLabel.textColor = [UIColor whiteColor];
                
                
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    
    
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
