//
//  YSNewIndexController.m
//  PXH
//
//  Created by futurearn on 2018/3/31.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSNewIndexController.h"
#import "YSProductService.h"
#import "YSPCSort.h"
#import "YSCateService.h"
#import "YSSeckillProduct.h"
#import "YSNewIndexTableCell.h"
#import "YSIndexTableHeaderView.h"
#import "YSSeckillViewController.h"
#import "YSProductDetailViewController.h"
#import "YSSeckillViewController.h"
#import "YSCateProductPageViewController.h"
#import "YSIndexCateTableViewController.h"
#import "YSOrderService.h"
@interface YSNewIndexController ()

@property (nonatomic, strong) YSIndexTableHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *limitCountProducts;
@property (nonatomic, strong) NSMutableArray *banners;
@property (nonatomic, strong) NSMutableArray *pc;
@property (nonatomic, strong) NSDictionary *resultDic;
@property (nonatomic, strong) NSString *qgtu;
@end

@implementation YSNewIndexController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self creatTableHeaderView];
    
    self.tableView.estimatedRowHeight = 60;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(productDetail:) name:@"首页点选" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addshopCart:) name:@"首页加入购物车" object:nil];
    
    [self fetchIndexData];
    
    
    // Do any additional setup after loading the view.
}

//首页加入购物车
- (void)addshopCart:(NSNotification *)noti
{
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        [self addShopCarts:noti.object];
    } else {
        [self judgeLoginActionWith:1];
    }
   
}

- (void)addShopCarts:(NSString *)ID
{
    [YSOrderService addProductToShoppingCart:ID standardId:nil number:1 completion:^(id result, id error) {
        [MBProgressHUD showSuccessMessage:@"添加成功" toContainer:nil];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"购物车改变数量" object:nil];
    }];
}

- (void)creatTableHeaderView
{
    _headerView = [[YSIndexTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 350.0 / 750.0)];
    self.tableView.tableHeaderView = _headerView;
}

#pragma mark - network

- (void)fetchIndexData {
    
    self.limitCountProducts = [NSMutableArray array];
    self.pc = [NSMutableArray array];
    self.banners = [NSMutableArray array];
    [YSProductService fetchIndexNewDataWithCompletion:^(id result, id error) {
        self.resultDic = (NSDictionary *)result;
        self.banners = [YSAdvertising mj_objectArrayWithKeyValuesArray:_resultDic[@"banners"]];
        self.pc = [YSPCSort mj_objectArrayWithKeyValuesArray:_resultDic[@"pc"]];
        self.limitCountProducts = [YSSeckillProduct mj_objectArrayWithKeyValuesArray:_resultDic[@"limitCountProducts"]];
        self.qgtu = _resultDic[@"qgtu"];
        [_headerView setAdvArray:_banners productArray:nil];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 + self.pc.count;
}

//根据分类展示数据的行数
- (CGFloat)returnCountWithArrayCount:(NSInteger)arrayCount limit:(BOOL)limit
{
    NSInteger count = 0;
    //普通分类最多限制为6个数据
    if (limit == YES) {
        if (arrayCount < 4 && arrayCount > 0) {
            count = 1;
        } else if (arrayCount == 0) {
            count = 0;
        } else {
            count = 2;
        }
    }
    if (limit == NO) {
        if (arrayCount % 3 == 0) {
            count = arrayCount / 3;
        } else {
            count = arrayCount / 3 + 1;
        }
    }
    CGFloat height = count * (ScreenWidth / 3 + 73);
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [self returnCountWithArrayCount:_limitCountProducts.count limit:YES];
    } else {
        YSPCSort *sort = _pc[indexPath.section - 1];
        height = [self returnCountWithArrayCount:sort.products.count limit:YES];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_resultDic[@"qgtu"] && ![_resultDic[@"qgtu"] isEqualToString:@""]) {
            return ScreenWidth / 3;
        }
        return 0;
    }
    YSPCSort *sort = _pc[section - 1];
    if (sort.products.count == 0) {
        return 0;
    }
    return ScreenWidth / 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 3)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    NSString *url;
    NSInteger count = 0;
    if (section == 0) {
        count = self.limitCountProducts.count;
        url = _resultDic[@"qgtu"];
    } else {
        YSPCSort *sort = self.pc[section - 1];
//        /2017/12/227d75e2-73ac-4027-bfbc-5e0ad190559a.jpg
        url = [NSString stringWithFormat:@"http://mobile.zjpxny.com/file%@", sort.logo];
        count = sort.products.count;
    }
    if (count != 0) {
        UIImageView *bannerImage = [[UIImageView alloc]initWithFrame:sectionView.frame];
        bannerImage.userInteractionEnabled = YES;
        bannerImage.tag = section;
        bannerImage.contentMode = UIViewContentModeScaleAspectFit;
        [bannerImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kPlaceholderImage];
        [sectionView addSubview:bannerImage];
        
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpToProduct:)];
        [bannerImage addGestureRecognizer:tapAction];
    }else{
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];

    }
    
    
