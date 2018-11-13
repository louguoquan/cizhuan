//
//  YSSetupViewController.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSetupViewController.h"
#import "YSSetupTableViewCell.h"
#import "YSNetWork.h"
@interface YSSetupViewController ()
{
    NSArray *_dataSource;
}
@end

@implementation YSSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self setupTableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 85)];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(15, 20, kScreenWidth - 30, 45);
    [logoutButton jm_setCornerRadius:1 withBackgroundColor:MAIN_COLOR];
    [logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [logoutButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [[[MMAlertView alloc] initWithTitle:@"确定退出登陆?" detail:nil items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
            
            [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeLogin];
            [YSNetWork clearCID];
        })]] show];

    }];
    [footerView addSubview:logoutButton];
    self.tableView.tableFooterView = footerView;
}

- (void)setupTableView {
    _dataSource = @[@[@"清除缓存"]];
    [self.tableView registerClass:[YSSetupTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSSetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *title = _dataSource[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *content = nil;
    if (indexPath.section == 0) {
        content = [NSString stringWithFormat:@"%.2fM", [SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0];
    }else if (indexPath.section == 1) {
        content = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setLeftImage:nil title:title content:content rightImage:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"是否要清除缓存" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
            
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [MBProgressHUD showSuccessMessage:@"清除成功" toContainer:nil];
                [self.tableView reloadData];
            }];
            
        })]];
        [alertView show];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
