//
//  JJShopViewController.m
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJShopViewController.h"
#import "JJShopCell.h"
#import "YSProductDetailViewController.h"
#import "JJOrderSubmitViewController.h"
#import "JJShopService.h"

@interface JJShopViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation JJShopViewController

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
    
    self.page = 1;
    [self setUpNav];
    
    [self.tableView registerClass:[JJShopCell class] forCellReuseIdentifier:@"JJShopCell"];
    
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
    
    [JJShopService JJMobileProductListCompletion:^(id result, id error){
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
    navigationLabel.text = @"机器挖矿";
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
    JJShopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJShopCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJShopModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJShopModel *model = self.dataArray[indexPath.row];
    YSProductDetailViewController *vc = [[YSProductDetailViewController alloc]init];
    vc.productId = model.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
//    JJOrderSubmitViewController *vc = [[JJOrderSubmitViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
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
