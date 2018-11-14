//
//  CTBrandRankingViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTBrandRankingViewController.h"
#import "CTBrandRankingListViewController.h"
#import "SDCycleScrollView.h"


@interface CTBrandRankingViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@end

@implementation CTBrandRankingViewController

- (NSArray<NSString *> *)titles{
    return @[@"热点品牌", @"热点产品"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}


- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    return [[CTBrandRankingListViewController alloc]init];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    
    return CGRectMake(0, 150, kScreenWidth, 40);
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    
    return CGRectMake(0, 190, kScreenWidth, kScreenHeight-190);
    
}

- (void)viewDidLoad {
    //题目的背景栏颜色
    //    self.menuBGColor = [UIColor clearColor];
    //题目的显示效果
    self.menuViewStyle = WMMenuViewStyleLine;
    //题目的宽度
    self.menuItemWidth = 100;
    //设置选中文字颜色
    self.titleColorSelected = [UIColor blackColor];
    //设置未选中文字颜色
    self.titleColorNormal = [UIColor grayColor];
    //设置下划线(或者边框)颜色
    self.progressColor = [UIColor blackColor];
    [super viewDidLoad];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
    //    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [self.view addSubview:_cycleScrollView];
    
    
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
