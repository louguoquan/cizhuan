
//
//  YSLifeCircleViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLifeCircleViewController.h"
#import "YSMerchantsDetailViewController.h"
#import "YSLifeSearchViewController.h"
#import "YSLifeCategory.h"
#import "YSLifeCircleHeaderView.h"
#import "YSLifeCircleTableViewCell.h"

#import "YSLifecircleService.h"
#import "YSMerchantsViewController.h"

#import "YSLoginGuidingViewController.h"
@interface YSLifeCircleViewController ()
{
    YSLifeCircleModel *lefeModel;
}
@property (nonatomic, strong) YSLifeCircleHeaderView    *headerView;

@property (nonatomic, strong) NSMutableArray   *dataSource;

@property (nonatomic, strong) NSMutableArray *cats;

@end

@implementation YSLifeCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    self.cats = [NSMutableArray array];
    self.navigationItem.title = @"生活分类";
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {

        [self fetchLifeData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
//        [self fetchLifeData];
    } else {
        [self judgeLoginActionWith:1];
    }
}

- (void)setupTableView:(YSLifeCircleModel *)model {
    
    WS(weakSelf);
    CGFloat height = 100 + (_cats.count + 3 ) / 4 * 100;
    _headerView = [[YSLifeCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    _headerView.array = _cats;
    _headerView.click = ^(YSLifeCategory *model) {
      
        YSMerchantsViewController *vc = [YSMerchantsViewController new];
        vc.cate = model;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchLifeData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    [self creatRightButton];
    [self.tableView registerClass:[YSLifeCircleTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = _headerView;

}

- (void)creatRightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake( 0, 0, 20, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)rightAction {
    YSLifeSearchViewController *life = [YSLifeSearchViewController new];
    life.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:life animated:YES];
}

- (void)fetchLifeData {

//    [YSLifecircleService fetchLifeIndexData:^(id result, id error) {
//        if (result) {
//
//            YSLifeCircleModel *model = result;
//
//            if (model.cats.count > 0) {
//                [self setupTableView:result];
//            }
//
//            NSArray *array = (NSArray *)error;
//            [_dataSource addObjectsFromArray:array];
//            if (_dataSource.count > 0) {
//                [self.tableView reloadData];
//            }
//        }
//
//        [self.tableView.mj_header endRefreshing];
//
//    }];
//    self.dataSource = [NSMutableArray array];
//    [[SDDispatchingCenter sharedCenter] POST:kLifeCircle_URL parameters:@{@"memberId":[YSAccount sharedAccount].ID} success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *result = responseObject[@"result"];
//        YSLifeCircleModel *model = [YSLifeCircleModel mj_objectWithKeyValues:result];
//        NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result[@"shops"]];
//
//
//
//        if (model.cats.count > 0) {
//            [self setupTableView:model];
//        }
//
//        if (merchants.count > 0) {
//            [_dataSource removeAllObjects];
//            [_dataSource addObjectsFromArray:merchants];
//        }
//        [self.tableView reloadData];
//
//    } failure:^(NSURLSessionDataTask *task, SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//
//    }];
//    kLifeCircle_URL
    NSString *URL = @"http://mobile.zjpxny.com:80/mobile/life/data";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:@{@"memberId":[YSAccount sharedAccount].ID} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        NSString *code = responseObject[@"code"];
        if (code.integerValue == 0) {
            YSLifeCircleModel *model = [YSLifeCircleModel mj_objectWithKeyValues:result];
            NSArray *cats = result[@"cats"];
            if (cats.count > 0) {
                [_cats removeAllObjects];
                for (NSDictionary *dic in cats) {
                    YSLifeCategory *life = [YSLifeCategory new];
                    [life setValuesForKeysWithDictionary:dic];
                    [_cats addObject:life];
                }
            }
            NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result[@"shops"]];
            if (_cats.count > 0) {
                [self setupTableView:model];
            }
            if (merchants.count != 0) {
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:merchants];
                [self.tableView reloadData];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:[error description] toContainer:nil];
        
    }];
    [self.tableView.mj_header endRefreshing];
}


//#pragma mark - router Event
//- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
//
//    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
//
//        YSLifeCategory *cate = userInfo[@"model"];
//
//        YSMerchantsViewController *vc = [YSMerchantsViewController new];
//        vc.cate = cate;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//
//}

#pragma mark - tableView delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YSLifeCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
