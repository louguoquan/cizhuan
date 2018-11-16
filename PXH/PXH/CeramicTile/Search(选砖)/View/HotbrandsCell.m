//
//  HotbrandsCell.m
//  Day11-汽车之家
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HotbrandsCell.h"
#import <MASConstraint.h>

#define equalTo1(...)                     mas_equalTo(__VA_ARGS__)

@implementation HotbrandsCell

-(NSMutableArray<UIView *> *)allViews
{
    if (!_allViews)
    {
        _allViews = [NSMutableArray array];
        CGFloat width =(long)([UIScreen mainScreen].bounds.size.width/5.0);
        for (NSInteger i = 0; i < 10; i ++)
        {
            UIView *view = [[UIView alloc]init];
            [self.contentView addSubview:view];
            CGFloat left = width * (i % 5);
            CGFloat top = width*(i / 5);
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_offset(width);
                make.left.equalTo(self.contentView).offset(left);
                make.top.equalTo(self.contentView).offset(top);
                if(i > 4) make.bottom.mas_offset(0);
            }];
            [_allViews addObject:view];
        }
    }
    return _allViews;
}

-(NSMutableArray<UIImageView *> *)iconIVs
{
    if (!_iconIVs)
    {
        _iconIVs = [NSMutableArray array];
        CGFloat width = (long)([UIScreen mainScreen].bounds.size.width/5.0) - 20;
        for (NSInteger i = 0; i < self.allViews.count; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self.allViews[i] addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.allViews[i]).offset(0);
                make.left.equalTo(self.allViews[i]).offset(10);
                make.width.height.mas_offset(width);
            }];
            [_iconIVs addObject:imageView];
        }
    }
    return _iconIVs;
}

-(NSMutableArray<UILabel *> *)nameLBs
{
    if (!_nameLBs)
    {
        _nameLBs = [NSMutableArray array];
        for (NSInteger i = 0; i < self.allViews.count; i++)
        {
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            CGFloat width = (long)([UIScreen mainScreen].bounds.size.width/5.0) - 20;
            [self.allViews[i] addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.iconIVs[i].mas_bottom);
                make.left.equalTo(self.allViews[i]).offset(10);
                make.height.mas_offset(20);
                make.width.mas_offset(width);
            }];
            [_nameLBs addObject:label];
        }
    }
    return _nameLBs;
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
