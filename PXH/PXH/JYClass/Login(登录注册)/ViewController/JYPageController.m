//
//  JYSignInPageController.m
//  PXH
//
//  Created by LX on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPageController.h"
#import "JYSignInController.h"

@interface JYPageController ()

@end

@implementation JYPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpPage];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    if (self.pushType == PushType_SignIn) {
        navigationLabel.text = @"注册";
    }
    else {
        navigationLabel.text = @"找回密码";
    }
}

- (void)setUpPage
{
    [self renderUI];
    self.segmentView.containerView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}


#pragma mark - YSScrollPageViewControllerDataSource

//设置item
- (YSSegmentStyle *)segmentStyleForPageViewController
{
    YSSegmentStyle *style = [YSSegmentStyle new];
    style.titleFont = [UIFont systemFontOfSize:15.f];
    style.normalTitleColor = HEX_COLOR(@"#000000");
    style.selectedTitleColor = HEX_COLOR(@"#E20025");
    style.bottomLineColor = [UIColor clearColor];
    return style;
}

- (NSArray *)titlesForPageViewController
{
    return @[@"通过手机", @"通过邮箱"];
}

- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index
{
    return [JYSignInController class];
}

//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index
{
    return @{
             @"pushType":[NSString stringWithFormat:@"%ld", self.pushType],
             @"index":[NSString stringWithFormat:@"%ld", index],
             };
}

-(void)setPushType:(PushType)pushType
{
    _pushType = pushType;
}

@end
