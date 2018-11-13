//
//  YSProvinceViewController.m
//  PXH
//
//  Created by 刘鹏程 on 2017/11/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProvinceViewController.h"
#import "YSCityViewController.h"
//#import "YSLocationService.h"
#import "SDLocationView.h"
#import "YSRegion.h"

#define YSCITY_PATH   [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"province.archiver"]
#define YSCITYSECTIONS_PATH   [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"provinceSections.archiver"]

@interface YSProvinceViewController ()<SDLocationViewDelegate>

@property (nonatomic, strong) NSMutableArray  *dataSource;

@property (nonatomic, strong) NSMutableArray  *sectionTitles;

@property (nonatomic, assign) BOOL      isLoaded;

@property (nonatomic, strong)SDLocationView *locationView;

@property (nonatomic, strong)NSString *currentCity;

@end

@implementation YSProvinceViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)sectionTitles {
    if (!_sectionTitles) {
        _sectionTitles = [NSMutableArray array];
    }
    return _sectionTitles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择省份";
    
    _currentCity = @"";
    [self setupTabelView];
    
    if (!_isLoaded) {
        [self.tableView.mj_header beginRefreshing];
    }else {
        self.dataSource = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:YSCITY_PATH]];
        self.sectionTitles = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:YSCITYSECTIONS_PATH]];
        if ((self.dataSource.count != self.sectionTitles.count) || (self.dataSource.count <= 0)) {
            [self.tableView.mj_header beginRefreshing];
        }
    }
}

- (void)updateLocation {
//    [[YSLocationService sharedService] getCity:^(id result, id error) {
//        
//        self.currentCity = (NSString *)result;
//        [self.locationView.currentButton setTitle:[NSString stringWithFormat:@"当前:%@", self.currentCity] forState:0];
//        if (![_currentCity isEqualToString:@""]) {
////            if (self.block) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"更改地址" object:_currentCity];
////            }
//        }
//    }];
}

- (void)setupTabelView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    
    self.tableView.sectionIndexColor = HEX_COLOR(@"#333333");
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self tableHeaderView];
    //开始定位
    [self updateLocation];
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchCityList];
    }];
}

- (void)tableHeaderView
{
    self.locationView = [[SDLocationView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60.0f)];
    self.locationView.delegate = self;
    self.tableView.tableHeaderView = self.locationView;
}



- (void)fetchCityList
{
    WS(weakSelf);
    [MBProgressHUD showLoadingText:@"正在获取省份列表" toContainer:self];
    
    [[SDDispatchingCenter sharedCenter] GET:kAllProvince_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MBProgressHUD dismissForContainer:weakSelf];
        
        NSArray *result = responseObject[@"result"];
        NSArray *array = [YSRegion mj_objectArrayWithKeyValuesArray:result];
        [self sortDataArray:array];
        
        _isLoaded = YES;
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:weakSelf];
    }];
}

- (void)sortDataArray:(NSArray *)cityList
{
    [self.dataSource removeAllObjects];
    [self.sectionTitles removeAllObjects];
    
    //建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    NSInteger highSection = [self.sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //按首字母分组
    for (YSRegion *city in cityList) {
        
        NSString *firstLetter = [self transform:city.name];
        firstLetter = firstLetter.length <= 0 ? @" " : firstLetter;
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:city];
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(YSRegion *obj1, YSRegion *obj2) {
            
            NSString *firstLetter1 = [self transform:obj1.name];
            firstLetter1 = [firstLetter1 uppercaseString];
            
            NSString *firstLetter2 = [self transform:obj2.name];
            firstLetter2 = [firstLetter2 uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    //去掉空的section
    for (NSInteger i = [sortedArray count] - 1; i >= 0; i--) {
        NSArray *array = [sortedArray objectAtIndex:i];
        if ([array count] == 0) {
            [sortedArray removeObjectAtIndex:i];
            [self.sectionTitles removeObjectAtIndex:i];
        }
    }
    
    [self.dataSource addObjectsFromArray:sortedArray];
    
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:YSCITY_PATH];
    [NSKeyedArchiver archiveRootObject:self.sectionTitles toFile:YSCITYSECTIONS_PATH];
}

- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return [pinyin uppercaseString];
}

#pragma mark - tableView  delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
    YSRegion *city = array[indexPath.row];
    cell.textLabel.text = city.name;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = HEX_COLOR(@"#333333");
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else {
        cell.contentView.backgroundColor = HEX_COLOR(@"#fafafa");
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _sectionTitles;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
    YSRegion *city = array[indexPath.row];

    YSCityViewController *vc = [YSCityViewController new];
    vc.provinceId = city.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

// 定位
- (void)headerViewDidClickLocationButton:(SDLocationView *)headerView; {
    [headerView updateCurrentCity:@"定位中"];
    [self updateLocation];
}

- (void)headerViewReturnBack
{
    if (self.block) {
        self.block(_currentCity);
    }
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
