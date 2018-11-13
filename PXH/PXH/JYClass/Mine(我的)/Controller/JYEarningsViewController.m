//
//  JYEarningsViewController.m
//  PXH
//
//  Created by louguoquan on 2018/6/8.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYEarningsViewController.h"
#import "JYEarningsCell.h"
#import "JYCommissionCell.h"
#import "JYMineService.h"

@interface JYEarningsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *cuurentBtn;
@property(nonatomic,strong)UIView *head;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataArrayM;

@end

@implementation JYEarningsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    self.dataArrayM = [NSMutableArray array];
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"我的收益";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
    
    self.page = 1;
    
    UIView *topView = [UIView new];
    topView.layer.cornerRadius = 3.0f;
    topView.layer.masksToBounds = YES;
    topView.layer.borderWidth = 0.5f;
    topView.layer.borderColor = HEX_COLOR(@"#2CA6D8").CGColor;
    
    [self.containerView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(30);
        make.left.equalTo(self.containerView).offset(50);
        make.right.equalTo(self.containerView).offset(-50);
        make.height.mas_offset(40);
        make.bottom.equalTo(self.containerView);
        
    }];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"邀请记录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = 100;
    btn.backgroundColor = HEX_COLOR(@"#2CA6D8");
    [btn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
    [btn setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateSelected];
    btn.selected = YES;
    [topView addSubview:btn];
    
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"返佣记录" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    btn1.tag = 101;
    btn1.backgroundColor = HEX_COLOR(@"#ffffff");
    [btn1 setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
    [btn1 setTitleColor:HEX_COLOR(@"#ffffff") forState:UIControlStateSelected];
    [topView addSubview:btn1];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.left.equalTo(topView);
        make.width.equalTo(btn1);
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.right.equalTo(topView);
        make.left.equalTo(btn.mas_right);
    }];
    self.cuurentBtn = btn;
    
    
    _head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    UILabel *label = [UILabel new];
    label.text = @"被邀请人账号";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = HEX_COLOR(@"#567395");
    [_head addSubview:label];
    
    UILabel *label1 = [UILabel new];
    label1.text = @"邀请时间";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = HEX_COLOR(@"#567395");
    [_head addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"状态";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = HEX_COLOR(@"#567395");
    [_head addSubview:label2];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_head).offset(10);
        make.centerY.equalTo(_head);
        make.height.mas_offset(20);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_head);
        make.centerY.equalTo(_head);
        make.height.mas_offset(20);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_head).offset(-10);
        make.centerY.equalTo(_head);
        make.height.mas_offset(20);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    
    self.tableView.tableHeaderView = _head;
    
    [self queryMineInviteList];
    
}


- (void)queryMineInviteList{
    
    [JYMineService fetchRecListWithPage:self.page completion:^(id result, id error) {
        NSArray *array = result;
        if (self.page == 1) {
            self.dataArray = [NSMutableArray array];
            self.dataArray = [NSMutableArray arrayWithArray:array];
        }else{
            [self.dataArray addObjectsFromArray:array];
        }
        [self.tableView reloadData];
    }];
}


- (void)queryMoneyRecordList{
    
    [JYMineService fetchMyInvitingWithPage:self.page completion:^(id result, id error) {
        
        NSArray *array = result;
        
        if (self.page == 1) {
            self.dataArrayM = [NSMutableArray array];
            self.dataArrayM = [NSMutableArray arrayWithArray:array];
        }else{
            [self.dataArrayM addObjectsFromArray:array];
        }
        [self.tableView reloadData];
    }];
}

- (void)click:(UIButton *)btn{
    
    
    self.cuurentBtn.selected = !self.cuurentBtn.selected;
    
    btn.selected = !btn.selected;
    
    if (self.cuurentBtn != btn) {
        if (btn.selected) {
            btn.backgroundColor = HEX_COLOR(@"#2CA6D8");
            self.cuurentBtn.backgroundColor = HEX_COLOR(@"#ffffff");
            
            
            self.page = 1;
            
            if (btn.tag == 100) {
                self.tableView.tableHeaderView = _head;
                
                [self queryMineInviteList];
            }else{
                self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
                [self queryMoneyRecordList];
            }
            
            
            
        }else{
            btn.backgroundColor = HEX_COLOR(@"#ffffff");
            self.cuurentBtn.backgroundColor = HEX_COLOR(@"#2CA6D8");
        }
        
    }
    
    self.cuurentBtn = btn;
    
    
    [self.tableView reloadData];
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cuurentBtn.tag == 100) {
        return self.dataArray.count;
    }
    return self.dataArrayM.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cuurentBtn.tag == 100) {
        JYEarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYEarningsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArray.count) {
            cell.model = self.dataArray[indexPath.row];
        }
        return cell;
    }
    
    JYCommissionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JYCommissionCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArrayM.count) {
        cell.model = self.dataArrayM[indexPath.row];
    }
    return cell;
    
    
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[JYEarningsCell class] forCellReuseIdentifier:@"JYEarningsCell"];
        [_tableView registerClass:[JYCommissionCell class] forCellReuseIdentifier:@"JYCommissionCell"];
        
    }
    return _tableView;
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
