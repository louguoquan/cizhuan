//
//  YSAddressViewController.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAddressViewController.h"
#import "YSAddAddressViewController.h"

#import "YSAddressTableViewCell.h"
#import "YSButton.h"

#import "YSAddressService.h"

@interface YSAddressViewController ()

@property (nonatomic, strong) NSMutableArray    *dataSource;

@end

@implementation YSAddressViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的地址";
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchAddressList];
}

- (void)setupTableView {
    
    self.tableView.estimatedRowHeight = 120.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSAddressTableViewCell class] forCellReuseIdentifier:@"cell"];
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchAddressList];
    }];
    
    YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    button.frame = CGRectMake(0, 0, kScreenWidth, 44);
    button.space = 10;
    button.backgroundColor = MAIN_COLOR;
    [button setTitle:@"新增地址" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = button;

}

- (void)addAddress {
    
    YSAddAddressViewController *vc = [YSAddAddressViewController new];
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)fetchAddressList {
    [YSAddressService fetchAddressListCompletion:^(id result, id error) {
        if (result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
        }

        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - router

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        YSAddress *address = userInfo[@"model"];
        
        switch (type) {
                //设为默认地址
            case 0: {
                [MBProgressHUD showLoadingText:@"" toContainer:nil];
                [YSAddressService setDefaultAddress:address.ID completion:^(id result, id error) {
                    [MBProgressHUD showSuccessMessage:@"设置成功" toContainer:nil];
                    [self fetchAddressList];
                }];
            }
                break;
                //删除地址
            case 1: {
                [MBProgressHUD showLoadingText:@"" toContainer:nil];
                [YSAddressService deleteAddress:address.ID completion:^(id result, id error) {
                    [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
                    [self.dataSource removeObject:address];
                    [self.tableView reloadData];
                }];
            }
                break;
                //编辑地址
            case 2: {
                YSAddAddressViewController *vc = [YSAddAddressViewController new];
                vc.address = address;
                vc.type = 0;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }
}

#pragma mark - tableView 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.address = _dataSource[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.block) {
        self.block(_dataSource[indexPath.section]);
        [self.navigationController popViewControllerAnimated:YES];
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
