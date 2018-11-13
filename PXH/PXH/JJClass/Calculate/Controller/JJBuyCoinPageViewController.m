//
//  JJBuyCoinPageViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinPageViewController.h"
#import "JJBuyCoinListViewController.h"


@interface JJBuyCoinPageViewController ()

@end

@implementation JJBuyCoinPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderUI];
    [self setUpNav];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"认购记录";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}



#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    return [JJBuyCoinListViewController class];
    
}

//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index{
    
    
    NSString *status = @"";
    if (index == 0) {
        status = @"3";
    }else{
        status = [NSString stringWithFormat:@"%ld",index-1];
    }
    
    return @{@"index":status};
        

    
}

- (NSArray *)titlesForPageViewController {
    return @[@"全部订单", @"未完成",@"审核中",@"已完成"];
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
