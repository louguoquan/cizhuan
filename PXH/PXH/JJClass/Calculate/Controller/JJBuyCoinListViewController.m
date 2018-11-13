//
//  JJBuyCoinListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinListViewController.h"
#import "JJBuyCoinListCell.h"
#import "JJBuyCoinListDetailViewController.h"
#import "JJBuyCoinPayViewController.h"

@interface JJBuyCoinListViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation JJBuyCoinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[JJBuyCoinListCell class] forCellReuseIdentifier:@"JJBuyCoinListCell"];
    self.page = 1;
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self query];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf query];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf query];
    }];
}

- (void)query{
    
    [JJCalculateService JJMobileMemberOrderOrderList:self.index page:self.page Completion:^(id result, id error) {
        
        if (self.page == 1) {
            self.dataArray = [NSMutableArray arrayWithArray:result];
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJBuyCoinListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJBuyCoinListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJBuyCoinListModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJBuyCoinListModel *model = self.dataArray[indexPath.row];
    
    if (model.orderStatus.integerValue==0) {
        
        JJBuyCoinListDetailViewController *vc = [[JJBuyCoinListDetailViewController alloc]init];
        vc.model = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (model.orderStatus.integerValue == 1){
        JJBuyCoinListDetailViewController *vc = [[JJBuyCoinListDetailViewController alloc]init];
        vc.model = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(model.orderStatus.integerValue == 2){
        JJBuyCoinListDetailViewController *vc = [[JJBuyCoinListDetailViewController alloc]init];
        vc.model = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
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
