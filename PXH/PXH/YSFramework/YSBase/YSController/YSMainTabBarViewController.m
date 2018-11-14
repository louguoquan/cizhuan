//
//  YSMainTabBarViewController.m
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSMainTabBarViewController.h"
#import "YSLifeTableViewController.h"
#import "YSIndexViewController.h"
#import "YSCategoryIndexViewController.h"
#import "YSLifeCircleViewController.h"
#import "YSShoppingCartViewController.h"
#import "YSProfileViewController.h"

#import "JYMineController.h"

#import "YSLoginGuidingViewController.h"
#import "YSProductService.h"

#import "Y_StockChartViewController.h"
#import "JYMarketHomeViewController.h"
#import "JYTradingManagerViewController.h"
#import "JYAssetsHomeViewController.h"

#import "JYLogInController.h"

#import "JJHomeViewController.h"
#import "JJCalculateViewController.h"
#import "JJWalletViewController.h"
//#import "JJNoteListViewController.h"

#import "CTHomeSubViewController.h"
#import "CTWordOfMouthViewController.h"
#import "SelectTableViewController.h"

@interface YSMainTabBarViewController ()

@end

@implementation YSMainTabBarViewController

+ (void)setSelectIndex:(NSInteger)index
{
    UITabBarController *tabbar = (UITabBarController *)[[UIApplication sharedApplication].windows firstObject].rootViewController;
    [tabbar setSelectedIndex:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushLoginVC) name:JYTokenExpiredReLogin object:nil];
    
//    self.tabBar.dk_backgroundColorPicker = DKColorPickerWithKey(BARBG);

    CTHomeSubViewController *category = [[CTHomeSubViewController alloc] init];
    [self addChildViewController:category image:@"jiaoyi" selectedImage:@"jiaoyi_press" title:@"首页"];
    
     CTWordOfMouthViewController *home = [[CTWordOfMouthViewController alloc] init];
    [self addChildViewController:home image:@"hangqing" selectedImage:@"hangqing_press" title:@"口碑"];

    
    JJWalletViewController *circle = [[JJWalletViewController alloc] init];
    [self addChildViewController:circle image:@"zichan" selectedImage:@"zichan_press" title:@"免费设计"];
    
    SelectTableViewController *circle1 = [[SelectTableViewController alloc] init];
    [self addChildViewController:circle1 image:@"zichan" selectedImage:@"zichan_press" title:@"选砖"];
    
    JYMineController *mineVC = [[JYMineController alloc] init];
    [self addChildViewController:mineVC image:@"my" selectedImage:@"my_press" title:@"我的"];
}

- (void)addChildViewController:(UIViewController *)childVc image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title {
    
    childVc.title = title;
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HEX_COLOR(@"#333333");
//    textAttrs[NSForegroundColorAttributeName] = DKColorPickerWithKey(TabBarTEXT);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = HEX_COLOR(@"#9D8B61");
//    selectTextAttrs[NSForegroundColorAttributeName] = DKColorPickerWithKey(TabBarSelTEXT);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    YSNavigationController *nav = [[YSNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}


- (void)pushLoginVC
{
    [JYAccountModel deleteAccount];
    
    UIViewController *currentVC = [self getCurrentVC];
    
    if ([currentVC isKindOfClass:[JYLogInController class]]) return;
    
    JYLogInController *vc = [[JYLogInController alloc] init];
    YSNavigationController *nav = [[YSNavigationController alloc] initWithRootViewController:vc];
    
    [currentVC presentViewController:nav animated:YES completion:nil];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
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
