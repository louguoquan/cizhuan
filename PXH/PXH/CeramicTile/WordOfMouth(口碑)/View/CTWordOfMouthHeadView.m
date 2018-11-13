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
@property (nonatomic,strong)UIButton *selBtn;



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
    btn1.layer.cornerRadius = 5;
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
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"全部信息";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = HEX_COLOR(@"#333333");
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.height.mas_offset(20);
    }];
    
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = HEX_COLOR(@"#F9F4F8");
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(label.mas_bottom).offset(15);
        make.height.mas_offset(0.5);
    }];
    
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"最热" forState:0];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setBackgroundColor:HEX_COLOR(@"#417CF8")];
    [btn2 setTitleColor:HEX_COLOR(@"#999999") forState:0];
    [btn2 setBackgroundColor:HEX_COLOR(@"#ffffff")];
    btn2.layer.borderWidth = 0.5f;
    btn2.layer.borderColor = HEX_COLOR(@"#999999").CGColor;
    [self addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.right.equalTo(self).offset(-15);
        make.height.mas_offset(40);
        make.width.mas_offset(60);
    }];
    btn2.tag = 202;
    [btn2 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *btn3 = [[UIButton alloc]init];
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 setTitle:@"最新" forState:0];
    [btn3 setBackgroundColor:HEX_COLOR(@"#417CF8")];
    [btn3 setTitleColor:HEX_COLOR(@"#417CF8") forState:0];
    [btn3 setBackgroundColor:HEX_COLOR(@"#EAF2FE")];
    btn3.layer.borderWidth = 0.5f;
    btn3.layer.borderColor = HEX_COLOR(@"#417CF8").CGColor;
    [self addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label);
        make.right.equalTo(btn2.mas_left).offset(-10);
        make.height.mas_offset(40);
        make.width.mas_offset(60);
    }];

    btn3.tag = 203;
    [btn3 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.selBtn = btn3;
}


- (void)btnClick:(UIButton *)btn{
    
    
}

- (void)btnClick1:(UIButton *)btn{
    
    if (self.selBtn != btn) {
        
        [self.selBtn setBackgroundColor:HEX_COLOR(@"#417CF8")];
        [self.selBtn setTitleColor:HEX_COLOR(@"#999999") forState:0];
        [self.selBtn setBackgroundColor:HEX_COLOR(@"#ffffff")];
        self.selBtn.layer.borderWidth = 0.5f;
        self.selBtn.layer.borderColor = HEX_COLOR(@"#999999").CGColor;
        
        [btn setBackgroundColor:HEX_COLOR(@"#417CF8")];
        [btn setTitleColor:HEX_COLOR(@"#417CF8") forState:0];
        [btn setBackgroundColor:HEX_COLOR(@"#EAF2FE")];
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = HEX_COLOR(@"#417CF8").CGColor;
        self.selBtn = btn;
    }
    
}


@end
