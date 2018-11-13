//
//  YSShoppingCartViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSShoppingCartViewController.h"
#import "YSConfirmOrderViewController.h"

#import "YSCartProductTableViewCell.h"
#import "YSButton.h"

#import "YSProductService.h"
#import "YSOrderService.h"
#import "SDEmptyView.h"

#import "YSLoginGuidingViewController.h"
#import "YSProductDetailViewController.h"
#import "YSProductFooterView.h"


@interface YSShoppingCartViewController ()

@property (nonatomic, strong) YSButton  *checkAllButton;

@property (nonatomic, strong) UILabel   *totalPriceLabel;

@property (nonatomic, strong) NSMutableArray   *dataSource;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) SDEmptyView *emptyView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong)YSProductFooterView *footerView;


@property (nonatomic, strong) YSProductDetail   *detail;


@end

@implementation YSShoppingCartViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
        
        self.index = 10000;
        
        [self setupTableView];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeProductNum:) name:@"改变数量" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeProductNum1:) name:@"购物车改变数量" object:nil];
        
    } else {
        [self judgeLoginActionWith:1];
    }
    
    [self creatTableFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        [self fetchProductList];
        [self fetchProductNum];
    } else {
        [self judgeLoginActionWith:1];
    }
}

- (void)setupTableView {
    
    self.tableView.rowHeight = 110.f;
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    [self.tableView registerClass:[YSCartProductTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchProductList];
    }];

}

- (void)createBottomView {
    self.bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button jm_setCornerRadius:2 withBackgroundColor:MAIN_COLOR];
    [button setTitle:@"结算" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(settlement) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.offset(-10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(90);
    }];
    
    _checkAllButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    [_checkAllButton setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
    [_checkAllButton setImage:[UIImage imageNamed:@"check-pressed"] forState:UIControlStateSelected];
    _checkAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _checkAllButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_checkAllButton setTitle:@"全选" forState:UIControlStateNormal];
    _checkAllButton.space = 10;
    [_checkAllButton addTarget:self action:@selector(checkAll) forControlEvents:UIControlEventTouchUpInside];
    [_checkAllButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    [_bottomView addSubview:_checkAllButton];
    [_checkAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.offset(0);
    }];

    WS(weakSelf);
    _totalPriceLabel = [UILabel new];
    _totalPriceLabel.font = [UIFont systemFontOfSize:13];
    _totalPriceLabel.textColor = HEX_COLOR(@"#666666");
    _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    _totalPriceLabel.text = @"0.00";
    [_bottomView addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(button.mas_left).offset(-10);
        make.left.equalTo(weakSelf.checkAllButton.mas_right).offset(10);
    }];
}

- (void)checkAll {
    if ([self.dataSource count] <= 0) {
        return;
    }
    self.checkAllButton.selected = !self.checkAllButton.selected;
    
    [self.dataSource setValue:@(self.checkAllButton.selected) forKey:@"selected"];
    
    [self.tableView reloadData];
    
    [self calculateCartData];
}

//修改数量
- (void)changeProductNum:(NSNotification *)noti
{
    self.index = [noti.object integerValue];
    [self fetchProductNum];
}

//修改数量
- (void)changeProductNum1:(NSNotification *)noti
{

    [self fetchProductNum];
}


- (void)calculateCartData {
    
    CGFloat totalPrice = 0;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.selected == (YES)"];
    NSArray *result = [self.dataSource filteredArrayUsingPredicate:predicate];
    if (result.count == 0) {
        _checkAllButton.selected = NO;
    }else {
        if (result.count == [self.dataSource count]) {
            _checkAllButton.selected = YES;
        }
        
        for (YSCartProduct *product in result) {
            totalPrice += (product.price * product.num);
        }
    }
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"总金额:"]; //1、总金额 2、总价 3、总金额
    NSAttributedString *appendString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f",totalPrice] attributes:@{NSForegroundColorAttributeName:MAIN_COLOR, NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [attString appendAttributedString:appendString];
    _totalPriceLabel.attributedText = attString;
}

