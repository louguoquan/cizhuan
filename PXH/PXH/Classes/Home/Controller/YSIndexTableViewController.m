//
//  YSIndeTableViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSIndexTableViewController.h"
#import "YSSeckillViewController.h"
#import "YSProductDetailViewController.h"
#import "YSCateProductPageViewController.h"
#import "YSTableViewCell.h"
#import "YSIndexTableHeaderView.h"
#import "YSPanicBuyTableViewCell.h"
#import "YSTimeSectionsView.h"
#import "YSLimitBuyTime.h"

#import "YSProductService.h"
#import "YSPagingListService.h"
#import "YSCateService.h"

@interface YSIndexTableViewController ()

@property (nonatomic, strong) YSIndexTableHeaderView    *headerView;

@property (nonatomic, copy)   NSArray   *timeArray;

@property (nonatomic, strong) YSLimitBuyTime    *currentTime;

@property (nonatomic, strong) YSTimeSectionsView    *timeSectionView;

@property (nonatomic, assign) CGFloat lastOffsetY;

@property (nonatomic, strong) YSPagingListService   *pagingService;

@property (nonatomic, strong) NSArray *productArray;

@end

@implementation YSIndexTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self fetchIndexData];
    [self fetchLimitBuyTime];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self fetchIndexData];
    [self fetchLimitBuyTime];
}

- (void)setupTableView {
    
    _pagingService = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchPanicBuyProductList:page:completion:)];
    
    self.tableView.estimatedRowHeight = 200.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[YSPanicBuyTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _headerView = [[YSIndexTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 350.0 / 750.0)];
    self.tableView.tableHeaderView = _headerView;
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchIndexData];
        [weakSelf fetchLimitBuyTime];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:YES];
    }];
}

#pragma mark - network

- (void)fetchIndexData {
    
    [YSProductService fetchIndexDataWithCompletion:^(NSArray *advArray, NSArray *productArray) {
        self.productArray = productArray;
        [_headerView setAdvArray:advArray productArray:productArray];
    }];
}

- (void)fetchLimitBuyTime {
    [YSProductService fetchLimitBuyTimeWithCompletion:^(id result, id error) {
        _timeArray = result;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        if (_timeArray.count > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type == 2"]; 
            _currentTime = [[_timeArray filteredArrayUsingPredicate:predicate] firstObject];
            
            [self fetchProductListWithLoadMore:NO];
        }
    }];
}

- (void)fetchProductListWithLoadMore:(BOOL)loadMore {
    
    if (!_currentTime) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    [_pagingService loadDataWithParameters:@{@"timeId" : _currentTime.timeId} isLoadMore:loadMore completion:^(id result, id error) {
       
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - routerEvent 

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        switch (type) {
            case 0: //广告点击
            {
                YSAdvertising *adv = userInfo[@"model"];
                if (adv.linkType == 1) {
                    if (adv.productId) {
                        YSProductDetailViewController *vc = [YSProductDetailViewController new];
                        vc.productId = adv.productId;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }else {
                    NSString *catID;
                    if (adv.parentCatId) {
                        catID = adv.parentCatId;
                    } else {
                        catID = adv.catId;
                    }
                    [MBProgressHUD showLoadingText:@"正在获取数据" toContainer:nil];
                    [YSCateService fetchChildCate:catID completion:^(NSArray *result, id error) {
                        [MBProgressHUD dismissForContainer:nil];
                        NSString *name;
                        NSInteger selectIndex = 0;
                        if (result.count > 0) {
                            
                            for (int i = 0; i < result.count; i++) {
                                YSCategory *dic = result[i];
                                if (dic.ID.integerValue == adv.catId.integerValue) {
                                    name = dic.name;
                                    selectIndex = i;
                                }
                            }
                            YSCateProductPageViewController *vc = [YSCateProductPageViewController new];
                            vc.dataSource = result;
                            if (name == nil) {
                                vc.title = adv.name;
                            } else {
                                vc.title = name;
                            }
                            
                            vc.pageIndex = selectIndex;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }];
                }
            }
                break;
            case 1:
                [self.navigationController pushViewController:[YSSeckillViewController new] animated:YES];
                break;
            case 2:
            {
                YSSeckillProduct *seckillProduct = userInfo[@"model"];
                YSProductDetailViewController *vc = [YSProductDetailViewController new];
                vc.productId = seckillProduct.productId;
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            default:
                break;
        }
        
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [_pagingService.dataSource count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *cells = @"YSTableViewCell";
        YSTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[YSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
        }
        
        cell.productArray = self.productArray;
        return cell;
    } else {
        YSPanicBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell setProduct:_pagingService.dataSource[indexPath.row] status:_currentTime.type];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WS(weakSelf);
    if (section == 0) {
        YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
        cell.frame = CGRectMake(0, 0, ScreenWidth, 40);
        cell.backgroundColor = [UIColor whiteColor];
        cell.ys_leftImage = [UIImage imageNamed:@"秒杀"];
        cell.ys_titleFont = [UIFont systemFontOfSize:15];
        cell.ys_titleColor = HEX_COLOR(@"#333333");
        cell.ys_title = @"限量秒杀";
        cell.ys_contentTextAlignment = NSTextAlignmentRight;
        cell.ys_contentFont = [UIFont systemFontOfSize:11];
        cell.ys_contentTextColor = HEX_COLOR(@"#999999");
        cell.ys_text = @"查看更多";
        cell.ys_contentLabel.font = [UIFont systemFontOfSize:13];
        cell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
        cell.ys_bottomLineHidden = NO;
        [cell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent: @(1)}];
        }];
        return cell;
    } else {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 96)];
        YSCellView *cell1 = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
        cell1.backgroundColor = [UIColor whiteColor];
        cell1.frame = CGRectMake(0, 0, ScreenWidth, 40);
        cell1.ys_leftImage = [UIImage imageNamed:@"抢购"];
        cell1.ys_titleFont = [UIFont systemFontOfSize:15];
        cell1.ys_titleColor = HEX_COLOR(@"#333333");
        cell1.ys_title = @"限时抢购";
        cell1.ys_bottomLineHidden = NO;
        [view addSubview:cell1];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 1)];
        lineView.backgroundColor = BACKGROUND_COLOR;
        [view addSubview:lineView];
        
        if (!_timeSectionView) {
            _timeSectionView = [[YSTimeSectionsView alloc] initWithReuseIdentifier:@"header"];
            _timeSectionView.frame = CGRectMake(0, 41, ScreenWidth, 55);
            WS(weakSelf);
            [_timeSectionView timeSectionDidChange:^(YSLimitBuyTime *time) {
                weakSelf.currentTime = time;
                [weakSelf fetchProductListWithLoadMore:NO];
            }];
        }
//        return _timeSectionView;
        [_timeSectionView setTimeSections:_timeArray currentTime:_currentTime];
        [view addSubview:_timeSectionView];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    } else {
       return 95.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 128;
    } else {
        return (kScreenWidth - 20) * 260.0 / 710.0 + 97;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    YSSeckillProduct *seckillProduct = _pagingService.dataSource[indexPath.row];
    vc.productId = seckillProduct.productId;
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
