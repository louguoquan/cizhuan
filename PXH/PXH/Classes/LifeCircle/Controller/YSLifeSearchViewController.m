//
//  YSLifeSearchViewController.m
//  PXH
//
//  Created by futurearn on 2017/11/29.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSMerchantsDetailViewController.h"
#import "YSLifeSearchViewController.h"
#import "YSLifeCircleTableViewCell.h"
#import "YSLifecircleService.h"
#import "YSNavTitleView.h"
@interface YSLifeSearchViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *keyWord;

@end

@implementation YSLifeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupNavTitleView];
    [self initWithTableView];
    
}

- (void)setupNavTitleView {
    
    YSNavTitleView *titleView = [[YSNavTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) type:2];
    titleView.searchAllProductBlock = ^(NSString *name) {
        
        self.keyWord = name;
        [self.tableView.mj_header beginRefreshing];
    };
    self.navigationItem.titleView = titleView;
}

- (void)initWithTableView
{
    self.tableView.rowHeight = 140.f;
    
    [self.tableView registerClass:[YSLifeCircleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.bottom.right.equalTo(self.view);
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self fetchProductList];
        
    }];
}

- (void)fetchProductList
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:self.keyWord forKey:@"name"];
    [YSLifecircleService fetchLifeSearch:dic completion:^(id result, id error) {
        if (error) {
            _dataSource = error;
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSource.count != 0) {
        return self.dataSource.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSLifeCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.merchants = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSMerchantsDetailViewController *vc = [YSMerchantsDetailViewController new];
    vc.merchants = _dataSource[indexPath.row];
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
