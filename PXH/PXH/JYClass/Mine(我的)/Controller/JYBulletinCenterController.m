//
//  JYBulletinCenterController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBulletinCenterController.h"

@interface JYBulletinCenterController (){
    
    NSArray  *_titleArr;
    NSArray *_detailArr;
}


@end

@implementation JYBulletinCenterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setupTableView];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"公告中心";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{
    _titleArr = @[@"关于5月1日起调整净值奖励额度公告", @"关于5月1日起调整净值奖励额度公告", @"关于5月1日起调整净值奖励额度公告"];
    _detailArr = @[@"2018-04-28 14:00:58", @"2018-04-28 14:00:58", @"2018-04-28 14:00:58"];
    
    self.tableView.estimatedRowHeight = 65.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13.f]];
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(CELLDETAILTEXT);
    
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.detailTextLabel.text = _detailArr[indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
