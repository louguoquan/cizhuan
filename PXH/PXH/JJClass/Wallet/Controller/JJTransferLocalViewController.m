//
//  JJTransferLocalViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJTransferLocalViewController.h"
#import "JJTransformCell.h"
#import "JJTransferViewController.h"
#import "JJTransferPageViewController.h"


@interface JJTransferLocalViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation JJTransferLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpNav];
    
    [self.tableView registerClass:[JJTransformCell class] forCellReuseIdentifier:@"JJTransformCell"];
    
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
    
    [self query];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"站内互转";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"转账记录" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    
    JJTransferPageViewController *vc = [[JJTransferPageViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)query{
    
    
    self.dataArray = [NSMutableArray array];
    
    [JJWalletService JJMobileMemberOrderTransferlistCompletion:^(id result, id error) {
        
        [self.dataArray addObject:result];
        [self.tableView reloadData];
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    JJTransformCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJTransformCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJTransformModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJTransferViewController *vc = [[JJTransferViewController alloc]init];
    JJTransformModel *model = self.dataArray[indexPath.row];
    vc.model = model;
    vc.coinName = model.code;
    [self.navigationController pushViewController:vc animated:YES];
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
