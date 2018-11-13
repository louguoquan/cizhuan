//
//  JYSystemSetupController.m
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYSystemSetupController.h"

#import "JYSheetView.h"

@interface JYSystemSetupController (){
    
    NSArray  *_titleArr;
    NSArray *_detailArr;
}

@end

@implementation JYSystemSetupController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNav];
    [self setupTableView];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"账号认证";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setupTableView
{
    _titleArr = @[@"显示模式", @"涨跌幅", @"语言"];
    
    if ( [[JYDefaultDataModel sharedDefaultData].isRose isEqualToString:@"NO"]) {
        _detailArr = @[@"日间模式", @"红涨绿跌", @"简体中文"];
    }else{
        [JYDefaultDataModel sharedDefaultData].isRose = @"YES";
        _detailArr = @[@"日间模式", @"绿涨红跌", @"简体中文"];
    }
    
    
    
    self.tableView.estimatedRowHeight = 51.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:13.f]];
    cell.detailTextLabel.dk_textColorPicker = DKColorPickerWithKey(CELLDETAILTEXT);
    //    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.detailTextLabel.text = _detailArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = @[@"日间模式", @"夜间模式", @"取消"];
    if (indexPath.row==1) {
        arr = @[@"红涨绿跌", @"绿涨红跌", @"取消"];
    }
    else if (indexPath.row == 2) {
        arr = @[@"简体中文", @"English", @"取消"];
    }
    
    JYSheetView *typeView = [[JYSheetView alloc] initWithItemTitleArray:arr selTypeBlock:^(NSString *type, NSInteger idx) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = type;
        
        if ([type isEqualToString:@"红涨绿跌"]) {
            JYDefaultDataModel *model= [JYDefaultDataModel sharedDefaultData];
            model.isRose = @"NO";
            [JYDefaultDataModel saveDefaultData:model];
        }else if ([type isEqualToString:@"绿涨红跌"]){
            JYDefaultDataModel *model= [JYDefaultDataModel sharedDefaultData];
            model.isRose = @"YES";
            [JYDefaultDataModel saveDefaultData:model];
            
        }
    }];
    typeView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
    
    
    [typeView show];
}


@end
