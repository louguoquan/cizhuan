//
//  JJSafeSetViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJInformationSetViewController.h"
#import "JJInformationSetCell.h"
#import "JJBDEmailViewController.h"
#import "JJBDEmailNextViewController.h"
#import "JJChangeNickNameViewController.h"


@interface JJInformationSetViewController ()

@end

@implementation JJInformationSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpNav];
    
    [self.tableView registerClass:[JJInformationSetCell class] forCellReuseIdentifier:@"JJInformationSetCell"];
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}



- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"个人资料";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArr = @[@"头像",@"昵称",@"手机号"];
    NSArray *subArr = @[[JYAccountModel sharedAccount].mobile.length>0?[JYAccountModel sharedAccount].mobile:@"",@"乌龙茶",@"13888888888"];
    JJInformationSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJInformationSetCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setViewWithTitle:titleArr[indexPath.row] sub:subArr[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
//        if ([JYAccountModel sharedAccount].mobile.length == 0) {
//            JJBDEmailViewController *vc = [[JJBDEmailViewController alloc]init];
//            vc.type = @"1";
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }
    else if (indexPath.row == 1){
        
//        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"是否确认要修改密码?" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
//
//            JJBDEmailNextViewController *vc = [[JJBDEmailNextViewController alloc]init];
//            vc.type = @"3";
//            vc.mobileOrEmail = [JYAccountModel sharedAccount].mobile;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        })]];
//        [alertView show];
        
        [self.navigationController pushViewController:[JJChangeNickNameViewController new] animated:YES];
    }
    else
    {
//        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"是否确认要设置交易密码?" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
//
//            JJBDEmailNextViewController *vc = [[JJBDEmailNextViewController alloc]init];
//            vc.type = @"4";
//            vc.mobileOrEmail = [JYAccountModel sharedAccount].mobile;
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        })]];
//        [alertView show];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 90;
    }
    return 50;
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
