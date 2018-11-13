//
//  YSCateProductViewController.m
//  PXH
//
//  Created by yu on 2017/8/2.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateProductViewController.h"
#import "YSProductDetailViewController.h"
#import "YSOrderService.h"
#import "YSProductTableViewCell.h"
#import "SDEmptyView.h"
#import "YSPagingListService.h"
#import "YSProductService.h"

@interface YSCateProductViewController ()
{
    UIView *brandsView;
    UIButton *selectBtn;
    NSInteger page;
}
@property (nonatomic, strong) YSPagingListService   *service;
@property (nonatomic, strong) NSMutableArray *brandsArray;
@property (nonatomic, assign) NSInteger selectBtnTag;
@property (nonatomic, strong) SDEmptyView *emptyView;
@property (nonatomic, strong) NSString *brandID;
@end

@implementation YSCateProductViewController

- (YSPagingListService *)service {
    if (!_service) {
        _service = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchProductList:page:completion:)];
    }
    return _service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    self.selectBtnTag = 999;
    [self setupTableView];
    self.brandsArray = [NSMutableArray array];
    [self fetchProductListWithLoadMore:NO];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sort:) name:@"分类筛选" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(brandsChange) name:@"品牌切换" object:nil];
}

- (void)sort:(NSNotification *)noti
{
    _sort = noti.object;
    if (_sort.integerValue != 5 && _sort.integerValue != 6) {
        [self.tableView.mj_header beginRefreshing];
        brandsView.hidden = YES;
    } else {
        if (_sort.integerValue == 5) {
            [self creatBrandsView];
        } else {
            [brandsView setHidden:YES];
        }
    }
}

- (void)setupTableView {

    self.tableView.rowHeight = 144.f;
//    [self.tableView registerClass:[YSProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:NO];
    }];
    
    
}

- (void)fetchProductListWithLoadMore:(BOOL)loadMore {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    parameters[@"catId"] = _cateId;
    if (_sort.integerValue == 0) {
        _sort = @"1";
    }

    if (_sort.integerValue >= 1 && _sort.integerValue <= 4) {
        
    } else {
        if (_brandsArray.count != 0) {
            YSBrands *brands = _brandsArray[self.selectBtnTag];
            self.brandID = brands.ID;
          
        }
    }
    parameters[@"brandId"] = self.brandID;
    
    parameters[@"sort"] = _sort;
   
    
    WS(weakSelf);
    if (loadMore == YES) {
        page++;
    } else {
        page = 1;
    }
    [self.service loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
//        NSMutableArray *product = [NSMutableArray array];
//        [product addObjectsFromArray:result];
//        [self.emptyView setHidden:YES];
        [self.emptyView removeFromSuperview];
        if (_service.dataSource.count != 0) {
            self.tableView.hidden = NO;
            [self.tableView reloadData];
            
            if (_service.dataSource.count == 10 * page) {
                self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf fetchProductListWithLoadMore:YES];
                }];
            } else {
                self.tableView.mj_footer = nil;
            }
            
            
        } else {
            self.tableView.hidden = YES;
            [self creatEmptyView];
        }
        
        
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self fetchData];
}

- (void)fetchData
{
    [YSProductService fetchBrands:_cateId completion:^(id result, id error) {
        [_brandsArray removeAllObjects];
        [_brandsArray addObjectsFromArray:result];
        if (_brandsArray.count != 0) {
            [_brandsArray addObject:@"全部"];
        }
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_service.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cells = @"cells";
    YSProductTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[YSProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
    }
    
//    YSProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.product = _service.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addShopCart = ^(NSString *ID) {
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            [self addShopCarts:ID];
        } else {
            [self judgeLoginActionWith:1];
        }
    };
    return cell;
}

- (void)addShopCarts:(NSString *)ID
{
    [YSOrderService addProductToShoppingCart:ID standardId:nil number:1 completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    YSProduct *product = _service.dataSource[indexPath.row];
    vc.productId = product.productId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建品牌页面
- (void)creatBrandsView
{
    if (!brandsView) {
        brandsView = [[UIView alloc]initWithFrame:self.tableView.frame];
        brandsView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        [self.view addSubview:brandsView];
        [self.view bringSubviewToFront:brandsView];
        
        CGFloat whiteHeight = 0;
        CGFloat buttonHeight = 40;
        if (_brandsArray.count % 2 == 0) {
            whiteHeight = _brandsArray.count / 2 * buttonHeight;
        } else {
            whiteHeight = (_brandsArray.count / 2 + 1) * buttonHeight;
        }
        UIView *white = [UIView new];
        white.backgroundColor = [UIColor whiteColor];
        [brandsView addSubview:white];
        [white mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.offset(0);
            make.height.mas_equalTo(whiteHeight);
            
        }];
        
        for (int i = 0 ; i < _brandsArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(20 + (ScreenWidth / 2 - 20) * (i % 2), buttonHeight * (i / 2), ScreenWidth / 2 - 20, buttonHeight);
            button.tag = i;
            if (selectBtn && self.selectBtnTag == i) {
                [button setTitleColor:HEX_COLOR(@"#ef5454") forState:0];
            } else {
                [button setTitleColor:HEX_COLOR(@"#333333") forState:0];
            }
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [white addSubview:button];
            [button addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            YSBrands *brands = _brandsArray[i];
            if (i != _brandsArray.count - 1) {
                [button setTitle:brands.name forState:0];
            } else {
                [button setTitle:_brandsArray[i] forState:0];
            }
        }
    }
    brandsView.hidden = NO;
}

- (void)selectBtnAction:(UIButton *)sender
{
    [selectBtn setTitleColor:HEX_COLOR(@"#333333") forState:0];
    selectBtn = sender;
    self.selectBtnTag = sender.tag;
    [selectBtn setTitleColor:HEX_COLOR(@"#ef5454") forState:0];
    [brandsView setHidden:YES];
    NSString *brandName;
    if (sender.tag == _brandsArray.count - 1) {
        _sort = @"1";
        _brandID = nil;
        brandName = _brandsArray[sender.tag];
    } else {
        YSBrands *brands =_brandsArray[sender.tag];
        brandName = brands.name;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"选择品牌" object:brandName];
    [self.tableView.mj_header beginRefreshing];
}

- (void)brandsChange
{
    brandsView.hidden = YES;
    _sort = @"1";
}



- (void)creatEmptyView
{
    self.emptyView = [[SDEmptyView alloc]initWithFrame:self.tableView.frame];
    self.emptyView.userInteractionEnabled = YES;
    self.emptyView.imageName = @"empty";
    self.emptyView.text = @"暂无数据";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.emptyView addGestureRecognizer:tap];
    
    [self.view addSubview:_emptyView];
    [self.view sendSubviewToBack:_emptyView];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    
    [self fetchProductListWithLoadMore:NO];
    
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
