//
//  YSNewIndexTableCell.m
//  PXH
//
//  Created by futurearn on 2018/3/31.
//  Copyright © 2018年 yu. All rights reserved.
//

#import "YSNewIndexTableCell.h"
#import "YSIndexCollectionCell.h"
@interface YSNewIndexTableCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *productArr;

@end

@implementation YSNewIndexTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.productArr = [NSMutableArray array];
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews
{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)setSection:(NSInteger)section
{
    _section = section;
}

- (void)setLimitArray:(NSMutableArray *)limitArray
{
    _limitArray = limitArray;
    self.productArr = limitArray;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        CGFloat itemWidth = kScreenWidth / 3.0;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 73);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[YSIndexCollectionCell class] forCellWithReuseIdentifier:@"CellCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_productArr.count > 6) {
        return 6;
    } else {
        return _productArr.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSIndexCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCell" forIndexPath:indexPath];
    if (_section == 0) {
        cell.seckillProduct = _productArr[indexPath.item];
    } else {
        cell.dic = _productArr[indexPath.item];
    }
    cell.layer.borderWidth = 0.3f;
    cell.layer.borderColor = HexColor(0xcccccc).CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(_section) forKey:@"section"];
    if (_section == 0) {
        YSSeckillProduct *product = _productArr[indexPath.item];
        [dict setObject:product forKey:@"product"];
    } else {
        NSDictionary *dic = _productArr[indexPath.item];
        [dict setObject:dic forKey:@"product"];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"首页点选" object:dict];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
