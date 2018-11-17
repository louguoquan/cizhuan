//
//  JJFillMessageTableViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/16.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJFillMessageTableViewController.h"
#import "JJHistoryTableViewCell.h"
@interface JJFillMessageTableViewController()
@property (nonatomic,readwrite,strong) NSArray *titles;
@end
@implementation JJFillMessageTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI{
    
    _titles = @[@"购买砖型",@"瓷砖用于",@"购买价",@"购买时间",@"购买地区",@"购买门店",@"购买颜色",@"满意度"];
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [self footerView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.headView.mas_bottom);
        make.top.equalTo(self.view).with.offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
- (UIView *)footerView{
    UIView *view = [UIView new];
    view.frame   = CGRectMake(0, 0, self.view.width, 200);
    
    UILabel *label = [UILabel new];
    label.text     = @"《瓷砖之家口碑规范》";
    label.frame    = CGRectMake(0, 20, self.view.width, 20);
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, label.bottom + 30, self.view.width - 40, 50);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(nextBtnEventClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}
- (void)nextBtnEventClick{
    !_selNextBlock?:_selNextBlock();
}
#pragma mark --------------delegate--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"    瓷砖信息"];
}

@end
