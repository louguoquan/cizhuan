//
//  YSLifeTableViewController.m
//  PXH
//
//  Created by futurearn on 2017/12/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLifeTableViewController.h"
#import "YSLifeCircleTableViewCell.h"
#import "YSLifeSearchViewController.h"
#import "YSMerchantsViewController.h"
#import "YSMerchantsDetailViewController.h"
#import "YSLifeCircleHeaderView.h"
#import "YSLifeCircleModel.h"
#import "YSLifeMerchants.h"
@interface YSLifeTableViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    YSLifeCircleModel *lefeModel;
}
@property (nonatomic, strong) YSLifeCircleHeaderView    *headerView;

@property (nonatomic, strong) NSMutableArray   *dataSource;

@property (nonatomic, strong) NSMutableArray *catsArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YSLifeTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        
    } else {
        [self judgeLoginActionWith:1];
    }
}

- (void)fetchLifeData {
    
//    NSString *URL = [NSString stringWithFormat:@"%@%@", BASE_URL,kLifeCircle_URL];
    NSString *URL = @"http://mobile.zjpxny.com:80/mobile/life/data";
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:@{@"memberId":[YSAccount sharedAccount].ID} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject[@"result"];
        NSString *code = responseObject[@"code"];
        if (code.integerValue == 0) {
            YSLifeCircleModel *model = [YSLifeCircleModel mj_objectWithKeyValues:result];
            NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result[@"shops"]];
            
            if (merchants.count != 0) {
                [_dataSource removeAllObjects];
                [_dataSource addObjectsFromArray:merchants];
                [self.tableView reloadData];
            }
            if (model.cats.count > 0) {
                [self setupTableView:model];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:[error description] toContainer:nil];

    }];
    [self.tableView.mj_header endRefreshing];
    
    
//    [[SDDispatchingCenter sharedCenter] POST:kLifeCircle_URL parameters:@{@"memberId":[YSAccount sharedAccount].ID} success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *result = responseObject[@"result"];
//        YSLifeCircleModel *model = [YSLifeCircleModel mj_objectWithKeyValues:result];
//        NSArray *merchants = [YSLifeMerchants mj_objectArrayWithKeyValuesArray:result[@"shops"]];
//
//        if (merchants.count != 0) {
//            [_dataSource removeAllObjects];
//            [_dataSource addObjectsFromArray:merchants];
//            [self.tableView reloadData];
//        }
//        if (model.cats.count > 0) {
//            [self setupTableView:model];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, SDError *error) {
//        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
//
//    }];
//    [self.tableView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    self.catsArray = [NSMutableArray array];
    
    self.navigationItem.title = @"生活分类";
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        
        [self fetchLifeData];
    }
}

- (void)setupTableView:(YSLifeCircleModel *)model {
    
    
    NSArray *array = model.cats;
    CGFloat height = 116 + (array.count + 3 ) / 4 * 100;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchLifeData];
    }];
    
    [self creatRightButton];
    [self.tableView registerClass:[YSLifeCircleTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headerView = [[YSLifeCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    _headerView.array = _catsArray;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataSource.count;
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

#pragma mark - router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        
        YSLifeCategory *cate = userInfo[@"model"];
        
        YSMerchantsViewController *vc = [YSMerchantsViewController new];
        vc.cate = cate;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
