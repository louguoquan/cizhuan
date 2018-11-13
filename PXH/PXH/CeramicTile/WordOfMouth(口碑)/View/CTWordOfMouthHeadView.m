//
//  CTWordOfMouthHeadView.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTWordOfMouthHeadView.h"

@interface CTWordOfMouthHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;


@end

@implementation CTWordOfMouthHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.backgroundColor = [UIColor whiteColor];
    //轮播图
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.pageControlDotSize = CGSizeMake(10.f, 2.f);
    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"line1"];
    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"line"];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
    //    _cycleScrollView.pageDotColor = Color_GlobalBg;
    [self addSubview:_cycleScrollView];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"location_icon"] forState:0];
    [btn setTitle:@"口碑排行" forState:0];
    [btn setBackgroundColor:HEX_COLOR(@"#FC6C5A")];
    [btn setTitleColor:HEX_COLOR(@"#ffffff") forState:0];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.height.mas_offset(80);
        make.width.mas_offset((kScreenWidth-45)/2.0);
    }];
    btn.layer.cornerRadius = 5;
    
    btn.tag = 200;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setImage:[UIImage imageNamed:@"location_icon"] forState:0];
    [btn1 setTitle:@"口碑对比" forState:0];
    [btn1 setBackgroundColor:HEX_COLOR(@"#417CF8")];
    [btn1 setTitleColor:HEX_COLOR(@"#ffffff") forState:0];
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_offset(80);
        make.width.mas_offset((kScreenWidth-45)/2.0);
    }];
    btn1.tag = 201;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEX_COLOR(@"#F9F4F8");
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(btn.mas_bottom).offset(15);
        make.height.mas_offset(15);
    }];
    
    
    
}


- (void)btnClick:(UIButton *)btn{
    
    
}


@end
