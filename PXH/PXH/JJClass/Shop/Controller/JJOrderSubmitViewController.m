//
//  JJOrderSubmitViewController.m
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJOrderSubmitViewController.h"
#import "JJShopService.h"

@interface JJOrderSubmitViewController ()

@property (nonatomic,strong)UILabel *goodNameLabel;

@property (nonatomic,strong)UILabel *goodCountLabel;

@property (nonatomic,strong)UILabel *goodTotalCountLabel;

@property (nonatomic,strong)UILabel *goodTotalCountLabel1;

@property (nonatomic,strong)UILabel *payLabel;

@property (nonatomic,strong)UITextField *pwdCell;

@property (nonatomic,strong)UITextField *codeCell;

@property (nonatomic,strong)UIButton *submitBtn;

@property (nonatomic,strong)UILabel *codeLabel;



@end

@implementation JJOrderSubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self setUpNav];
    [self isSetPayPwd];
}

- (void)isSetPayPwd{
    
    [JJMineService JJMobileMemberJudgePasswordJDGCompletion:^(id result, id error) {
        if (error) {
            SDError *err = error;
            [MBProgressHUD showErrorMessage:err.errorMessage toContainer:[UIApplication sharedApplication].keyWindow];
        }
    }];
    
}

- (void)setUI{
    
    [self.containerView addSubview:self.goodNameLabel];
    [self.containerView addSubview:self.goodCountLabel];
    [self.containerView addSubview:self.goodTotalCountLabel];
    [self.containerView addSubview:self.payLabel];
    [self.containerView addSubview:self.submitBtn];
    [self.containerView addSubview:self.goodTotalCountLabel1];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"购买物品";
    label.textColor = HEX_COLOR(@"#333333");
    label.font = [UIFont systemFontOfSize:20];
    [self.containerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(15);
        make.top.equalTo(self.containerView).offset(15);
        make.height.mas_offset(25);
    }];
    
    
    [self.goodNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.height.mas_offset(25);
        make.width.mas_offset(120);
    }];
    
    [self.goodCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLabel.mas_right).offset(10);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(25);
    }];
    
    [self.goodTotalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodNameLabel);
        make.top.equalTo(self.goodCountLabel.mas_bottom).offset(5);
//        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(25);
    }];
    
    [self.goodTotalCountLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodTotalCountLabel.mas_right);
        make.top.equalTo(self.goodCountLabel.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(25);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#EAEAEA");
    [self.containerView addSubview:line];
    [line  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.goodTotalCountLabel.mas_bottom).offset(5);
        make.height.mas_offset(1);
    }];
    
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodTotalCountLabel);
        make.top.equalTo(line.mas_bottom).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(25);
    }];
    
    
    self.pwdCell = [[UITextField alloc] init];
    self.pwdCell.font = [UIFont systemFontOfSize:18];
    self.pwdCell.placeholder = @"请输入密码";
    self.pwdCell.layer.borderColor = GoldColor.CGColor;
    self.pwdCell.layer.borderWidth = 0.5f;
    self.pwdCell.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdCell.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pwdCell.textColor = HEX_COLOR(@"#333333");
    self.pwdCell.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.pwdCell];
    [self.pwdCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payLabel.mas_bottom).offset(10);
        make.left.offset(15.f);
        make.right.offset(-15.f);
        make.height.mas_equalTo(40);
    }];
    
    
    self.codeCell = [[UITextField alloc] init];
    self.codeCell.font = [UIFont systemFontOfSize:18];
    self.codeCell.placeholder = @"请输入验证码";
    self.codeCell.layer.borderColor = GoldColor.CGColor;
    self.codeCell.layer.borderWidth = 0.5f;
    self.codeCell.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeCell.autocorrectionType = UITextAutocorrectionTypeNo;
    self.codeCell.textColor = HEX_COLOR(@"#333333");
    self.codeCell.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.codeCell];
    [self.codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdCell.mas_bottom).offset(10);
        make.left.equalTo(self.containerView).offset(15.f);
        make.right.equalTo(self.containerView).offset(-120.f);
        make.height.mas_equalTo(40);
    }];
    
    
    [self.containerView addSubview:self.codeLabel];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeCell.mas_right).offset(5);
        make.right.equalTo(self.containerView).offset(-15);
        make.height.mas_offset(40);
        make.top.equalTo(self.codeCell);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeCell.mas_bottom).offset(20);
        make.left.equalTo(self.containerView).offset(15.f);
        make.right.equalTo(self.containerView).offset(-15.f);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.containerView);
    }];
    
    
    
    
    self.goodNameLabel.text = self.model.productName;
    self.goodCountLabel.text = [NSString stringWithFormat:@"x%@ (赠送:%@)",self.model.countNum,self.model.sendGift];
    self.goodTotalCountLabel.text = [NSString stringWithFormat:@"本期总数量%@台",self.model.product.total];
    self.goodTotalCountLabel1.text = [NSString stringWithFormat:@"剩余数量%@台",self.model.remain];
    self.payLabel.text = [NSString stringWithFormat:@"需支付USDT%@ (可用USDT:%@)",self.model.countPrice,self.model.balance];
    
    
    
}

