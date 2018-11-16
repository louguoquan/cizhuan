//
//  JJChooseViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJChooseViewController.h"
#import "JJChooseTableViewCell.h"
#import "CTChooseHeaderView.h"
@interface JJChooseViewController ()
@property (nonatomic,readwrite,strong) CTChooseHeaderView *headerView;
@property (nonatomic,readwrite,strong) NSArray *titles;
@end

@implementation JJChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setupUI];
}
- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"选砖";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}
- (void)setupUI{
    
    _titles = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.headView.mas_bottom);
        make.top.equalTo(self.view).with.offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(44);
    }];
    
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[JJChooseTableViewCell class] forCellReuseIdentifier:@"JJChooseTableViewCell"];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJChooseTableViewCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.backgroundColor = [UIColor redColor];
    cell.textLabel.text = @"text";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"    %@",_titles[section]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


#pragma mark --------------getters--------------
- (CTChooseHeaderView *)headerView{
    if (!_headerView) {
        CTChooseHeaderView *view = [CTChooseHeaderView new];
        view.backgroundColor = [UIColor whiteColor];
        view.frame  = CGRectMake(0, 0, self.view.width, 500);
        _headerView = view;
        
    }
    return _headerView;
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
