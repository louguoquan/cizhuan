//
//  YSProductFooterView.m
//  PXH
//
//  Created by futurearn on 2018/4/17.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSProductFooterView.h"
#import "YSProductCollectionViewCell.h"

@interface YSCollectionHeaderView : UICollectionReusableView

@property (nonatomic, assign) NSInteger isGroup;

@end

@implementation YSCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = BACKGROUND_COLOR;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.right.offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = HEX_COLOR(@"#666666");
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = BACKGROUND_COLOR;
    if (self.isGroup == 1) {
        label.text = @"组合产品";
    } else {
        label.text = @"项目介绍";
    }
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(80);
    }];
}

@end


@interface YSProductFooterView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView  *collectionView;

@end

@implementation YSProductFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.frame = frame;
        
        [self addSubview:self.collectionView];
        
        [self.collectionView registerClass:[YSCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    }
    return self;
}

- (void)setDetail:(YSProductDetail *)detail
{
    _detail = detail;
    
    CGFloat height = 0;
    if (_detail.products.count > 3) {
        height = 2 * (ScreenWidth / 3 + 73);
    } else if (_detail.products.count <= 3 && _detail.products > 0) {
        height = ScreenWidth / 3 + 73;
    } else {
        height = 0;
    }
    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, height + 40);
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_detail.products.count > 6) {
        return 6;
    }
    return _detail.products.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YSCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.isGroup = _detail.isGroup;
        return headerView;
    }
    return nil;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YSProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.product = _detail.products[indexPath.row];
    cell.layer.borderWidth = 0.3f;
    cell.layer.borderColor = HexColor(0xcccccc).CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YSProduct *product = _detail.products[indexPath.row];
    
    self.jumpToOtherProduct(product.productId);
    
}


#pragma void - view

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
        CGFloat itemWidth = kScreenWidth / 3.0;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 73);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = BACKGROUND_COLOR;
        _collectionView.bounces = NO;

        [_collectionView registerClass:[YSProductCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
