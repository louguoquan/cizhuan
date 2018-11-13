//
//  YSBaseViewController.m
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseViewController.h"
#import "YSLoginGuidingViewController.h"
#import "YSChangePasswordViewController.h"
#import "YSRechargeViewController.h"
#import "YSTicketViewController.h"

@interface YSBaseViewController ()

@end

@implementation YSBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController.viewControllers containsObject:self]) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(@"#333333")}];
        
        
        self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(NAVBG);
        
        [self.navigationController setNavigationBarHidden:[self prefersNavigationBarHidden] animated:YES];
    
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}


- (void)setNav{
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn.frame =CGRectMake(0, 0, 30, 30);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)back{

    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
}

- (void)setBlock:(PopBackHandler)block
{
    _block = [block copy];
}

    //是否隐藏导航条
- (BOOL)prefersNavigationBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - 登录弹窗
#pragma mark - type : 1 登录 2 : 支付密码  3 余额不足 4 兑换成功 5  是否兑换
/*
    type :
        1 : 登录
        2 : 支付密码
        3 : 余额不足
        4 : 兑换成功
        5 : 是否兑换
        6 : 支付保存状态
 */
- (void)judgeLoginActionWith:(NSInteger)type
{
    NSString *message;
    NSString *confim = @"确定";
    switch (type) {
        case 1:
        {
            message = @"是否需要登录";
        }
            break;
        case 2:
        {
            message = @"是否需要设置支付密码";
        }
            break;
        case 3:
        {
            message = @"账户余额不足, 请更换支付方式";
            confim = @"充值";
        }
            break;
        case 4:
        {
            message = @"兑换成功，是否立即使用？";
            confim = @"去使用";
        }
            break;
        case 5:
        {
            message = @"请问是否需要兑换?";
            
        }
            break;
        case 6:
        {
            message = @"订单会保留15分钟,请尽快支付";
        }
            break;
        case 7:
        {
            message = @"是否使用电子券";
        }
            break;
        default:
            
            break;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:confim style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (type == 1) {
            YSLoginGuidingViewController *login = [YSLoginGuidingViewController new];
            login.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:login animated:YES];
        } else if (type == 2){
            YSChangePasswordViewController *vc = [YSChangePasswordViewController new];
            vc.type = 3;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (type == 3){
            YSRechargeViewController *recharge = [YSRechargeViewController new];
            recharge.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:recharge animated:YES];
        } else if (type == 4){
            YSTicketViewController *tick = [YSTicketViewController new];
            tick.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tick animated:YES];
        } else if (type == 5){
            [[NSNotificationCenter defaultCenter]postNotificationName:@"兑换电子券" object:nil];
        } else if (type == 6){
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"使用电子券" object:nil];
        }
        
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:^{
        
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
