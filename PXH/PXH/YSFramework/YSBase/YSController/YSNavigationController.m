//
//  YSNavigationController.m
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSNavigationController.h"

#import "UIBarButtonItem+Sunday.h"

@interface YSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationBar.translucent = NO;

//    [[UINavigationBar appearance]setTintColor:DKColorPickerWithKey(NAVBG)];
    
    
    self.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(NAVBG);

//    [[UINavigationBar appearance]setTintColor:HEX_COLOR(@"#0A2B53")];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count > 1) {
        return YES;
    } else {
        return NO;
    }
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
