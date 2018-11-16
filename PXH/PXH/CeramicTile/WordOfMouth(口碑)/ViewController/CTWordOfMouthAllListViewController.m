//
//  CTWordOfMouthAllListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTWordOfMouthAllListViewController.h"
#import "CTWordOfMouthListSubViewController.h"


@interface CTWordOfMouthAllListViewController ()

@end

@implementation CTWordOfMouthAllListViewController

- (NSArray<NSString *> *)titles{
    return @[@"综合", @"最满意", @"最不满意",@"防滑性",@"吸水率"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    return [[CTWordOfMouthListSubViewController alloc]init];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    
    return CGRectMake(0, kScreenWidth/4.0f+240, kScreenWidth, 40);
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    
    return CGRectMake(0, kScreenWidth/4.0f+240+40, kScreenWidth, kScreenHeight-10);
    
}

- (void)viewDidLoad {
    //题目的背景栏颜色
    //    self.menuBGColor = [UIColor clearColor];
    //题目的显示效果
    self.menuViewStyle = WMMenuViewStyleLine;
    //题目的高度
    //    self.menuHeight = 45;
    //设置选中文字颜色
    self.titleColorSelected = [UIColor blackColor];
    //设置未选中文字颜色
    self.titleColorNormal = [UIColor grayColor];
    //设置下划线(或者边框)颜色
    self.progressColor = [UIColor blackColor];
    [super viewDidLoad];
    
   
    
    
    
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
