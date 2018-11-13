//
//  JJBuyCoinListDetailViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinListDetailViewController.h"
#import "JJBuyCoinDetailCell.h"

@interface JJBuyCoinListDetailViewController ()

@end

@implementation JJBuyCoinListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self.tableView registerClass:[JJBuyCoinDetailCell class] forCellReuseIdentifier:@"JJBuyCoinDetailCell"];
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        weakSelf.page = 1;
        //        [weakSelf queryRevenueRanking];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //        weakSelf.page ++;
        //        [weakSelf queryRevenueRanking];
    }];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArr = @[@"认购数量",@"认购状态",@"支付方式",@"支付数量",@"交易时间"];
    
    NSString *count = [NSString stringWithFormat:@"%@%@",self.model.buyNumber,CoinNameChange];
    
    NSString *status = @"";
    if (self.model.orderStatus.integerValue == 0) {
        status = @"未完成";
    }else if (self.model.orderStatus.integerValue ==1){
        status = @"审核中";
    }else if (self.model.orderStatus.integerValue ==2){
        status = @"已完成";
    }
    
    NSString *payWay = PayCoinNameChange;
    NSString *payCount = self.model.payPrice;
    NSString *time = self.model.ct;
    NSArray *subArr = @[count,status,payWay,payCount,time];
    JJBuyCoinDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJBuyCoinDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTitle:titleArr[indexPath.row] sub:subArr[indexPath.row] index:indexPath.row];
    return cell;
    
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