- (void)submit:(UIButton *)btn{
    
    if (self.pwdCell.text.length == 0) {
        return [MBProgressHUD showText:@"请输入交易密码" toContainer:self.view];
    }
    
    if (self.codeCell.text.length == 0) {
         return [MBProgressHUD showText:@"请输入验证码" toContainer:self.view];
    }
    
    [JJShopService JJMobileCartCreateOrder:self.model.product.ID num:self.model.countNum payPwd:self.pwdCell.text msgCode:self.codeCell.text Completion:^(id result, id error) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        [MBProgressHUD showText:@"订单成功" toContainer:[UIApplication sharedApplication].keyWindow];
        
    }];
    
    
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"订单支付";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    //    UIButton *selectBtn = [[UIButton alloc]init];
    //    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    //    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    //    self.navigationItem.rightBarButtonItem = rightItem;
    //    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    //    [selectBtn setTitle:@"全部已读" forState:UIControlStateNormal];
    //    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (UILabel *)goodNameLabel{
    if (!_goodNameLabel) {
        _goodNameLabel = [[UILabel alloc]init];
        _goodNameLabel.textAlignment = NSTextAlignmentCenter;
        _goodNameLabel.textColor = HEX_COLOR(@"#333333");
        _goodNameLabel.font = [UIFont systemFontOfSize:18];
        _goodNameLabel.layer.borderColor = GoldColor.CGColor;
        _goodNameLabel.layer.borderWidth = 0.5f;
    }
    return _goodNameLabel;
}

- (UILabel *)goodCountLabel{
    if (!_goodCountLabel) {
        _goodCountLabel = [[UILabel alloc]init];
        _goodCountLabel.textAlignment = NSTextAlignmentLeft;
        _goodCountLabel.textColor = HEX_COLOR(@"#333333");
        _goodCountLabel.font = [UIFont systemFontOfSize:18];
    }
    return _goodCountLabel;
}

- (UILabel *)goodTotalCountLabel{
    if (!_goodTotalCountLabel) {
        _goodTotalCountLabel = [[UILabel alloc]init];
        _goodTotalCountLabel.textAlignment = NSTextAlignmentLeft;
        _goodTotalCountLabel.textColor = HEX_COLOR(@"#333333");
        _goodTotalCountLabel.font = [UIFont systemFontOfSize:18];
    }
    return _goodTotalCountLabel;
}

- (UILabel *)goodTotalCountLabel1{
    if (!_goodTotalCountLabel1) {
        _goodTotalCountLabel1 = [[UILabel alloc]init];
        _goodTotalCountLabel1.textAlignment = NSTextAlignmentLeft;
        _goodTotalCountLabel1.textColor = GoldColor;
        _goodTotalCountLabel1.font = [UIFont systemFontOfSize:18];
    }
    return _goodTotalCountLabel1;
}


- (UILabel *)payLabel{
    if (!_payLabel) {
        _payLabel = [[UILabel alloc]init];
        _payLabel.textAlignment = NSTextAlignmentLeft;
        _payLabel.textColor = HEX_COLOR(@"#333333");
        _payLabel.font = [UIFont systemFontOfSize:18];
    }
    return _payLabel;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}


- (UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textColor = GoldColor;
        _codeLabel.layer.borderWidth = 0.5f;
        _codeLabel.layer.borderColor = GoldColor.CGColor;
        _codeLabel.text = @"获取验证码";
        _codeLabel.textAlignment = NSTextAlignmentCenter;
        _codeLabel.font = [UIFont systemFontOfSize:14];
        _codeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
            
            
            [JJLoginService requestMobileCodeSend:[YSAccount sharedAccount].mobile type:@"5" category:@"1" Completion:^(id result, id error) {
                [MBProgressHUD showSuccessMessage:@"验证码已发送,请注意查收" toContainer:nil];
                [self getNumBtnAction];
                
            }];
      
          
        }];
        [_codeLabel addGestureRecognizer:tap];
        
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
                
                self.codeLabel.text = [NSString stringWithFormat:@"%lds",second];
                self.codeLabel.userInteractionEnabled = NO;
                self.codeLabel.backgroundColor = [UIColor lightGrayColor];
                self.codeLabel.textColor = HEX_COLOR(@"ffffff");
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
