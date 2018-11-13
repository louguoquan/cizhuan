//
//  JJCardEditViewController.m
//  PXH
//
//  Created by louguoquan on 2018/9/4.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCardEditViewController.h"
#import "JJCardListCell.h"
#import "JJCheckInViewController.h"
#import "JJCheckOutViewController.h"
#import "JJShopService.h"

@interface JJCardEditViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIButton *submitBtn;

@property (nonatomic,strong)UILabel *comeLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *statusLabel;

@end

@implementation JJCardEditViewController

- (void)viewWillAppear:(BOOL)animated
{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (UILabel *)comeLabel
{
    if (!_comeLabel) {
        _comeLabel = [[UILabel alloc]init];
        _comeLabel.font = [UIFont systemFontOfSize:18];
        _comeLabel.textColor = HEX_COLOR(@"#333333");
        _comeLabel.textAlignment = NSTextAlignmentCenter;
        _comeLabel.text = @"来源";
    }
    return _comeLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:18];
        _numberLabel.textColor = HEX_COLOR(@"#333333");
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.text = @"序列号";
    }
    return _numberLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:18];
        _statusLabel.textColor = HEX_COLOR(@"#333333");
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.text = @"状态";
    }
    return _statusLabel;
}



- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]init];
    }
    return _headView;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"绑定全部" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
        _submitBtn.backgroundColor = GoldColor;
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        
        [_submitBtn addTarget:self action:@selector(bingdAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    [self setUpNav];
    
    [self.tableView registerClass:[JJCardListCell class] forCellReuseIdentifier:@"JJCardListCell"];
    
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
    [self setHeadAndBottomViewUI];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf query];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf query];
    }];
    [self query];
}

- (void)setHeadAndBottomViewUI{
    
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    [self.headView addSubview:self.comeLabel];
    [self.headView addSubview:self.numberLabel];
    [self.headView addSubview:self.statusLabel];
    
    
    [self.comeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView);
        make.width.mas_offset(kScreenWidth/3.0f);
        make.centerY.equalTo(self.headView);
        make.top.equalTo(self.headView).offset(15);
        make.bottom.equalTo(self.headView).offset(-15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comeLabel.mas_right);
        make.width.mas_offset(kScreenWidth/3.0f);
        make.centerY.equalTo(self.headView);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right);
        make.width.mas_offset(kScreenWidth/3.0f);
        make.centerY.equalTo(self.headView);
    }];
    
    
    
    
    
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
}

- (void)bingdAll{
    
    [MBProgressHUD showLoadingText:@"全部绑定中" toContainer:self.view];
    [JJShopService JJMobileCardBindAllCompletion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:self.view];
        
        [self query];
    }];
    
    
}

- (void)query{
    
    if (self.page == 1) {
        self.dataArray = [NSMutableArray array];
    }
    
    [MBProgressHUD showLoadingToContainer:self.view];
    [JJShopService  JJMobileCardList:@"0" Completion:^(id result, id error) {
        [MBProgressHUD dismissForContainer:self.view];
        if (self.page == 1) {
            self.dataArray = [NSMutableArray arrayWithArray:result];
        }else{
            [self.dataArray addObjectsFromArray:result];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"算力卡";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:selectBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectBtn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn setTitle:@"绑定记录" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selctViewShow:(UIButton *)btn{
    
    JJCheckInViewController *vc = [[JJCheckInViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJCardListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJCardListModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        cell.JJCardListCellClick = ^() {
            
            MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"温馨提示" detail:@"是否确认绑定" items:@[MMItemMake(@"取消", MMItemTypeNormal, nil), MMItemMake(@"确定", MMItemTypeHighlight, ^(NSInteger index) {
                
                [MBProgressHUD showLoadingText:@"绑定中" toContainer:self.view];
                [JJShopService JJMobileCardBind:model.ID Completion:^(id result, id error) {
                    
                    [MBProgressHUD dismissForContainer:self.view];
                    
                    [self query];
                    
                }];
                
            })]];
            [alertView show];
            
        
        };
    }
    return cell;
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
