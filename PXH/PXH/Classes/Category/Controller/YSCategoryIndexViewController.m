//
//  YSCategoryViewController.m
//  PXH
//
//  Created by yu on 2017/7/31.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCategoryIndexViewController.h"
#import "YSCateProductPageViewController.h"

#import "YSCateTableViewCell.h"
#import "YSCateCollectionViewCell.h"

#import "YSCateService.h"

@interface YSCategoryIndexViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, copy)   NSArray       *dataSource;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation YSCategoryIndexViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchAllCategoryList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectIndex = 0;
    
    [self initSubviews];
    [self fetchAllCategoryList];
}

- (void)initSubviews {
    
    [self.view addSubview:self.tableView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.view addSubview:self.collectionView];
    
    WS(weakSelf);
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf.view);
        make.width.mas_equalTo(80);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.tableView.mas_right);
    }];
}

- (void)fetchAllCategoryList {
    [YSCateService fetchAllCate:^(id result, id error) {
        _dataSource = result;
        
        [self.tableView reloadData];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
//        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

        if ([_dataSource count] > 0) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YSCategory *category = _dataSource[indexPath.row];
    
    YSCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.category = category;
    cell.layoutMargins = UIEdgeInsetsZero;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndex = indexPath.row;
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath) {
        YSCategory *category = _dataSource[indexPath.row];
        return category.children.count;
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    YSCategory *category = _dataSource[index.row];
    cell.category = category.children[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YSCateProductPageViewController *vc = [YSCateProductPageViewController new];
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    YSCategory *category = _dataSource[index.row];
    vc.title = category.name;
    vc.dataSource = category.children;
    vc.pageIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - view

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        
        _tableView.rowHeight = 45.f;
        [_tableView registerClass:[YSCateTableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((kScreenWidth - 85) / 3.0, 115.f);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[YSCateCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
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
