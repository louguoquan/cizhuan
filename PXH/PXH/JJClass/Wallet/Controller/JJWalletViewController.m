//
//  JJWalletViewController.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJWalletViewController.h"
#import "JJWalletCell.h"
#import "JJTransferLocalViewController.h"
#import "JJCoinInOrOutViewController.h"
#import "JJCoinInOrCoinOutListViewController.h"


@interface JJWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)JJWalletBaseModel *model;

@property (nonatomic,strong)UILabel *totalAssetsLabel;    //总资产
@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,assign)NSInteger page;

@end

@implementation JJWalletViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [self query];
}

- (void)viewDidLoad {
    
    
    [self setUpNav];
    [self setHeaderView];
}

- (void)setHeaderView{
    
    
    self.page = 1;
    
    UIView *head = [UIView new];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.view addSubview:head];
    
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"总资产(CNY)";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:15];
    label1.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    [head addSubview:label1];
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"站内互转";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15];
    label2.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    [head addSubview:label2];
    
    label2.hidden = YES;
    self.selectBtn.hidden = YES;
    
    [head addSubview:self.totalAssetsLabel];
    [head addSubview:self.selectBtn];
    
    
    [self.totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head).offset(15);
        //        make.left.equalTo(head).offset(20);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(head);
    }];
    
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalAssetsLabel.mas_bottom).offset(20);
        //        make.left.equalTo(self.totalAssetsLabel);
        make.centerX.equalTo(head);
        make.height.mas_equalTo(16);
    }];
    
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(head).offset(-30);
        make.bottom.equalTo(head).offset(-30);
        make.width.height.mas_equalTo(60);
    }];
    
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).offset(5);
        make.centerX.equalTo(self.selectBtn);
        make.height.mas_equalTo(16);
    }];
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom);
        make.left.right.equalTo(self.view);
        //        make.bottom.equalTo(self.view).offset(IS_IPHONE_X?0:-30);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
    self.totalAssetsLabel.text = @"0.0";
    
    
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [weakSelf query];
    }];
    
}

- (void)query{
    
    if (self.page == 1) {
        self.dataArray = [NSMutableArray array];
    }
    [MBProgressHUD showLoadingToContainer:self.view];
    
    [JJWalletService JJMyCoinsWithPage:self.page Completion:^(id result, id error) {
        
        
        [MBProgressHUD dismissForContainer:self.view];
        self.model = result;
        
        self.dataArray = [NSMutableArray arrayWithArray:self.model.infoCoin];
        self.totalAssetsLabel.text = [NSString stringWithFormat:@"≈%@",self.model.totaFoid];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"钱包";
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
    [selectBtn setTitle:@"交易记录" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selctViewShow:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *selectBtn1 = [[UIButton alloc]init];
    selectBtn1.frame = CGRectMake(0, 0, 80, 35);
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:selectBtn1];
    self.navigationItem.leftBarButtonItem = rightItem1;
    selectBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectBtn1 setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateNormal];
    [selectBtn1 setTitle:@"站内互转" forState:UIControlStateNormal];
    [selectBtn1 addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selctViewShow:(UIButton *)btn{
    
    JJCoinInOrCoinOutListViewController *vc = [[JJCoinInOrCoinOutListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)select:(UIButton *)btn{
    
    JJTransferLocalViewController *vc = [[JJTransferLocalViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 60;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[JJWalletCell class] forCellReuseIdentifier:@"JJWalletCell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJWalletCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count) {
        JJWalletModel *model = self.dataArray[indexPath.section];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJWalletModel *model = self.model.infoCoin[indexPath.section];
    JJCoinInOrOutViewController *vc = [[JJCoinInOrOutViewController alloc]init];
    vc.hidesBottomBarWhenPushed   = YES;
    vc.coinName = model.coinCode;
    vc.model = model;
//    if (!self.model.machopen&&[model.coinCode isEqualToString:CoinNameChange]) {
//        [MBProgressHUD showText:@"暂不开放" toContainer:self.view];
//    }else{
       [self.navigationController pushViewController:vc animated:YES];
//    }

}

-(UILabel *)totalAssetsLabel
{
    if (!_totalAssetsLabel) {
        _totalAssetsLabel = [UILabel new];
        _totalAssetsLabel.textAlignment = NSTextAlignmentCenter;
        _totalAssetsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:34];
        _totalAssetsLabel.textColor = GoldColor;
    }
    return _totalAssetsLabel;
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [UIButton new];
        [_selectBtn setImage:[UIImage imageNamed:@"JJ_zhuanzhang"] forState:UIControlStateNormal];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_selectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
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
