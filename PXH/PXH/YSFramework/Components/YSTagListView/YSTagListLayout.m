//
//  YSTagListLayout.m
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTagListLayout.h"

#define SPACING 10.0f

#define HEADERHEIGHT 20.0f

@interface YSTagListLayout ()

@property (nonatomic, assign) CGRect    lastFrame;

@property (nonatomic, strong) NSMutableDictionary   *attributes;

@property (nonatomic, strong) NSMutableArray    *headerAttributes;

@end

@implementation YSTagListLayout

- (NSMutableDictionary *)attributes
{
    if (!_attributes) {
        _attributes = [NSMutableDictionary dictionary];
    }
    
    return _attributes;
}

- (NSMutableArray *)headerAttributes
{
    if (!_headerAttributes) {
        _headerAttributes = [NSMutableArray array];
    }
    return _headerAttributes;
}

// 准备布局前调用   初始化属性

- (void)prepareLayout
{
    [super prepareLayout];
    
    _lastFrame = CGRectZero;
    
    [self.headerAttributes removeAllObjects];
    [self.attributes removeAllObjects];
    
    //分区数量
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < sectionCount; section ++) {
        
        _lastFrame = CGRectMake(0, CGRectGetMaxY(_lastFrame) + 10, self.collectionView.width, HEADERHEIGHT);
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        attrs.frame = _lastFrame;
        [self.headerAttributes addObject:attrs];
        
        //cell数量
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemCount; item ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            //计算每个Cell的布局
            UICollectionViewLayoutAttributes *itemAttr = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributes setObject:itemAttr forKey:indexPath];
        }
    }
}

//计算每个item的属性  包括point、size ==....
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    id delegate = self.collectionView.delegate;
    CGSize size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];    
    CGFloat itemHeight = size.height;
    CGFloat itemWidth = MIN(size.width, self.collectionView.width);
    
    CGFloat x = CGRectGetMaxX(_lastFrame);
    
    if (indexPath.item == 0 || ((x + SPACING + itemWidth) > self.collectionView.width)) {
        //第一个
        attrs.frame = CGRectMake(0, CGRectGetMaxY(_lastFrame) + SPACING, itemWidth, itemHeight);
    }else {
        attrs.frame = CGRectMake(x + SPACING, _lastFrame.origin.y, itemWidth, itemHeight);
    }
    
    _lastFrame = attrs.frame;
    
    return attrs;
}

//返回可视范围内的 元素属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    //获取当前所有可视item的indexPath。通过调用父类获取的布局属性数组会缺失一部分可视item的布局属性
    for (NSIndexPath *indexPath in [_attributes allKeys]) {
        UICollectionViewLayoutAttributes *itemAttr = _attributes[indexPath];
        if (CGRectIntersectsRect(itemAttr.frame, rect)) {
            [layoutAttributes addObject:itemAttr];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attr in _headerAttributes) {
        if (CGRectIntersectsRect(attr.frame, rect)) {
            [layoutAttributes addObject:attr];
        }
    }
    
    return layoutAttributes;
}

//bouns 改变后 是否刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
    //    return !CGRectEqualToRect(self.collectionView.bounds, newBounds);
}

//计算ContentSize
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.width, CGRectGetMaxY(_lastFrame) + 10);
}

@end
