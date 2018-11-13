//
//  JJADListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJADListViewController.h"
#import "JJADListCell.h"

@interface JJADListViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation JJADListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    [self setUpNav];
    
    [self.tableView registerClass:[JJADListCell class] forCellReuseIdentifier:@"JJADListCell"];
    
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
    
    [JJMineService JJMobilMemberMessageCenterWithPage:self.page Completion:^(id result, id error) {
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

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"消息中心";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
//    UIButton *selectBtn = [[UIButton alloc]init];
//    selectBtn.frame = CGRectMake(0, 0, 80, 35);
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
//    [selectBtn setTitle:@"全部已读" forState:UIControlStateNormal];
//    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJADListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJADListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJMessageModel *model = self.dataArray[indexPath.row];
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
