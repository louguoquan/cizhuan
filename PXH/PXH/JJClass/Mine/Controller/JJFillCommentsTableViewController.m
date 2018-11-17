//
//  JJFillCommentsTableViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/16.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJFillCommentsTableViewController.h"

@implementation JJFillCommentsTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupUI];
}
- (void)setupUI{
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
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

#pragma mark --------------delegate--------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [NSString stringWithFormat:@"    使用感受"];
    }
    return [NSString stringWithFormat:@"    评分描述"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
@end
