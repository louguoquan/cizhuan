//
//  CTHomeSubViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/12.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTHomeSubViewController.h"
#import "CTHomeListViewController.h"
#import "CTHomeHeadView.h"


#import "CTProductSelectViewController.h"
#import "CTPuTieViewController.h"
@interface CTHomeSubViewController ()
    
    @end

@implementation CTHomeSubViewController
    
- (NSArray<NSString *> *)titles{
    return @[@"推荐", @"图文", @"视频"];
}
    
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}
    
    
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    return [[CTHomeListViewController alloc]init];
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
    
    CTHomeHeadView *head = [[CTHomeHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    head.CTHomeHeadViewSetionSelect = ^(NSInteger index) {
        if (index == 0) {
            CTProductSelectViewController *vc = [[CTProductSelectViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index ==1){
            
            CTPuTieViewController *vc = [[CTPuTieViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (index == 2){
            
        }else if (index == 3){
            
        }
        
    };
    [self.view addSubview:head];
    
    
    
    
    //    //左边导航栏
    //    UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    radioBtn.frame = CGRectMake(0, 0, 90, 44);
    //    [radioBtn setImage:[UIImage imageNamed:@"nav_icon_radio"] forState:UIControlStateNormal];
    //    [radioBtn setImage:[UIImage imageNamed:@"nav_icon_radio_p"] forState:UIControlStateHighlighted];
    //    radioBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 45);
    //    [radioBtn setTitle:@"音频" forState:UIControlStateNormal];
    //    //button标题的偏移量，这个偏移量是相对于图片的
    //    radioBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    //不设置 文字不会显示
    //    [radioBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    radioBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    //    UIBarButtonItem *radioItem = [[UIBarButtonItem alloc] initWithCustomView:radioBtn];
    //    //专门修复导航栏中的按钮之间的距离控件(木棍控件)
    //    UIBarButtonItem *leftSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    leftSpaceItem.width = -15;
    //    //leftBarButtonItems 从左向右排列
    //    self.navigationItem.leftBarButtonItems = @[leftSpaceItem, radioItem];
    //    //右边导航栏
    //    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    searchBtn.frame = CGRectMake(0, 0, 45, 44);
    //    [searchBtn setImage:[UIImage imageNamed:@"nav_icon_search"] forState:UIControlStateNormal];
    //    [searchBtn setImage:[UIImage imageNamed:@"nav_icon_search_p"] forState:UIControlStateHighlighted];
    //    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    //    //专门修复导航栏中的按钮之间的距离控件
    //    UIBarButtonItem *rightSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    rightSpaceItem.width = -15;
    //    //rightBarButtonItems 从右向左排列
    //    self.navigationItem.rightBarButtonItems = @[rightSpaceItem, searchItem];
    //    //进入搜索栏界面
    //    SearchTableViewController *searchvc = [[SearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //    UINavigationController *searchNavi = [[UINavigationController alloc] initWithRootViewController:searchvc];
    //    [searchBtn bk_addEventHandler:^(id sender) {
    //        [self presentViewController:searchNavi animated:YES completion:nil];
    //    } forControlEvents:UIControlEventTouchDown];
}

@end
