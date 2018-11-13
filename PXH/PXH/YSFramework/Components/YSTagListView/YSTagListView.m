//
//  YSTagListView.m
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTagListView.h"
#import "YSTagViewCell.h"
#import "YSTagHeaderView.h"

#import "YSTagListLayout.h"

@interface YSTagListView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, copy)   YSCompleteHandler block;

@property (nonatomic, copy)   NSArray   *standardArray;

@end

@implementation YSTagListView

- (void)dealloc
{
    [_collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (instancetype)initWithStandardArray:(NSArray *)standardArray changeHandler:(YSCompleteHandler)block {
    self = [super init];

    if (self) {
        self.standardArray = standardArray;
        self.block = block;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    YSTagListLayout *layout = [[YSTagListLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[YSTagViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[YSTagHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_standardArray.count];
    for (int i = 0; i < _standardArray.count; i++) {
        YSStandard *spec = _standardArray[i];
        YSStandard *childSpec = spec.normses[0];
        [spec.normses setValue:@(NO) forKey:@"selected"];
        childSpec.selected = YES;
        [array addObject:childSpec];
    }
    if (_block) {
        _block([[array valueForKey:@"valueId"] componentsJoinedByString:@","], nil);
    }
    [_collectionView reloadData];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
    CGFloat maxHeight = 150 * kScreenHeight / 480.0;
    CGFloat height = MIN(maxHeight, size.height);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - collectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_standardArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    YSStandard *spec = _standardArray[section];
    return spec.normses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSTagViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    YSStandard *spec = _standardArray[indexPath.section];
    cell.spec = spec.normses[indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YSTagHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        YSStandard *spec = _standardArray[indexPath.section];
        headerView.title = spec.key;
        
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YSStandard *spec = _standardArray[indexPath.section];
    YSStandard *childSpec = spec.normses[indexPath.row];
    
    if (childSpec.selected) {
        return;
    }
    
    [spec.normses setValue:@(NO) forKey:@"selected"];
    childSpec.selected = YES;
    
    [collectionView reloadData];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:_standardArray.count];
    for (YSStandard *standard in _standardArray) {
        for (YSStandard *childStandard in standard.normses) {
            if (childStandard.selected) {
                [array addObject:childStandard];
                break;
            }
        }
    }
    
    if (array.count != _standardArray.count || array.count <= 0) {
        return;
    }
    
    if (_block) {
        _block([[array valueForKey:@"valueId"] componentsJoinedByString:@","], nil);
    }

}

#pragma mark - NormsLayout delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSStandard *spec = _standardArray[indexPath.section];
    YSStandard *childSpec = spec.normses[indexPath.row];
    
    CGFloat width = [childSpec.value widthForFont:[UIFont systemFontOfSize:14]];
    width = (width + 20) < 30 ? 30 : width + 20;
    return CGSizeMake(width, 25);

}


@end
