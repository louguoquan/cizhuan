//
//  YSProductSearchViewController.m
//  PXH
//
//  Created by yu on 2017/8/24.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductSearchViewController.h"
#import "YSProductDetailViewController.h"
#import "YSOrderService.h"
#import "YSProductTableViewCell.h"
#import "YSNavTitleView.h"
#import "YSProductService.h"
#import "YSPagingListService.h"

@interface YSProductSearchViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL pirceState;

@property (nonatomic, strong) UIView    *sliderView;

@property (nonatomic, assign) NSInteger searchType;

@property (nonatomic, copy)   NSString  *keyWord;

@property (nonatomic, strong) YSPagingListService   *service;

@end

@implementation YSProductSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _service = [[YSPagingListService alloc] initWithTargetClass:[YSProductService class] action:@selector(fetchProductList:page:completion:)];
    self.pirceState = YES;
    [self setupNavTitleView];
    [self setupContentView];
    
    [self fetchProductListWithLoadMore:NO];
}

- (void)setupNavTitleView {
    
    YSNavTitleView *titleView = [[YSNavTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) type:2];
    titleView.searchAllProductBlock = ^(NSString *name) {
        
        self.keyWord = name;
        [self.tableView.mj_header beginRefreshing];
    };
    self.navigationItem.titleView = titleView;
    
//    UITextField *tf = [UITextField new];
//    tf.backgroundColor = HEX_COLOR(@"#f0f0f0");
//    tf.returnKeyType = UIReturnKeySearch;
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
//    imageView.contentMode = UIViewContentModeCenter;
//    imageView.size = CGSizeMake(30, 30);
//    tf.leftView = imageView;
//    tf.leftViewMode = UITextFieldViewModeAlways;
//    tf.delegate = self;
//    [titleView addSubview:tf];
//    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(titleView);
//        make.height.equalTo(@30);
//        make.left.offset(0);
//        make.right.offset(-44);
//    }];
}

- (void)setupContentView {
    
    UIView *segmentView = [UIView new];
    [self.view addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat itemWidth = kScreenWidth / 3.0;
    NSArray *array = @[@"综合排序", @"销量", @"价格"];
    for (NSInteger i = 0; i < array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
        [segmentView addSubview:button];
        [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
            
            self.searchType = i;
            
            [_sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset(i * itemWidth + (itemWidth - 60) / 2.0);
            }];
            if (button.tag == 2) {
                if (self.pirceState == YES) {
                    self.searchType = 2;
                    self.pirceState = NO;
                } else {
                    self.searchType = 3;
                    self.pirceState = YES;
                }
            }
            
            [self.tableView.mj_header beginRefreshing];
            
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(itemWidth * i);
            make.width.mas_equalTo(itemWidth);
            make.top.bottom.offset(0);
        }];
    }
    
    self.searchType = 0;
    
    _sliderView = [UIView new];
    _sliderView.backgroundColor = MAIN_COLOR;
    [segmentView addSubview:_sliderView];
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((itemWidth - 60) / 2.0);
        make.bottom.offset(0);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(60);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    self.tableView.rowHeight = 144.f;
//    [self.tableView registerClass:[YSProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableFooterView = [UIView new];
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:NO];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf fetchProductListWithLoadMore:YES];
    }];
}

- (void)fetchProductListWithLoadMore:(BOOL)loadMore {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:1];
    parameters[@"keyword"] = _keyWord;
    parameters[@"sort"] = @(_searchType + 1);
    [self.service loadDataWithParameters:parameters isLoadMore:loadMore completion:^(id result, id error) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    [textField resignFirstResponder];
//    
//    self.keyWord = textField.text;
//
//    [self.tableView.mj_header beginRefreshing];
//    
//    return YES;
//}

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
    cell.addShopCart = ^(NSString *ID) {
        [YSOrderService addProductToShoppingCart:ID standardId:nil number:1 completion:^(id result, id error) {
            [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
        }];
    };
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    YSProduct *product = _service.dataSource[indexPath.row];
    vc.productId = product.productId;
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
