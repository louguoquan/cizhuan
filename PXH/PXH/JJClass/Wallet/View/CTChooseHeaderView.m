//
//  CTChooseHeaderView.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "CTChooseHeaderView.h"
@interface CTChooseHeaderView()
@property (nonatomic,readwrite,weak) UIImageView *headerImg;
@property (nonatomic,readwrite,weak) UILabel *firstLabel;
@property (nonatomic,readwrite,weak) UIView *line;
@property (nonatomic,readwrite,weak) UILabel *secondLabel;
@end
@implementation CTChooseHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_equalTo(20);
        make.top.equalTo(self.headerImg.mas_bottom).mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    NSArray *titles = @[@"马可波罗",@"诺贝儿",@"马可波罗",@"马可波罗",@"马可波罗"];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 6*20)/5;
    for (int i = 0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20 + i*(width + 20), 210, width, width);
        btn.backgroundColor = [UIColor blueColor];
        [self addSubview:btn];
        
        UILabel *label = [UILabel new];
        label.text     = titles[i];
        label.frame    = CGRectMake(20 + i*(width + 20), btn.bottom + 10, width, 20);
        label.font     = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).mas_equalTo(width+20+10+20+20);
        make.left.right.equalTo(self).mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_left);
        make.top.equalTo(self.line).mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    CGFloat marginTop = 210 + width + 10 + 20 + 20 + 10 + 20 + 20;
    NSArray *imgNames = @[@"东鹏蒂诺石",@"诺贝尔瓷砖",@"诺贝尔瓷砖"];
    width = ([UIScreen mainScreen].bounds.size.width - 4*20)/3;
    for (int i = 0; i<imgNames.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor redColor];
        imageView.frame = CGRectMake(20 + i * (width + 20), marginTop, width, width - 30);
        [self addSubview:imageView];
        
        UILabel *label = [UILabel new];
        label.text     = imgNames[i];
        label.font     = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame    =  CGRectMake(20 + i * (width + 20), marginTop+width - 30 + 10   , width, 20);
        [self addSubview:label];
    }
}
#pragma mark --------------getters--------------
- (UIImageView *)headerImg{
    if (!_headerImg) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor redColor];
        [self addSubview:imageView];
        _headerImg = imageView;
    }
    return _headerImg;
}
- (UILabel *)firstLabel{
    if (!_firstLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"推荐品牌";
        [self addSubview:label];
        
        _firstLabel = label;
    }
    return _firstLabel;
}
- (UIView *)line{
    if (!_line) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor sd_colorWithHexString:@"f8f4f8"];
        [self addSubview:view];
        
        _line = view;
    }
    return _line;
}
- (UILabel *)secondLabel{
    if (!_secondLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"推荐品牌";
        [self addSubview:label];
        
        _secondLabel = label;
    }
    return _secondLabel;
}
@end
