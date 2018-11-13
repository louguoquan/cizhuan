//
//  YSBaseScrollViewController.m
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseScrollViewController.h"

@interface YSBaseScrollViewController ()

@end

@implementation YSBaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WS(weakSelf);
    _scrollView = [YSScrollView new];
    _scrollView.delegate = self;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    _containerView = [UIView new];
    [_scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
    }];
}
    
- (UIImageView *)makeClearNavigationController
{
    UIImage *topBarimage = [UIImage imageNamed:@"topBar"];
    [self.navigationController.navigationBar setBackgroundImage:topBarimage forBarMetrics:UIBarMetricsCompact];
    UIImageView *shadowImage = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    shadowImage.userInteractionEnabled = YES;
    return shadowImage;
}
    
    //消除导航栏黑线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:0 green:183 / 255.0f blue:238 / 255.0f alpha:0]] forBarMetrics:UIBarMetricsDefault];
    
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (UIImage *)imageWithBgColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
