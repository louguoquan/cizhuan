//
//  JYAdvertiseListViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAdvertiseListViewController.h"
#import "JYWebController.h"
//
#import "YSProductDetailViewController.h"
#import "JYAdvertiseCell.h"
#import "YSPagingListService.h"
#import "YSProductService.h"
//
#import "JYMarketService.h"

#import "JYMineService.h"
#import "JYCmsIndexModel.h"
#import "JYCmsContentModel.h"


@interface JYAdvertiseListViewController ()
{
    NSInteger       page;
}

@property (nonatomic, strong) NSArray   *listArr;

@end

@implementation JYAdvertiseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"公告中心";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    page = 0;
    
    [self getListInfo:NO];
    
    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView.estimatedRowHeight = 110.f;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.tableView registerClass:[JYAdvertiseCell class] forCellReuseIdentifier:@"JYAdvertiseCell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        weakSelf.tableView.mj_footer.hidden = NO;
        [weakSelf.tableView.mj_header beginRefreshing];
        
        [weakSelf getListInfo:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakSelf.tableView.mj_footer beginRefreshing];
        [weakSelf getListInfo:YES];
    }];
}


#pragma mark - router Event

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        YSProduct *product = userInfo[kButtonDidClickRouterEvent];
        [YSProductService collectionProduct:product.productId completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
            
//            [self.service.dataSource removeObject:product];
            [self.tableView reloadData];
        }];
    }
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYAdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYAdvertiseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.product = _service.dataSource[indexPath.row];
    cell.model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYCmsIndexModel *model = (JYCmsIndexModel*)self.listArr[indexPath.row];
    
    if (model.url && model.url.length) {
        JYWebController *vc = [[JYWebController alloc] init];
        vc.urlString = model.url;
        vc.navTitle  = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
    }
}


- (void)getListInfo:(BOOL)isMore
{
    WS(weakSelf)
    [JYMineService cmsIndexListWithId:@"2" page:page completion:^(id result, id error) {
        if (isMore) {
            if (![(NSArray *)result count]) {
                self.tableView.mj_footer.hidden = YES;
                return;
            }
            NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.listArr];
            [muArr addObjectsFromArray:result];
            self.listArr = [muArr mutableCopy];
        }else{
            weakSelf.listArr = result;
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

- (void)getListItemContent:(NSString *)Id
{
    [MBProgressHUD showLoadingToContainer:nil];
    [JYMineService cmsContentWithId:Id completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        
        JYCmsContentModel *model = (JYCmsContentModel *)result;
        if (model.url.length) {
            JYWebController *vc = [[JYWebController alloc] init];
            vc.urlString = model.url;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showText:@"获取内容失败，请稍后重试" toContainer:nil];
        }
    }];
}

@end
