//
//  YSMessageViewController.m
//  PXH
//
//  Created by futurearn on 2017/12/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMessageViewController.h"
#import "YSMessageTableViewCell.h"
#import "YSMessageDetailController.h"

#import "YSMessage.h"
@interface YSMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, assign)NSInteger pageNum;

@property (nonatomic, assign)NSInteger isClear;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation YSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息盒子";
    
    self.dataSource = [NSMutableArray array];
    
    self.page = 1;
    
    self.pageNum = 10;
    
    self.isClear = 1;
    
    [self creatTableView];
    [self fetchData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.clearValue();
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 90.f;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[YSMessageTableViewCell class] forCellReuseIdentifier:@"消息中心"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.page = 1;
        [_dataSource removeAllObjects];
        [self fetchData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        self.page++;
        [self fetchData];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"消息中心" forIndexPath:indexPath];
    cell.message = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSMessageDetailController *detail = [YSMessageDetailController new];
    detail.infoMessage = _dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)fetchData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(self.page);
    param[@"rows"] = @(10);
    param[@"memberId"] = USER_ID;
    param[@"type"] = @(1);
    param[@"isClear"] = @(self.isClear);
    [[SDDispatchingCenter sharedCenter]POST:kMessage_URL parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        if (result.count != 0) {
            for (NSDictionary *dic in result) {
                YSMessage *message = [YSMessage new];
                [message setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:message];
            }
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
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
