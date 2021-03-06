//
//  JJTransferListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/27.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJTransferListViewController.h"
#import "JJCoinInOrOutCell.h"


@interface JJTransferListViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation JJTransferListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[JJCoinInOrOutCell class] forCellReuseIdentifier:@"JJCoinInOrOutCell"];
    
    self.page = 1;
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                weakSelf.page = 1;
                [weakSelf query];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                weakSelf.page ++;
                [weakSelf query];
    }];
    
    [self query];
}

- (void)query{
    
    if (self.page == 1) {
        self.dataArray = [NSMutableArray array];
    }
    
    [JJWalletService JJMobileMemberOrderTurnRecordWithType:self.index page:self.page Completion:^(id result, id error) {
        
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
    JJCoinInOrOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJCoinInOrOutCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArray.count) {
        JJCoinInOrOutModel *model = self.dataArray[indexPath.row];
       
        if (self.index.integerValue == 2) {
            cell.type = @"1";
        }else{
            cell.type = @"2";
        }
        
        
         cell.model = model;
    }
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
