//
//  JYAssetsHomeViewController.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAssetsHomeViewController.h"
#import "JYAssetsHomeCell.h"
#import "JYC2CViewController.h"
#import "JYWithdrawController.h"
#import "JYChargeViewController.h"

#import "JYAssetsService.h"
#import "JYEmptyView.h"

@interface JYAssetsHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UILabel *navigationLabel;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UILabel *totalAssetsLabel;    //总资产
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)JYEmptyView *emptyView;

@end

@implementation JYAssetsHomeViewController


- (void)viewWillAppear:(BOOL)animated
{
    if ([JYAccountModel sharedAccount].token.length>0) {
        
        if (self.selectBtn.selected) {
            [self queryWithisHidden:1 page:1];
        }else{
            
            [self queryWithisHidden:0 page:1];
        }
        
        
    }else{
        self.totalAssetsLabel.text = @"0.00";
        self.emptyView.showString = @"";
        self.emptyView.loginBtn.hidden = NO;
        self.emptyView.iconImageView.hidden = YES;
        [self.view addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];
        self.emptyView.hidden = NO;
        self.tableView.hidden = YES;
    }
    
    
    /*
     
     tell application "Messages"
     set csvData to read "/Users/louguoquan/Desktop/test.csv"
     set csvEntries to paragraphs of csvData
     repeat with i from 1 to count csvEntries
     set phone to (csvEntries's item i)'s text
     set myid to get id of first service
     set theBuddy to buddy phone of service id myid
     send "今天北京晴，气温13到27度；周二晴，气温11到26度，北风3-4级；周三晴，气温11到24度，微风<3" to theBuddy
     end repeat
     end tell
     
     */
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setHeaderView];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    self.totalAssetsLabel.text = @"0.00";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:JYRecordVCPopRootVC object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillAppear:) name:@"timeOutLogin" object:nil];
}

- (void)setHeaderView{
    
    
    UIView *head = [UIView new];
    head.dk_backgroundColorPicker = DKColorPickerWithKey(NAVBG);
    [self.view addSubview:head];
    
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"总资产折合(CNY)";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:15];
    label1.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    [head addSubview:label1];
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"隐藏资产为0的币种";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:13];
    label2.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    [head addSubview:label2];
    
    [head addSubview:self.totalAssetsLabel];
    [head addSubview:self.selectBtn];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(16);
    }];
    
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head).offset(22);
        make.bottom.equalTo(head).offset(-13);
        make.width.height.mas_equalTo(31);
    }];
    
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.selectBtn);
        make.left.equalTo(self.selectBtn.mas_right).offset(4);
        make.height.mas_equalTo(13);
    }];
    
    [self.totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(19);
    }];
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom);
        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(IS_IPHONE_X?0:-30);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf queryWithisHidden:0 page:1];
    }];
    
}

- (void)setNav{
    
    _navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _navigationLabel.textAlignment = NSTextAlignmentCenter;
    _navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _navigationLabel;
    _navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    _navigationLabel.text = @"资产";
    
}

- (void)reloadTableView
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)queryWithisHidden:(NSInteger)isHidden page:(NSInteger)page{
    
    
    [MBProgressHUD showLoadingToContainer:self.view];
    
    [JYAssetsService fetchMyCoins:isHidden page:page completion:^(id result, id error) {
        
        
        [MBProgressHUD dismissForContainer:self.view];
        NSDictionary *dict = result;
        NSArray *array = [JYAssetsModel mj_objectArrayWithKeyValuesArray:dict[@"result"]];
        
        if (page == 1) {
            self.dataArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray arrayWithArray:array];
        }else{
            [self.dataArray addObjectsFromArray:array];
        }
        
        if (self.dataArray.count == 0) {
            self.tableView.hidden = YES;
            self.emptyView.showString = @"暂无数据";
            self.emptyView.loginBtn.hidden = YES;
            self.emptyView.iconImageView.hidden = NO;
            [self.view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.tableView);
            }];
        }else{
            self.emptyView.hidden = YES;
            self.tableView.hidden = NO;
        }
        
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.totalAssetsLabel.text = [NSString stringWithFormat:@"%@",dict[@"totalBalance"]];
    }];
}

- (void)select:(UIButton *)btn{
    
    
    
    if ([JYAccountModel sharedAccount].token.length==0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:JYTokenExpiredReLogin object:self];
        return;
    }
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [self queryWithisHidden:1 page:1];
    }else{
        [self queryWithisHidden:0 page:1];
    }
    
    
}

-(UILabel *)totalAssetsLabel
{
    if (!_totalAssetsLabel) {
        _totalAssetsLabel = [UILabel new];
        _totalAssetsLabel.textAlignment = NSTextAlignmentCenter;
        _totalAssetsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        _totalAssetsLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    }
    return _totalAssetsLabel;
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [UIButton new];
        [_selectBtn setImage:[UIImage imageNamed:@"xuanze"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [_selectBtn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[JYAssetsHomeCell class] forCellReuseIdentifier:@"JYAssetsHomeCell"];
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
    
    JYAssetsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYAssetsHomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.row = indexPath.section;
    
    JYAssetsModel *model = _dataArray[indexPath.section];
    
    cell.model = model;
    cell.C2CClick = ^{
        
        
        JYC2CViewController *vc = [[JYC2CViewController alloc]init];
        
        if (model.c2cStatus.integerValue == 0) {
            vc.isStop = @"YES";
        }
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.WithdrawalClick = ^{//提币
        
        if (model.withdrawStatus.integerValue == 1) {
            
            JYWithdrawController *vc = [[JYWithdrawController alloc]init];
            vc.asModel = model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [MBProgressHUD showText:@"暂停提币" toContainer:self.view];
            
        }
        
        
        
    };
    
    cell.TopUpClick = ^{//充币
        
        if (model.chargeStatus.integerValue == 1) {
            
            JYChargeViewController *vc = [[JYChargeViewController alloc]init];
            vc.asModel = model;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [MBProgressHUD showText:@"暂停充币" toContainer:self.view];
            
        }
    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    head.backgroundColor = [UIColor clearColor];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (JYEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[JYEmptyView alloc]init];
    }
    return _emptyView;
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
