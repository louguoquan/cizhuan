//
//  YSProfileViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProfileViewController.h"
#import "YSMemberInfoViewController.h"
#import "YSWalletViewController.h"
#import "YSRecommendViewController.h"
#import "YSOrderPageViewController.h"
#import "YSDistributionSitesViewController.h"
#import "YSOrderTableViewController.h"
#import "YSWebViewController.h"

#import "YSButton.h"
#import "YSNavigationBar.h"

#import "UIScrollView+YSHeaderScaleImage.h"
#import "YSOrderService.h"
#import "NSDictionary+Sunday.h"

#import "YSLoginGuidingViewController.h"

@interface YSProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView    *logo;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *tagLabel;

@property (nonatomic, strong) NSMutableArray    *btnArray;

@property (nonatomic, strong) NSArray   *menuClasses;

@property (nonatomic, strong) YSNavigationBar   *navigationBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger loginType;

@property (nonatomic, strong)UIImageView *shadowImage;


@end

@implementation YSProfileViewController

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self createHeaderView];
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.loginType = 1;
            [_tableView.mj_header beginRefreshing];
            [self fetchOrderCount];
            [self setupHeaderData];
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        }];
    }
}

- (void)createHeaderView {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    headerView.backgroundColor = MAIN_COLOR;
    
    WS(weakSelf);
    _logo = [UIImageView new];
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.layer.cornerRadius = 35;
    _logo.clipsToBounds = YES;
    if (self.loginType == 0) {
        _logo.image = kPlaceholderImage;
    }
    [headerView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(70);
        make.left.offset(10);
        make.bottom.offset(-20);
    }];
    
    UIImageView *nextImageView = [UIImageView new];
    nextImageView.image = [UIImage imageNamed:@"more_white"];
    nextImageView.contentMode = UIViewContentModeCenter;
    [headerView addSubview:nextImageView];
    [nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_logo);
        make.right.offset(-10);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"未登录";
    [headerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo).offset(5);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(nextImageView.mas_left).offset(-10);
    }];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:14];
    _tagLabel.textColor = MAIN_COLOR;
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    if (_loginType == 0) {
        _tagLabel.hidden = YES;
    }
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    tap.cancelsTouchesInView = NO;
    [tap addActionBlock:^(id sender) {
        
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            YSMemberInfoViewController *vc = [YSMemberInfoViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            [self judgeLoginActionWith:1];
        }
        
    }];
    [headerView addGestureRecognizer:tap];
    
    self.tableView.tableHeaderView = headerView;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.tableView.tableFooterView = view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *orderView = [self createOrderOptView];
        return orderView;
    } else {
        UIView *menuView = [self createMenuView];
        return menuView;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 115;
    } else {
        return 290;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cells = @"userCenter";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
    }
    cell.backgroundColor = BACKGROUND_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _shadowImage = [self makeClearNavigationController];

//    [self initSubviews];
    
    [self buildNavigationView];

    [self creatTableView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.loginType = 0;
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        self.loginType = 1;
        [self fetchOrderCount];
        [self setupHeaderData];
    }
    _shadowImage.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
}

#if 0
- (void)initSubviews {
    
    self.scrollView.ys_headerScaleImage = [UIImage imageWithColor:MAIN_COLOR size:CGSizeMake(kScreenWidth, 150)]; //150
    self.scrollView.ys_headerScaleImageHeight = 150;
    self.scrollView.backgroundColor = BACKGROUND_COLOR;
    
    UIView *headerView = [self createHeaderView];
    [self.containerView addSubview:headerView];
    
    UIView *orderOptView = [self createOrderOptView];
    [self.containerView addSubview:orderOptView];
    
    UIView *menuView = [self createMenuView];
    [self.containerView addSubview:menuView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(86);
    }];
    
    [orderOptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(115);
    }];
    
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderOptView.mas_bottom).offset(10);
        make.left.right.offset(0);
        //        make.bottom.offset(-100);
        make.bottom.offset(-30);
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stateRefresh:) name:@"订单状态刷新" object:nil];
    
}