//结算
- (void)settlement {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.selected == (YES)"];
    NSArray *result = [self.dataSource filteredArrayUsingPredicate:predicate];
    if (result.count <= 0) {
        [MBProgressHUD showInfoMessage:@"请选择商品" toContainer:nil];
        return;
    }
    
    NSString *catIds = [[result valueForKey:@"carId"] componentsJoinedByString:@","];
    [MBProgressHUD showLoadingText:@"正在结算" toContainer:nil];
    [YSOrderService commitOrderFromCart:catIds completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:nil];
        YSConfirmOrderViewController *vc = [YSConfirmOrderViewController new];
        vc.model = result;
        vc.cartIds = catIds;
        vc.type = YSCreateOrderTypeShoppingCart;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

//获取购物车产品
- (void)fetchProductList {
    
    [YSProductService fetchCartProductList:^(id result, id error) {
        if (result) {
            [self.dataSource removeAllObjects];
            [_bottomView removeFromSuperview];
            [self.dataSource addObjectsFromArray:result];
            [_emptyView setHidden:YES];
            if (self.dataSource.count != 0) {
                self.tableView.hidden = NO;
                [self.tableView reloadData];
                [self createBottomView];
            } else {
                self.tableView.hidden = YES;
                [self creatEmptyView];
            }
            
        }
        [self.tableView.mj_header endRefreshing];
        
        [self calculateCartData];
    }];
}

- (void)fetchProductNum
{
    [YSProductService fetchCartProductNum:^(id result, id error) {
       
        NSString *num = [result description];
        if (num.integerValue != 0) {
            self.tabBarItem.badgeValue = num;
        } else {
            self.tabBarItem.badgeValue = nil;
        }
    }];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        YSCartProduct *product = userInfo[@"model"];
            //修改数量
        if (type == 1) {
            BOOL isIncrement = [userInfo[@"isIncrement"] boolValue];
            CGFloat count = isIncrement ? 1 : -1;
            [YSProductService updateCartProductCount:count carId:product.carId completion:^(id result, id error) {
                if (result) {
                    product.num += count;
                    [self calculateCartData];
                    
                }
                [self.tableView reloadData];
            }];
        }else if (type == 2){
            
            [self deleteConfirm:product];
            
        } else {
            //购物车页面的数量刷新
            NSInteger productNum = [userInfo[@"productNum"] integerValue];
#warning 暂时不需要
//            NSInteger index = [userInfo[@"index"] integerValue];
//            product.num = productNum;
            CGFloat count = productNum - product.num;
            [YSProductService updateCartProductCount:count carId:product.carId completion:^(id result, id error) {
                if (result) {
                    product.num = productNum;
                    [self calculateCartData];
                }
                [self.tableView reloadData];
            }];
        }
        
    }
}

- (void)deleteConfirm:(YSCartProduct *)product
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否删除产品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //删除商品
        [YSProductService deleteCartProduct:product.carId completion:^(id result, id error) {
            [self.dataSource removeObject:product];
            [self.tableView reloadData];
            if (self.dataSource.count == 0) {
                self.tableView.hidden = YES;
                [self creatEmptyView];
            }
            [self calculateCartData];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
        }];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)creatTableFooterView
{
    
    [YSProductService fetchProductDetail:@"1" completion:^(id result, id error) {
        _detail = result;
        
        CGFloat height = 0;
            if (_detail.products.count > 3) {
                height = 2 * (ScreenWidth / 3 + 73);
            } else if (_detail.products.count <= 3 && _detail.products > 0) {
                height = ScreenWidth / 3 + 73;
            } else {
                height = 0;
            }
        _footerView = [[YSProductFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height + 40)];
            _footerView.detail = _detail;
        
        MMWeakify(self);
        _footerView.jumpToOtherProduct = ^(NSString *productID) {
            MMStrongify(self);
            YSProductDetailViewController *vc = [YSProductDetailViewController new];
            vc.productId = productID;
            [self.navigationController pushViewController:vc animated:YES];
        };
        self.tableView.tableFooterView = _footerView;
        
    }];
    
    
 
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YSCartProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.product = _dataSource[indexPath.row];
    cell.indexPath = indexPath.row;
    cell.checkAction = ^(NSInteger tag) {
        YSCartProduct *product = _dataSource[indexPath.row];
        product.selected = !product.selected;
        
        [self.tableView reloadData];
        
        [self calculateCartData];
    };
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSCartProduct *product = _dataSource[indexPath.row];
    
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    vc.productId = product.productId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatEmptyView
{
    if (!_emptyView) {
        self.emptyView = [[SDEmptyView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 124)];
        self.emptyView.imageName = @"empty";
        self.emptyView.text = @"暂无数据 ";
        [self.view addSubview:_emptyView];
    }
    _emptyView.hidden = NO;
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
