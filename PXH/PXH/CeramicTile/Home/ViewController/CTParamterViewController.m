//
//  CTParamterViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTParamterViewController.h"
#import "CTParamerHeadView.h"

@interface CTParamterViewController ()

@end

@implementation CTParamterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CTParamerHeadView *head = [[CTParamerHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    self.tableView.tableHeaderView = head;

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
