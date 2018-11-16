//
//  JJOrderViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJOrderViewController.h"
#import "JJOrderTableViewCell.h"
@interface JJOrderViewController ()

@end

@implementation JJOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setupUI];
}
- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"询价订单";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}
- (void)setupUI{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.headView.mas_bottom);
        make.top.equalTo(self.view).with.offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(50);
    }];
    
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[JJOrderTableViewCell class] forCellReuseIdentifier:@"JJOrderTableViewCell"];
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJOrderTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
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