#endif

#pragma mark - 订单状态刷新
- (void)stateRefresh:(NSNotification *)noti
{
    [self fetchOrderCount];
}

- (void)setupHeaderData {
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        _tagLabel.hidden = NO;
        self.loginType = 1;
        [YSAccountService fetchUserInfoWithCompletion:^(id result, id error) {
            [_logo sd_setImageWithURL:[NSURL URLWithString:[YSAccount sharedAccount].logo] placeholderImage:kPlaceholderImage];
            _nameLabel.text = [YSAccount sharedAccount].nickName;
            _tagLabel.text = [YSAccount sharedAccount].isVip ? @"品行会员" : @"普通会员";
        }];
    }
}

- (void)buildNavigationView {
    
    self.navigationItem.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
//    去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //设置按钮
    [self bulidSettingButton];
}

- (void)bulidSettingButton
{
    UIButton *settingButton = [UIButton buttonWithType:0];
    settingButton.frame = CGRectMake(0, 0, 20, 20);
    settingButton.userInteractionEnabled = YES;
    [settingButton setBackgroundImage:[UIImage imageNamed:@"set"] forState:0];
    [settingButton addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingButton];
}

- (void)setting:(id)sender {
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        Class aclass = NSClassFromString(@"YSSetupViewController");
        UIViewController *vc = [[aclass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self judgeLoginActionWith:1];
    }
    
}

#pragma mark - 9个按钮点击事件
- (void)menuAction:(YSButton *)button {
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        if (button.tag == 5) {
            //客服
            YSWebViewController *vc = [YSWebViewController new];
            vc.urlString = kCustomerService_URL;
            vc.title = @"客服";
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            NSString *className = self.menuClasses[button.tag];
            Class aclass = NSClassFromString(className);
            UIViewController *vc = [[aclass alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [self judgeLoginActionWith:1];
    }
}

#pragma mark - 订单的点击事件
- (void)checkOrder:(UIButton *)button {
    
    if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
        if (button.tag != 5) {
            YSOrderPageViewController *vc = [YSOrderPageViewController new];
            vc.pageIndex = button.tag + 1;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            YSOrderTableViewController *vc = [YSOrderTableViewController new];
            vc.pageIndex = 6;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [self judgeLoginActionWith:1];
    }
}

    //获取订单数量
- (void)fetchOrderCount {
    
    [YSOrderService fetchOrderCountWithCompletion:^(id result, id error) {
        for (NSInteger i = 0; i < _btnArray.count; i ++) {
            YSButton *button = _btnArray[i];
            switch (i) {
                case 0:
                    [button setBadgeValue:[result integerValueForKey:@"waitPayCount" default:0]];
                    break;
                case 1:
                    [button setBadgeValue:[result integerValueForKey:@"waitSendCount" default:0]];
                    break;
                case 2:
                    [button setBadgeValue:[result integerValueForKey:@"waitConfirmCount" default:0]];
                    break;
                case 3:
                    [button setBadgeValue:[result integerValueForKey:@"waitSinceCount" default:0]];
                    break;
                case 4:
                    [button setBadgeValue:[result integerValueForKey:@"waitCommentCount" default:0]];
                    break;
                case 5:
                    [button setBadgeValue:[result integerValueForKey:@"waitRefundCount" default:0]];
                    break;

                default:
                    break;
            }
        }
    }];
    
}

#pragma mark - view

#if 0
- (UIView *)createHeaderView {
    
    UIView *headerView = [UIView new];
    
    WS(weakSelf);
    _logo = [UIImageView new];
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.layer.cornerRadius = 35;
    _logo.clipsToBounds = YES;
    [headerView addSubview:_logo];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(70);
        make.left.offset(10);
        make.centerY.equalTo(headerView);
    }];
    
    UIImageView *nextImageView = [UIImageView new];
    nextImageView.image = [UIImage imageNamed:@"more_white"];
    nextImageView.contentMode = UIViewContentModeCenter;
    [headerView addSubview:nextImageView];
    [nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.offset(-10);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];
//    _nameLabel.text = @"名字";
    [headerView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo).offset(5);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.lessThanOrEqualTo(nextImageView.mas_left).offset(-10);
    }];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:14];
    _tagLabel.textColor = MAIN_COLOR;
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
//        make.right.lessThanOrEqualTo(nextImageView.mas_left).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    tap.cancelsTouchesInView = NO;
    [tap addActionBlock:^(id sender) {
        
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            YSMemberInfoViewController *vc = [YSMemberInfoViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            [self judgeLoginActionWith:1];
        }
        
    }];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

