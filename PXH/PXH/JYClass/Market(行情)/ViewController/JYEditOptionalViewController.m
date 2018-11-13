//
//  JYEditOptionalViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYEditOptionalViewController.h"

//
#import "YSProductDetailViewController.h"

#import "YSPagingListService.h"
#import "YSProductService.h"
//

#import "JYMarketEditCell.h"
#import "JYMarketService.h"
#import "JXMovableCellTableView.h"
#import "JYTradingService.h"
#import "JYEmptyView.h"


@interface JYEditOptionalViewController ()<JXMovableCellTableViewDataSource, JXMovableCellTableViewDelegate>

@property (nonatomic, strong) YSPagingListService   *service;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic,strong)  JXMovableCellTableView *tableView;

@property (nonatomic,strong)  UIView *headerView;

@property (nonatomic,strong)JYEmptyView *emptyView;




@end

@implementation JYEditOptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"编辑自选";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    [self setupTableView];
    
    [self fetchProductList:NO];
    
    
    
}

- (void)setNav{
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    //    [btn setImage:@"" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    btn.frame =CGRectMake(0, 0, 40, 25);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleEdgeInsets = UIEdgeInsetsMake(5, 2.5, 5, 2.5);
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}


- (void)back{
    //刷新自选模块数据
    [[NSNotificationCenter defaultCenter]postNotificationName:@"editChangeRefreshData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)setupTableView {
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[JYMarketService class] action:@selector(fetchCoinList:page:completion:)];
    
    
    
    _dataSource = [NSMutableArray new];
    NSArray *sectionTextArray = @[@"我只是一段普通的文本😳",
                                  @"我只是一段可爱的文本😊",
                                  @"我只是一段调皮的文本😜",
                                  @"我只是一段无聊的文本🙈"];
    for (NSInteger section = 0; section < sectionTextArray.count; section ++) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (NSInteger row = 0; row < 5; row ++) {
            [sectionArray addObject:[NSString stringWithFormat:@"%@-%ld", sectionTextArray[section], row]];
        }
        [_dataSource addObject:sectionArray];
    }
    
    _tableView = [[JXMovableCellTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[JYMarketEditCell class] forCellReuseIdentifier:@"JYMarketEditCell"];
    
    _tableView.gestureMinimumPressDuration = 0.5;
    _tableView.drawMovalbeCellBlock = ^(UIView *movableCell){
        movableCell.layer.shadowColor = [UIColor grayColor].CGColor;
        movableCell.layer.masksToBounds = NO;
        movableCell.layer.cornerRadius = 0;
        movableCell.layer.shadowOffset = CGSizeMake(-5, 0);
        movableCell.layer.shadowOpacity = 0.4;
        movableCell.layer.shadowRadius = 5;
    };
    
    
    _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    WS(weakSelf);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductList:NO];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductList:YES];
    }];
    
    
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 36)];
    _headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [UILabel new];
    label.text = @"已选（长按拖动排序）";
    label.font = [UIFont systemFontOfSize:13];
    label.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [_headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView).offset(12);
        make.left.equalTo(_headerView).offset(12);
        make.height.mas_equalTo(12);
    }];
    
    
    
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [UIView new];
}

- (void)fetchProductList:(BOOL)loadMore {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"currencyType"] = @"2";
    param[@"token"] = [NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token];
    
    [_service loadDataWithParameters:param isLoadMore:loadMore completion:^(id result, id error) {
        
        if (_service.dataSource.count>0) {
            
            _tableView.tableHeaderView = _headerView;
            self.emptyView.hidden = YES;
        }else{
            
            [self.view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.tableView);
            }];
            _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        }
        
     
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - router Event

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        YSProduct *product = userInfo[kButtonDidClickRouterEvent];
        [YSProductService collectionProduct:product.productId completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"删除成功" toContainer:nil];
            
            [self.service.dataSource removeObject:product];
            [self.tableView reloadData];
        }];
    }
}


- (void)delectCollect:(NSString *)ID Type:(NSString *)type sourceType:(NSString *)sourceType{
    
    
    [JYTradingService fetchCollectCoinByID:ID type:type sourceType:sourceType completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"取消收藏成功" toContainer:self.view];
        [self fetchProductList:NO];
    }];
    
}

#pragma mark - tableView


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _service.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYMarketEditCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYMarketEditCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.product = _service.dataSource[indexPath.row];
    
    JYMarketModel *model = _service.dataSource[indexPath.section];
    cell.product = model;
    
    cell.MarketEditDelectCell = ^{
        //删除自选币种  -- 调用接口
        [self delectCollect:model.coinId Type:@"1" sourceType:model.type];
        
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}


/**
 *  完成一次从fromIndexPath cell到toIndexPath cell的移动
 */
- (void)tableView:(JXMovableCellTableView *)tableView didMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    
    //更新数据源
    JYMarketModel *model = _service.dataSource[fromIndexPath.section];
    WS(weakSelf);
    [JYMarketService UpdateCoinSortWithID:model.ID sort:toIndexPath.section completion:^(id result, id error) {
        [weakSelf fetchProductList:NO];
    }];
    
  
    
}


- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
    }
    return _emptyView;
}







@end