//    [moreBtn addTarget:self action:@selector(jumpToProduct:) forControlEvents:UIControlEventTouchUpInside];

    
//    UILabel *sectionName = [UILabel new];
//    sectionName.font = [UIFont systemFontOfSize:15];
//    sectionName.textAlignment = NSTextAlignmentCenter;
//    [sectionView addSubview:sectionName];
//    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(sectionView);
//    }];
//    if (section == 0) {
//        sectionName.text = @"限量抢购";
//    } else {
//        YSPCSort *sort = _pc[section - 1];
//        sectionName.text = sort.name;
//    }
//
//    UIView *leftlineView = [UIView new];
//    leftlineView.backgroundColor = HexColor(0xcccccc);
//    [sectionView addSubview:leftlineView];
//    [leftlineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(sectionName.mas_left).offset(-10);
//        make.centerY.mas_equalTo(sectionName);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(1);
//    }];
//
//    UIView *rightlineView = [UIView new];
//    rightlineView.backgroundColor = HexColor(0xcccccc);;
//    [sectionView addSubview:rightlineView];
//    [rightlineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(sectionName.mas_right).offset(10);
//        make.centerY.mas_equalTo(sectionName);
//        make.width.height.mas_equalTo(leftlineView);
//    }];
//
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moreBtn setTitle:@"更多" forState:0];
//    [moreBtn setTitleColor:HexColor(0x333333) forState:0];
//    moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [moreBtn setImage:[UIImage imageNamed:@"more-right"] forState:0];
//    moreBtn.tag = section;
//
//    CGFloat imageWidth = moreBtn.imageView.bounds.size.width;
//    CGFloat titleWidth = moreBtn.titleLabel.bounds.size.width;
//
//    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + 18, 0, -titleWidth - 18);
//    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - 18, 0, imageWidth + 18);
//    [sectionView addSubview:moreBtn];
//    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(sectionName);
//        make.right.offset(-15);
//    }];
    
    return sectionView;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSNewIndexTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[YSNewIndexTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"INDEXTB"];
    }
    cell.section = indexPath.section;
    if (indexPath.section == 0) {
        cell.limitArray = self.limitCountProducts;
    } else {
        YSPCSort *sort = self.pc[indexPath.section - 1];
        cell.limitArray = (NSMutableArray *)sort.products;
    }
    
    return cell;
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

- (void)productDetail:(NSNotification *)noti
{
    NSDictionary *dic = (NSDictionary *)noti.object;
    NSString *productId;
    if ([dic[@"section"] integerValue] == 0) {
        YSSeckillProduct *seckill = dic[@"product"];
        productId = seckill.productId;
    } else {
        NSDictionary *productDic = dic[@"product"];
        productId = productDic[@"id"];
    }
    YSProductDetailViewController *vc = [YSProductDetailViewController new];
    vc.productId = productId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToProduct:(UITapGestureRecognizer *)sender
{
    NSLog(@"跳转到第%ld个产品", (long)sender.view.tag);
    if (sender.view.tag == 0) {
        [self.navigationController pushViewController:[YSSeckillViewController new] animated:YES];
    } else {
//        YSPCSort *sort = _pc[sender.tag - 1];
//        YSIndexCateTableViewController *product = [YSIndexCateTableViewController new];
//        product.catID = sort.catId;
//        [self.navigationController pushViewController:product animated:YES];
        
        YSCateProductPageViewController *vc = [YSCateProductPageViewController new];
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        
        
        YSPCSort *category = self.pc[sender.view.tag - 1];
        
//        [MBProgressHUD showLoadingText:@"正在获取数据" toContainer:nil];
        [YSCateService fetchChildCate:category.catId completion:^(NSArray *result, id error) {
            [MBProgressHUD dismissForContainer:nil];
            NSString *name;
            NSInteger selectIndex = 0;
            if (result.count > 0) {
                
                for (int i = 0; i < result.count; i++) {
                    YSCategory *dic = result[i];
                    if (dic.ID.integerValue == category.catId.integerValue) {
                        name = dic.name;
                        selectIndex = i;
                    }
                }
                YSCateProductPageViewController *vc = [YSCateProductPageViewController new];
                vc.dataSource = result;
                if (name == nil) {
                    vc.title = category.name;
                } else {
                    vc.title = name;
                }
                
                vc.pageIndex = selectIndex;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];

////        YSCategory *category = _dataSource[index.row];
//        vc.title = category.name;
//        vc.dataSource = category.products;
//        vc.pageIndex = sender.view.tag - 1;
//        [self.navigationController pushViewController:vc animated:YES];
        
//        NSString *select = [NSString stringWithFormat:@"%ld", sender.view.tag];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"切换视图" object:select];
    }
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
