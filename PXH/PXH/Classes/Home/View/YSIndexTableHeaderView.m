//
//  YSIndexTableHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSIndexTableHeaderView.h"

#import "YSSeckillView.h"

@interface YSIndexTableHeaderView ()

@property (nonatomic, strong) SDCycleScrollView     *cycleScrollView;

@property (nonatomic, strong) UIScrollView      *seckillView;

@property (nonatomic, strong) NSMutableArray *adArray;

@end

@implementation YSIndexTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self initSubviews];
        
        self.adArray = [NSMutableArray array];
    }
    return self;
}

- (void)initSubviews {
    
//    WS(weakSelf);
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:weakSelf placeholderImage:kPlaceholderImage];
//
//    [self addSubview:_cycleScrollView];
//    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.mas_equalTo(kScreenWidth * 350.0 / 750.0);
//    }];
    
//    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.ys_leftImage = [UIImage imageNamed:@"秒杀"];
//    cell.ys_titleFont = [UIFont systemFontOfSize:15];
//    cell.ys_titleColor = HEX_COLOR(@"#333333");
//    cell.ys_title = @"限量秒杀";
//    cell.ys_contentTextAlignment = NSTextAlignmentRight;
//    cell.ys_contentFont = [UIFont systemFontOfSize:11];
//    cell.ys_contentTextColor = HEX_COLOR(@"#999999");
//    cell.ys_text = @"查看更多";
//    cell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
//    cell.ys_bottomLineHidden = NO;
//    [cell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent: @(1)}];
//    }];
//    [self addSubview:cell];
//    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.cycleScrollView.mas_bottom).offset(10);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(40);
//    }];
    
//    _seckillView = [UIScrollView new];
//    _seckillView.pagingEnabled = YES;
//    _seckillView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:_seckillView];
//    [_seckillView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell.mas_bottom);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(128);
//    }];
//
//    YSCellView *cell1 = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
//    cell1.backgroundColor = [UIColor whiteColor];
//    cell1.ys_leftImage = [UIImage imageNamed:@"抢购"];
//    cell1.ys_titleFont = [UIFont systemFontOfSize:15];
//    cell1.ys_titleColor = HEX_COLOR(@"#333333");
//    cell1.ys_title = @"限时抢购";
//    cell1.ys_bottomLineHidden = NO;
//    [self addSubview:cell1];
//    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.seckillView.mas_bottom).offset(10);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(40);
//        make.bottom.offset(0);
//    }];
}

- (void)setAdvArray:(NSArray *)advArray productArray:(NSArray *)productArray {

    [_adArray removeAllObjects];
    [_adArray addObjectsFromArray:advArray];
    
    WS(weakSelf);
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, kScreenWidth * 35.0 / 75.0) delegate:weakSelf placeholderImage:kPlaceholderImage];
    _cycleScrollView.autoScrollTimeInterval = 2.5f;
    [_cycleScrollView setImageURLStringsGroup:[advArray valueForKey:@"image"]];
    [self addSubview:_cycleScrollView];
    
//    YSCellView *cell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
//    cell.frame = CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame) + 10, ScreenWidth, 40);
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.ys_leftImage = [UIImage imageNamed:@"秒杀"];
//    cell.ys_titleFont = [UIFont systemFontOfSize:15];
//    cell.ys_titleColor = HEX_COLOR(@"#333333");
//    cell.ys_title = @"限量秒杀";
//    cell.ys_contentTextAlignment = NSTextAlignmentRight;
//    cell.ys_contentFont = [UIFont systemFontOfSize:11];
//    cell.ys_contentTextColor = HEX_COLOR(@"#999999");
//    cell.ys_text = @"查看更多";
//    cell.ys_accessoryType = YSCellAccessoryDisclosureIndicator;
//    cell.ys_bottomLineHidden = NO;
//    [cell addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//        [weakSelf routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent: @(1)}];
//    }];
//    [self addSubview:cell];
//
//    _seckillView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cell.frame), ScreenWidth, 128)];
//    _seckillView.pagingEnabled = YES;
//    _seckillView.showsHorizontalScrollIndicator = NO;
//    _seckillView.contentSize = CGSizeMake(kScreenWidth * productArray.count, 0);
//    _seckillView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:_seckillView];
//
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_seckillView.frame), ScreenWidth, 1)];
//    view.backgroundColor = BACKGROUND_COLOR;
//    [self addSubview:view];
//
//    YSCellView *cell1 = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
//    cell1.backgroundColor = [UIColor whiteColor];
//    cell1.frame = CGRectMake(0, CGRectGetMaxY(view.frame), ScreenWidth, 40);
//    cell1.ys_leftImage = [UIImage imageNamed:@"抢购"];
//    cell1.ys_titleFont = [UIFont systemFontOfSize:15];
//    cell1.ys_titleColor = HEX_COLOR(@"#333333");
//    cell1.ys_title = @"限时抢购";
//    cell1.ys_bottomLineHidden = NO;
//    [self addSubview:cell1];
//
//
//    //限量秒杀
//    for (NSInteger i = 0; i < productArray.count; i ++) {
//        YSSeckillView *productView = [[YSSeckillView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, ScreenWidth, 128)];
//        YSSeckillProduct *product = productArray[i];
//        productView.type = 2;
//        [productView setSeckillProduct:product];
//        [_seckillView addSubview:productView];
//
//        [productView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
//            [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(2), @"model":product}];
//        }]];
//    }
    
}

#pragma mark - 点击图片方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击第%ld张图片", index);

    [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(0), @"model":_adArray[index]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