#endif


- (UIView *)createOrderOptView {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    cell.ys_titleFont = [UIFont systemFontOfSize:15];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_title = @"我的订单";
    cell.ys_contentTextAlignment = NSTextAlignmentRight;
    cell.ys_contentFont = [UIFont systemFontOfSize:11];
    cell.ys_contentTextColor = HEX_COLOR(@"#999999");
    cell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
    cell.ys_text = @"查看全部订单";
    cell.ys_bottomLineHidden = NO;
    [cell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        
        if (USER_ID && ![USER_Mobile isEqualToString:@""]) {
            [weakSelf.navigationController pushViewController:[YSOrderPageViewController new] animated:YES];

        } else {
            [self judgeLoginActionWith:1];
        }
    }];
    [view addSubview:cell];
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(35);
    }];
    
    _btnArray = [NSMutableArray array];
    NSArray *array = @[@"待付款", @"待发货", @"待收货", @"待提货", @"待评价", @"退款售后"];
    for (NSInteger i = 0; i < 6; i ++) {
        YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
        button.space = 10;
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"user_order_%zd", i]] forState:UIControlStateNormal];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(checkOrder:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [_btnArray addObject:button];
    }
    [_btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    return view;
}

- (UIView *)createMenuView {

    
    UIView *view = [UIView new];
    
    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    cell.backgroundColor = [UIColor whiteColor];
    cell.ys_titleFont = [UIFont systemFontOfSize:15];
    cell.ys_titleColor = HEX_COLOR(@"#333333");
    cell.ys_title = @"我的服务";
    cell.ys_bottomLineHidden = NO;
    [view addSubview:cell];
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(35);
    }];
    
    CGFloat itemWidth = (kScreenWidth - 2.f) / 3.0;
    CGFloat itemHeight = 85.f;
    NSArray *nameArrray = @[@"我的钱包", @"我的卡券", @"我要推荐", @"会员中心", @"我的收藏", @"我的客服", @"我的地址", @"配送点", @"签到积分"];
    for (NSInteger i = 0; i < 9; i ++) {
        
        NSInteger x = i % 3;
        NSInteger y = i / 3;
        
        YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
        button.tag = i;
        [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"user_opt_%zd", i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
        [button setTitle:nameArrray[i] forState:UIControlStateNormal];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset((itemWidth + 1.f) * x);
            make.top.equalTo(cell.mas_bottom).offset((itemHeight + 1.f) * y);
            make.height.mas_equalTo(itemHeight);
            make.width.mas_equalTo(itemWidth);
        }];
    }
    return view;
}

#pragma mark - getter

- (NSArray *)menuClasses {
    if (!_menuClasses) {
        
        _menuClasses = @[@"YSWalletViewController", @"YSCouponsPageViewController", @"YSRecommendViewController", @"YSUserCenterViewController", @"YSProductCollectionViewController", @"UIViewController", @"YSAddressViewController", @"YSDistributionSitesViewController", @"YSSignInViewController"];
        
    }
    return _menuClasses;
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
