//
//  YSProductDescViewController.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProductDescViewController.h"
#import "YSProductCommentViewController.h"
#import "YSUserCenterViewController.h"

#import "YSCommentTableViewCell.h"
#import "YSProductHeaderView.h"
#import "YSButton.h"
#import "YSDIYBackFooter.h"

#import "UINavigationBar+YSLucency.h"
#import "UIBarButtonItem+Sunday.h"

#import "YSProductService.h"

#import <MediaPlayer/MediaPlayer.h>
#import "YSImagesViewController.h"

#import "YSLoginGuidingViewController.h"

#import "YSProductFooterView.h"

@interface YSProductDescViewController ()

@property (nonatomic, strong) YSProductHeaderView *headerView;
@property (nonatomic, strong) YSProductFooterView *footerView;

@end

@implementation YSProductDescViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"点击图片展开" object:nil];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat alpha = scrollView.contentOffset.y / 200;
//    if (alpha >= 1) {
//        self.navigationController.navigationBar.translucent = NO;
//        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//        self.titleShow();
//    } else if (alpha <= 0){
//        self.navigationController.navigationBar.translucent = YES;
//        
//        //设置导航栏背景图片为一个空的image，这样就透明了
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//        //去掉透明后导航栏下边的黑边
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//        self.titleHidden();
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }

    self.navigationItem.title = @"商品详情";
    
    [self setupContentView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToImageController:) name:@"点击图片展开" object:nil];
}

#pragma mark - 跳转到大图页面
- (void)jumpToImageController:(NSNotification *)obj
{
    NSDictionary *dic = (NSDictionary *)obj.object;
    YSImagesViewController *vc = [[YSImagesViewController alloc]init];
    vc.dic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupContentView {
    
    WS(weakSelf);
    self.tableView.estimatedRowHeight = 100.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [self.tableView registerClass:[YSCommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView layoutIfNeeded];
    
    _headerView = [[YSProductHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 1000)];
#pragma mark - 收藏改变状态
    _headerView.changeState = ^(NSInteger tag) {
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            
            [YSProductService collectionProduct:weakSelf.detail.productId completion:^(id result, id error) {
                if (tag == 1) {
                    weakSelf.headerView.collectionButton.tag = 0;
                    [weakSelf.headerView.collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
                    [weakSelf.headerView.collectionButton setImage:[UIImage imageNamed:@"collect-normal"] forState:UIControlStateNormal];
                } else {
                    weakSelf.headerView.collectionButton.tag = 1;
                    [weakSelf.headerView.collectionButton setTitle:@"已收藏" forState:UIControlStateNormal];
                    [weakSelf.headerView.collectionButton setImage:[UIImage imageNamed:@"collect-pressed"] forState:UIControlStateNormal];
                }
            }];
            
        } else {
            [weakSelf judgeLoginActionWith:1];
        }
    };
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    YSDIYBackFooter *footer = [YSDIYBackFooter footerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.superViewController scrollToBottom];
    }];
    self.tableView.mj_footer = footer;
}

- (void)creatTableFooterView
{
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
    _footerView.jumpToOtherProduct = ^(NSString *productID) {
        YSProductDetailViewController *vc = [YSProductDetailViewController new];
        vc.productId = productID;
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableFooterView = _footerView;
}

- (void)setDetail:(YSProductDetail *)detail {
    _detail = detail;
    
    _headerView.detail = _detail;
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    [self creatTableFooterView];
    
    [self.tableView reloadData];
}

- (void)setDetailJJ:(JJShopModel *)detailJJ
{
    _detailJJ = detailJJ;
    
    _headerView.detailJJ = _detailJJ;
    [_headerView recalculateHeight];
    self.tableView.tableHeaderView = _headerView;
    
    [self creatTableFooterView];
    
    [self.tableView reloadData];
}

- (void)checkAllComment {
    YSProductCommentViewController *vc = [YSProductCommentViewController new];
    vc.productId = _detail.productId;
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - router Event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:kButtonDidClickRouterEvent]) {
        NSInteger type = [userInfo[kButtonDidClickRouterEvent] integerValue];
        if (type == 0) {
            //收藏
            
            if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
                
                [YSProductService collectionProduct:_detail.productId completion:^(id result, id error) {
                }];
                
            } else {
                [self judgeLoginActionWith:1];
            }
        }else if (type == 1) {
            //选择规格
            [self.nextResponder routerEventWithName:eventName userInfo:userInfo];
        }else if (type == 2) {
            //查看生活圈
            
            if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
                
                YSUserCenterViewController *vc = [YSUserCenterViewController new];
//                [vc setSelectedIndex:2];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else {
                [self judgeLoginActionWith:1];
            }
            
            
        }else if (type == 3) {
            YSProductImage *image = userInfo[@"model"];
            
            if (image.url && image.url.length > 0) {
                MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:image.url]];
                [self presentMoviePlayerViewControllerAnimated:player];
            }
        }
    }
}

//#pragma mark - tableView delegate
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [_detail.comments count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    YSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.comment = _detail.comments[indexPath.row];
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    if (!headerView) {
//        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
//        headerView.contentView.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *label = [UILabel new];
//        label.font = [UIFont systemFontOfSize:15];
//        label.textColor = HEX_COLOR(@"#333333");
//        label.text = @"用户评价";
//        [headerView.contentView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(headerView.contentView);
//            make.left.offset(10);
//        }];
//        
//        UILabel *countLabel = [UILabel new];
//        countLabel.font = [UIFont systemFontOfSize:15];
//        countLabel.textColor = HEX_COLOR(@"#666666");
//        countLabel.text = @"(0)";
//        countLabel.tag = 10;
//        [headerView.contentView addSubview:countLabel];
//        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(headerView.contentView);
//            make.left.equalTo(label.mas_right);
//        }];
//        
//        UILabel *goodlabel = [UILabel new];
//        goodlabel.font = [UIFont systemFontOfSize:15];
//        goodlabel.textColor = HEX_COLOR(@"#333333");
//        if (_detail.goodComment == NULL) {
////            goodlabel.text = @"暂无评价";
//        } else {
//            goodlabel.text = [NSString stringWithFormat:@"好评率 : %@%%", _detail.goodComment];
//        }
//        [headerView.contentView addSubview:goodlabel];
//        [goodlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.centerY.equalTo(headerView.contentView);
//            make.right.offset(-10);
//        }];
//    }
//    
//    UILabel *label = [headerView.contentView viewWithTag:10];
//    label.text = [NSString stringWithFormat:@"(%zd)", _detail.commentCount];
//    
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
//    if (!footerView) {
//        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footer"];
//        footerView.contentView.backgroundColor = [UIColor whiteColor];
//        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button jm_setCornerRadius:1 withBorderColor:HEX_COLOR(@"#f46b10") borderWidth:1];
//        [button setTitleColor:HEX_COLOR(@"#f46b10") forState:UIControlStateNormal];
//        [button setTitle:@"查看更多评论" forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button addTarget:self action:@selector(checkAllComment) forControlEvents:UIControlEventTouchUpInside];
//        [footerView addSubview:button];
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(footerView);
//            make.height.mas_equalTo(35);
//            make.width.mas_equalTo(110);
//        }];
//    }
//    
//    return footerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 50.f;
//}

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
