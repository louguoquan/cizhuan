//
//  YSDeliverViewController.m
//  PXH
//
//  Created by futurearn on 2017/11/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDeliverViewController.h"
#import "YSOrderService.h"
#import "SDEmptyView.h"
#import "YSDeliverTableViewCell.h"
@interface YSDeliverViewController ()

@property (nonatomic, strong) UILabel *deliverStateLabel;
@property (nonatomic, strong) UILabel *deliverNumLabel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) SDEmptyView *emptyView;

@end

@implementation YSDeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看物流";\
    self.dataSource = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)fetchDeliverData
{
    [YSOrderService fetchDeliverDetail:_order.orderId completion:^(id result, id error) {
        
        [_dataSource addObject: result];
        if (_dataSource.count != 0) {
            self.tableView.hidden = NO;
            [_emptyView removeFromSuperview];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
        } else {
            self.tableView.hidden = YES;
            self.emptyView = [[SDEmptyView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 124)];
            self.emptyView.imageName = @"service_express";
//            self.emptyView.emptyLabel.text = @"暂无快递信息";
            self.emptyView.text = @"暂无快递信息";
            [self.view addSubview:_emptyView];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setOrder:(YSOrder *)order
{
    _order = order;
    [self initWithTableView];
    [self fetchDeliverData];
    self.deliverStateLabel.text = [YSOrder statusStringForStatus:_order.status];
    self.deliverNumLabel.text = [NSString stringWithFormat:@"订单编号 : %@", _order.orderNo];
}

- (void)initWithTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[YSDeliverTableViewCell class] forCellReuseIdentifier:@"deliver"];
    [self.view addSubview:self.tableView];
    
    [self initWithTableHeaderView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchDeliverData];
    }];
}

- (void)initWithTableHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    self.tableView.tableHeaderView = headerView;
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#333333");
    label.text = @"订单状态 : ";
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(20);
        make.height.mas_equalTo(20);
    }];
    
    self.deliverStateLabel = [UILabel new];
    _deliverStateLabel.font = [UIFont systemFontOfSize:15];
    _deliverStateLabel.textColor = HEX_COLOR(@"#ef5454");
    [headerView addSubview:_deliverStateLabel];
    [_deliverStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(label.mas_right).offset(5);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(label);
        
    }];
    
    self.deliverNumLabel = [UILabel new];
    _deliverNumLabel.font = [UIFont systemFontOfSize:15];
    _deliverNumLabel.textColor = HEX_COLOR(@"#333333");
    [headerView addSubview:_deliverNumLabel];
    [_deliverNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(label);
        make.top.mas_equalTo(_deliverStateLabel.mas_bottom).offset(10);
        make.height.equalTo(_deliverStateLabel);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSDeliver *deliver = _dataSource[indexPath.row];
    CGRect height = [self getHeight:deliver.memo];
    if (height.size.height > 60) {
        return height.size.height;
    } else {
       return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    grayView.backgroundColor = HEX_COLOR(@"#cccccc");
    [headerView addSubview:grayView];
    
    UILabel *label = [UILabel new];
    label.textColor = HEX_COLOR(@"#333333");
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"商品运输状态";
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(15);
        make.top.mas_equalTo(grayView.mas_bottom).offset(3);
        make.height.mas_equalTo(25);
        
    }];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSDeliverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deliver" forIndexPath:indexPath];
    YSDeliver *deliver =_dataSource[indexPath.row];
    if (indexPath.row == 0) {
        cell.row = 0;
    } else if (indexPath.row == _dataSource.count - 1) {
        cell.row = 2;
    } else {
        cell.row = 1;
    }
    cell.deliver = deliver;

    return cell;
}

#pragma mark - 动态获取高度
- (CGRect)getHeight:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(ScreenWidth - 222, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return rect;
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
