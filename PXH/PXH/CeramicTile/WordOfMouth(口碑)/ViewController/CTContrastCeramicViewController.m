//
//  CTContrastCeramicViewController.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTContrastCeramicViewController.h"
#import "CTContrastProductCell.h"

@interface CTContrastCeramicViewController ()

@end

@implementation CTContrastCeramicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"口碑对比";
    
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    head.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"添加瓷砖" forState:0];
    [btn setTitleColor:HEX_COLOR(@"#417DF9") forState:0];
    [btn setBackgroundColor:HEX_COLOR(@"#EAF2FE")];
    btn.layer.borderColor = HEX_COLOR(@"#417DF9").CGColor;
    [btn setImage:[UIImage imageNamed:@"iconjia"] forState:0];
    btn.layer.borderWidth = 0.5;
    [head addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(head).offset(10);
        make.height.mas_offset(60);
        make.right.equalTo(head).offset(-10);
    }];
    self.tableView.tableHeaderView = head;
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[CTContrastProductCell class] forCellReuseIdentifier:@"CTContrastProductCell"];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    
    UIButton *bottom = [[UIButton alloc]init];
    bottom.backgroundColor = HEX_COLOR(@"#417DF9");
    [bottom setTitle:@"开始对比" forState:0];
    [bottom setTitleColor:[UIColor whiteColor] forState:0];
    bottom.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.mas_offset(60);
        make.left.right.equalTo(self.view);
    }];

    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTContrastProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTContrastProductCell"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    sectionView.backgroundColor = HEX_COLOR(@"#F9F4F8");
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"推荐对比瓷砖";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = HEX_COLOR(@"#333333");
    [sectionView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView).offset(10);
        make.centerY.equalTo(sectionView);
        make.height.mas_offset(20);
    }];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 40;
}

@end
