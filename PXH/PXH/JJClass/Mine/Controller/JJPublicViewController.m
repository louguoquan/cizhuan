//
//  JJPublicViewController.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJPublicViewController.h"
#import "JJPublicTableViewCell.h"
@interface JJPublicViewController ()

@end

@implementation JJPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self setupUI];
}
- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"我的发表";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
    
}
- (void)setupUI{
    NSArray *buttons = @[@"口碑",@"主贴",@"回复",@"工程"];
    CGFloat btnWidth = (self.view.width - 5*20)/4;
    for (int i = 0; i<buttons.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+i*(btnWidth+20), 0, btnWidth, 50);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:buttons[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
   
    
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.headView.mas_bottom);
        make.top.equalTo(self.view).with.offset(50);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(50);
    }];
    
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[JJPublicTableViewCell class] forCellReuseIdentifier:@"JJPublicTableViewCell"];
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJPublicTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
