
//
//  CTParamerHeadView.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTParamerHeadView.h"

@interface CTParamerHeadView ()

@property (nonatomic,strong)UILabel *topTitleLabel;
@property (nonatomic,strong)UILabel *centerTitleLabel;

@property (nonatomic,strong)UIView  *paramView;


@end

@implementation CTParamerHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.topTitleLabel];
    [self addSubview:self.centerTitleLabel];
    [self addSubview:self.paramView];
    
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(50);
    }];
    
    [self.paramView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topTitleLabel.mas_bottom);
        make.height.mas_offset(280);
    }];
    
    [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.paramView.mas_bottom);
        make.height.mas_offset(50);
    }];
    
    
    NSArray *titleArr = @[@"产品品牌",@"产品型号",@"产地",@"产品材质",@"单片厚度",@"单片重量",@"产品颜色"];
    
     NSArray *subArr = @[@"东鹏瓷砖",@"LF36789",@"浙江杭州",@"全抛釉面瓷砖",@"~11.5mm",@"17-18kg",@"白色/釉色/大理石色"];
    
    CGFloat h = 20;
    CGFloat y = 0;
    for (NSInteger i = 0; i<7; i++) {
     
        y = 40*i;
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10+y, 100,  h)];
        titleLabel.text = titleArr[i];
        titleLabel.textColor = HEX_COLOR(@"#555555");
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.paramView addSubview:titleLabel];
        
        UILabel * subLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 10+y, 200,  h)];
        subLabel.text = subArr[i];
        subLabel.textColor = HEX_COLOR(@"#555555");
        subLabel.font = [UIFont systemFontOfSize:15];
        [self.paramView addSubview:subLabel];
        
    }
    
}

- (UILabel *)topTitleLabel
{
    if (!_topTitleLabel) {
        _topTitleLabel = [[UILabel alloc]init];
        _topTitleLabel.font = [UIFont systemFontOfSize:25];
        _topTitleLabel.textColor = HEX_COLOR(@"#3C81F8");
        _topTitleLabel.backgroundColor = HEX_COLOR(@"#EAF2FE");
        _topTitleLabel.text = @"基本参数";
        _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topTitleLabel;
}

- (UILabel *)centerTitleLabel
{
    if (!_centerTitleLabel) {
        _centerTitleLabel = [[UILabel alloc]init];
        _centerTitleLabel.font = [UIFont systemFontOfSize:25];
        _centerTitleLabel.textColor = HEX_COLOR(@"#3C81F8");
        _centerTitleLabel.backgroundColor = HEX_COLOR(@"#EAF2FE");
        _centerTitleLabel.text = @"规格";
        _centerTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerTitleLabel;
}

- (UIView *)paramView
{
    if (!_paramView) {
        _paramView = [[UIView alloc]init];
    }
    return _paramView;
}


@end
