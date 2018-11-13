//
//  YSTableViewCell.m
//  PXH
//
//  Created by futurearn on 2017/12/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTableViewCell.h"
#import "YSSeckillView.h"
#import "YSSeckillProduct.h"
#import "SeckillView.h"
@interface YSTableViewCell()

@property (nonatomic, strong) UIScrollView  *seckillView;

@end

@implementation YSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}



- (void)setProductArray:(NSArray *)productArray
{
    _seckillView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 128)];
    _seckillView.contentSize = CGSizeMake(kScreenWidth * productArray.count, 0);
    _seckillView.pagingEnabled = YES;
    _seckillView.showsHorizontalScrollIndicator = NO;
    _seckillView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_seckillView];
    //限量秒杀
    for (NSInteger i = 0; i < productArray.count; i ++) {
//        YSSeckillView *productView = [[YSSeckillView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, ScreenWidth, 128)];
//        YSSeckillProduct *product = productArray[i];
//
//        [productView setSeckillProduct:product];
//        [_seckillView addSubview:productView];
//
        SeckillView *seckill = [[SeckillView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, ScreenWidth, 128)];
        YSSeckillProduct *product = productArray[i];
        [seckill setSeckillProduct:product];
        [_seckillView addSubview:seckill];
        
        [seckill addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(2), @"model":product}];
        }]];

    }
    
}


@end
