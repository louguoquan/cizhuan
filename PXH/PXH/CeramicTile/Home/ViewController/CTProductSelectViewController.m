//
//  CTProductSelectViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductSelectViewController.h"
#import "CTProductSelectSubViewContrroller.h"

@interface CTProductSelectViewController ()

@end

@implementation CTProductSelectViewController


- (NSArray<NSString *> *)titles{
    return @[@"全部", @"室内地砖", @"内墙砖",@"外墙砖",@"室外地砖"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    return [[CTProductSelectSubViewContrroller alloc]init];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    
    return CGRectMake(0,0, kScreenWidth, 40);
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    
    return CGRectMake(0, 40, kScreenWidth, kScreenHeight-40);
    
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
