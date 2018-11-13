//
//  JYCountryController.m
//  PXH
//
//  Created by LX on 2018/6/15.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYCountryController.h"

#import "JYMineService.h"

@interface JYCountryController ()

@property (nonatomic, strong) NSArray   *indexArr;

@property (nonatomic, strong) NSDictionary *countryInfoDic;

@end

@implementation JYCountryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCountryList];
    
    [self setUpNav];
    [self setUpTableView];
}

- (void)setUpNav
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    navigationLabel.text = @"选择地区";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = navigationLabel;
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(NAVTEXT);
}

- (void)setUpTableView
{
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = UIView.new;
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(TABLEBG);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(TABLEBG);
    
    //索引
//    self.tableView.dk_sectionIndexColorPicker = DKColorPickerWithKey(TRADINGDetailHead);
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCountryList];
    }];
}

- (void)getCountryList
{
    WS(weakSelf)
    [JYMineService getCountryListCompletion:^(id result, id error) {
        weakSelf.countryInfoDic = (NSDictionary *)result;
        weakSelf.indexArr = [weakSelf.countryInfoDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];//升序
            //return [obj2 compare:obj1]//降序
        }];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [self.countryInfoDic objectForKey:self.indexArr[section]];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell_ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCell_ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(CELLTITLE);
    }
    
    NSArray *arr = [self.countryInfoDic objectForKey:self.indexArr[indexPath.section]];
    cell.textLabel.text = [arr[indexPath.row] objectForKey:@"name"];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _indexArr[section];
}

//索引标题
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArr;
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    for (UIView *view in [tableView subviews]) {
        //设置索引字体
        if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
            // 设置字体大小
            [view setValue:[UIFont systemFontOfSize:15] forKey:@"_font"];
            //设置view的大小
            view.bounds = CGRectMake(0, 0, 30, view.height);
            [view setBackgroundColor:[UIColor clearColor]];
            //单单设置其中一个是无效的
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [self.countryInfoDic objectForKey:self.indexArr[indexPath.section]];
    NSString *country = [arr[indexPath.row] objectForKey:@"name"];
    NSString *Id = [arr[indexPath.row] objectForKey:@"id"];
    
    !_selectEndBlock?:_selectEndBlock(country, Id);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
