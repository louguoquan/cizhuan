//
//  JJTransferPageViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/27.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJTransferPageViewController.h"
#import "JJTransferListViewController.h"


@interface JJTransferPageViewController ()

@end

@implementation JJTransferPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    [self renderUI];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"转账记录";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
  
}

#pragma mark - delegate
- (Class)childViewControllersForPageViewControllerAtIndex:(NSInteger)index {
    
    return [JJTransferListViewController class];
    
}

//往子控件传参
- (NSDictionary *)extensionForChildViewControllerAtIndex:(NSInteger)index{
    
    NSInteger i = 0;
    if (index == 0) {
        i = 2;
    }else if (index == 1){
        i = 1;
    }
    return @{@"index":[NSString stringWithFormat:@"%ld",i]};
    
}

- (NSArray *)titlesForPageViewController {
    return @[@"转入", @"转出"];
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
