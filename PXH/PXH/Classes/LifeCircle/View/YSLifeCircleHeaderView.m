//
//  YSLifeCircleHeaderView.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLifeCircleHeaderView.h"
#import "YSNavTitleView.h"
#import "YSButton.h"

@interface YSLifeCircleHeaderView ()

@property (nonatomic, strong) UILabel   *rulesLabel;

@property (nonatomic, strong) UIScrollView  *permissionScrollView;

@property (nonatomic, strong) UIView    *cateBgView;
@property (nonatomic, strong) NSMutableArray *catsArray;
@end

@implementation YSLifeCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.catsArray = [NSMutableArray array];
    }
    return self;
}

- (void)setArray:(NSMutableArray *)array
{

    self.backgroundColor = [UIColor whiteColor];
    _catsArray = array;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 10)];
    lineView.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView];
    
    if (array.count > 0) {
        NSInteger rows = (array.count + 3) / 4;
        
        _cateBgView = [UIView new];
        _cateBgView.frame = CGRectMake(0, 38, ScreenWidth, rows * 100);
        CGFloat width = kScreenWidth / 4.0;
        for (NSInteger i = 0; i < array.count; i ++) {
            YSLifeCategory *cate = array[i];
            
            NSInteger x = i % 4;
            NSInteger y = i / 4;
            
            YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
            button.frame = CGRectMake(width * x , 100 * y, width, 100);
            button.imageViewSize = CGSizeMake(46, 46);
            button.ysImageView.layer.masksToBounds = YES;
            button.ysImageView.layer.cornerRadius = 23;
            [button sd_setImageWithURL:[NSURL URLWithString:cate.image] forState:UIControlStateNormal placeholderImage:kPlaceholderImage];
            button.tag = i;
            [button setTitle:cate.name forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
//            [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//                [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1), @"model":cate}];
//            }];
            [_cateBgView addSubview:button];
        }
    }
    [self addSubview:_cateBgView];
    
    
    UIView *lineView1 = [UIView new];
    lineView1.frame = CGRectMake(0, CGRectGetMaxY(_cateBgView.frame), ScreenWidth, 10);
    lineView1.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView1];
    
    UIView *segmentView3 = [self segmentViewForTitle:@"猜你喜欢"];
    
    [self addSubview:segmentView3];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, segmentView3.frame.origin.y + segmentView3.frame.size.height + 15, ScreenWidth, 1)];
    lineView2.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:lineView2];
}

- (void)buttonAction:(UIButton *)sender
{
    YSLifeCategory *life = _catsArray[sender.tag];
    self.click(life);
}

//- (void)setModel:(YSLifeCircleModel *)model {
//    _model = model;
//
//    self.backgroundColor = [UIColor whiteColor];
//
//
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 10)];
//    lineView.backgroundColor = BACKGROUND_COLOR;
//    [self addSubview:lineView];
//
//    if (_model.cats.count > 0) {
//        NSInteger rows = (_model.cats.count + 3) / 4;
//
//        _cateBgView = [UIView new];
//        _cateBgView.frame = CGRectMake(0, 38, ScreenWidth, rows * 100);
//        CGFloat width = kScreenWidth / 4.0;
//        for (NSInteger i = 0; i < _model.cats.count; i ++) {
//            YSLifeCategory *cate = _model.cats[i];
//
//            NSInteger x = i % 4;
//            NSInteger y = i / 4;
//
//            YSButton *button = [YSButton buttonWithImagePosition:YSButtonImagePositionTop];
//            button.frame = CGRectMake(width * x , 100 * y, width, 100);
//            button.imageViewSize = CGSizeMake(46, 46);
//            button.ysImageView.layer.masksToBounds = YES;
//            button.ysImageView.layer.cornerRadius = 23;
//            [button sd_setImageWithURL:[NSURL URLWithString:cate.image] forState:UIControlStateNormal placeholderImage:kPlaceholderImage];
//            [button setTitle:cate.name forState:UIControlStateNormal];
//            button.titleLabel.font = [UIFont systemFontOfSize:13];
//            [button setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
//            [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
//                [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(1), @"model":cate}];
//            }];
//            [_cateBgView addSubview:button];
//        }
//    }
//    [self addSubview:_cateBgView];
//
//
//    UIView *lineView1 = [UIView new];
//    lineView1.frame = CGRectMake(0, CGRectGetMaxY(_cateBgView.frame), ScreenWidth, 10);
//    lineView1.backgroundColor = BACKGROUND_COLOR;
//    [self addSubview:lineView1];
//
//    UIView *segmentView3 = [self segmentViewForTitle:@"猜你喜欢"];
//
//    [self addSubview:segmentView3];
//
//    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, segmentView3.frame.origin.y + segmentView3.frame.size.height + 15, ScreenWidth, 1)];
//    lineView2.backgroundColor = BACKGROUND_COLOR;
//    [self addSubview:lineView2];
//
//}

- (UIView *)segmentViewForTitle:(NSString *)title {
    UIView *view = [UIView new];
    view.frame = CGRectMake(ScreenWidth / 2 - 110, CGRectGetMaxY(_cateBgView.frame) + 28, 220, 15);
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(CGRectGetWidth(view.frame) / 2 - 40, 0, 80, CGRectGetHeight(view.frame));
    label.text = title;
    label.textColor = HEX_COLOR(@"#333333");
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];

    UIView *lineView = [UIView new];
    lineView.frame = CGRectMake(0, CGRectGetHeight(view.frame) / 2 - 1, CGRectGetWidth(view.frame) / 2 - 40, 1);
    lineView.backgroundColor = LINE_COLOR;
    [view addSubview:lineView];
    
    UIView *lineView1 = [UIView new];
    lineView1.frame = CGRectMake(CGRectGetWidth(view.frame) / 2 + 40, CGRectGetMinY(lineView.frame), CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame));
    lineView1.backgroundColor = LINE_COLOR;
    [view addSubview:lineView1];
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
