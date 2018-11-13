//
//  JJCoinInOrCoinOutListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCoinInOrCoinOutListViewController.h"
#import "JJCoinInOrCoinOutViewController.h"

@interface JJCoinInOrCoinOutListViewController ()

@end

@implementation JJCoinInOrCoinOutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderUI];
    [self setUpNav];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"交易记录";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}



#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    return [JJCoinInOrCoinOutViewController class];
    
}

//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index{
    
    return @{@"index":[NSString stringWithFormat:@"%ld",index]};
    
    
    
}

- (NSArray *)titlesForPageViewController {
    return @[@"全部记录", @"充值记录",@"转账记录"];
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
