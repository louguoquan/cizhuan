//
//  YSWithDrawController.m
//  PXH
//
//  Created by futurearn on 2018/4/4.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSWithDrawController.h"

@interface YSWithDrawController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property (weak, nonatomic) IBOutlet UITextField *ZFBField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation YSWithDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    //第一个金额
    self.moneyField.leftView = [self creatleftView:@"提现金额 :"];
    self.moneyField.leftViewMode = UITextFieldViewModeAlways;
    self.moneyField.textColor = HexColor(333333);
    self.moneyField.placeholder = [NSString stringWithFormat:@"最多可提现%.2f元", [YSAccount sharedAccount].reward];
    
    
    self.ZFBField.leftView = [self creatleftView:@"支付宝 :"];
    self.ZFBField.leftViewMode = UITextFieldViewModeAlways;
    self.ZFBField.textColor = HexColor(333333);
    
    self.confirmBtn.backgroundColor = MAIN_COLOR;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 5.f;
    
    // Do any additional setup after loading the view from its nib.
}

- (UIView *)creatleftView:(NSString *)title
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    
    UILabel *titleName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(leftView.frame) - 10, CGRectGetHeight(leftView.frame))];
    titleName.font = [UIFont systemFontOfSize:15];
    titleName.text = title;
    [leftView addSubview:titleName];
    return leftView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_moneyField resignFirstResponder];
    [_ZFBField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cashOut:(UIButton *)sender {
    
    if ([self.moneyField.text floatValue] <= 0) {
        [MBProgressHUD showErrorMessage:@"请输入提现金额" toContainer:nil];
        return;
    }
    if ([self.moneyField.text floatValue] >0 &&[self.moneyField.text floatValue]<10) {
        [MBProgressHUD showErrorMessage:@"最低提现额度为10元" toContainer:nil];
        return;
    }
    if ([self.moneyField.text floatValue] > [YSAccount sharedAccount].reward) {
        [MBProgressHUD showErrorMessage:@"可提现金额不足" toContainer:nil];
        return;
    }
    if (self.ZFBField.text == nil) {
        [MBProgressHUD showErrorMessage:@"请输入支付宝账号" toContainer:nil];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"memberId"] = [YSAccount sharedAccount].ID;
    param[@"zfb"] = self.ZFBField.text;
    param[@"money"] = self.moneyField.text;
    
    [[SDDispatchingCenter sharedCenter] POST:@"/mobile/member/withdraw" parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
            [MBProgressHUD showSuccessMessage:@"提现成功，等待管理员审核" toContainer:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *message = responseObject[@"message"];
            [MBProgressHUD showErrorMessage:message toContainer:nil];
        }
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
    NSLog(@"确认提现");
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
