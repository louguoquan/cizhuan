//
//  JJMineCalculateListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/8/6.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJMineCalculateListViewController.h"
#import "JJMineCalculateCell.h"
@interface JJMineCalculateListViewController ()

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation JJMineCalculateListViewController

- (void)viewWillAppear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[JJMineCalculateCell class] forCellReuseIdentifier:@"JJMineCalculateCell"];
    self.page = 1;
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self query];
    
    [self setUpNav];
    
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
    
    [JJCalculateService JJCountRecord:self.page Completion:^(id result, id error) {
        
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
    JJMineCalculateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJMineCalculateCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJMineCalculateModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
    
}


- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"我的算力";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
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
