//
//  JYCurrencyBriefController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYCurrencyBriefController.h"
#import "JYContactSynopsisController.h"
#import "JYWebController.h"

#import "JYSearchView.h"

#import "YSPagingListService.h"
#import "JYMineService.h"

@interface JYCurrencyBriefController (){
    
    NSArray  *_titleArr;
    NSArray  *_imgIcoArr;
}

@property (nonatomic, strong) JYSearchView          *searchView;

@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic, strong) NSString *   searchKeyWord;
@property (nonatomic, assign) NSInteger page;
@end

@implementation JYCurrencyBriefController

- (JYSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[JYSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50.f)];
        _searchView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    }
    return _searchView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.page = 1;
    [self setUpNav];
    [self setupTableView];
    [self setUpAskRefresh];
    [self fetchProductList:NO];
    

    
    WS(weakSelf);
    self.searchView.SearchCurrencyBlock = ^(JYSearchView *searchView, NSString *currencyStr) {
        NSLog(@"%@",currencyStr);
        weakSelf.searchKeyWord  = currencyStr;
        [weakSelf fetchProductList:NO];
    };
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"币种介绍";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{

    
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}

- (void)setUpAskRefresh
{
    _service = [[YSPagingListService alloc] initWithTargetClass:[JYMineService class] action:@selector(coinInfoCoinDesc:page:completion:)];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [weakSelf fetchProductList:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [weakSelf fetchProductList:YES];
    }];
}

- (void)fetchProductList:(BOOL)loadMore
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(self.page);
    param[@"search"] = self.searchKeyWord;
    
    [_service loadDataWithParameters:param isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _service.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.f]];
    
    if (_service.dataSource.count>0) {
        
        JYMarketModel *model = _service.dataSource[indexPath.section];
        cell.textLabel.text = model.code;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = UIView.new;
    
    if (section==0) [headView addSubview:self.searchView];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?60.f:CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYMarketModel *model = _service.dataSource[indexPath.section];
    
    JYContactSynopsisController *vc = [[JYContactSynopsisController alloc] init];
    vc.coinId = model.ID;
    vc.cuntactName = model.code;
    [self.navigationController pushViewController:vc animated:YES];
    

//    JYMarketModel *model = _service.dataSource[indexPath.section];
//    if (model.coinDesc && model.coinDesc.length) {
//        JYWebController *vc = [[JYWebController alloc] init];
//        vc.urlString = model.coinDesc;
//        vc.navTitle = model.code;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else{
//        [MBProgressHUD showText:@"内容获取失败，请稍后重试" toContainer:nil];
//    }
}

@end
