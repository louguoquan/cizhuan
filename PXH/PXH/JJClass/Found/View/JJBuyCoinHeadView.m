//
//  JJBuyCoinHeadView.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinHeadView.h"

@interface JJBuyCoinHeadView ()

@property (nonatomic,strong)UIImageView *firstView;
//@property (nonatomic,strong)UIImageView *secoundView;
//@property (nonatomic,strong)UIImageView *threeView;

@property (nonatomic,strong)UIView *line1;
//@property (nonatomic,strong)UIView *line2;
//@property (nonatomic,strong)UIView *line3;
//@property (nonatomic,strong)UIView *line4;

@property (nonatomic,strong)UILabel *firstLabel;
//@property (nonatomic,strong)UILabel *secoundLabel;
//@property (nonatomic,strong)UILabel *threeLabel;


@end

@implementation JJBuyCoinHeadView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.firstView];
//    [self addSubview:self.secoundView];
//    [self addSubview:self.threeView];
//    [self addSubview:self.line1];
//    [self addSubview:self.line2];
//    [self addSubview:self.line3];
//    [self addSubview:self.line4];
    [self addSubview:self.firstLabel];
//    [self addSubview:self.secoundLabel];
//    [self addSubview:self.threeLabel];
    
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
//        make.left.mas_offset((kScreenWidth-40*2)/4.0);
        make.centerX.equalTo(self);
        make.height.width.mas_offset(40);
    }];
    
    
//    [self.secoundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.firstView);
//        make.right.mas_offset(-((kScreenWidth-40*2)/4.0));
//        make.height.width.mas_offset(40);
//    }];
//
//    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.firstView);
//        make.right.mas_offset(-((kScreenWidth-40*2)/4.0));
//        make.height.width.mas_offset(40);
//    }];
    
//    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.firstView.mas_right).offset(5);
//        make.centerY.equalTo(self.firstView);
//        make.right.equalTo(self.secoundView.mas_left).offset(-5);
//        make.height.mas_offset(3);
//    }];
    
//    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.secoundView.mas_right).offset(5);
//        make.centerY.equalTo(self.firstView);
//        make.right.equalTo(self.threeView.mas_left).offset(-5);
//        make.height.mas_offset(3);
//    }];
//
//    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.firstView.mas_right).offset(5);
//        make.centerY.equalTo(self.firstView);
//        make.right.equalTo(self.firstView.mas_right).offset(5);
//        make.height.mas_offset(3);
//    }];
//
//    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.secoundView.mas_right).offset(5);
//        make.centerY.equalTo(self.firstView);
//        make.right.equalTo(self.secoundView.mas_right).offset(5);
//        make.height.mas_offset(3);
//    }];
    
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.firstView);
        make.top.equalTo(self.firstView.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
//    [self.secoundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.secoundView);
//        make.top.equalTo(self.secoundView.mas_bottom).offset(10);
//        make.height.mas_offset(20);
//    }];
//
//    [self.threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.threeView);
//        make.top.equalTo(self.threeView.mas_bottom).offset(10);
//        make.height.mas_offset(20);
//    }];
}

- (void)setType:(NSInteger)type
{
//    if (type == 1) {
//
//
//        [self.line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.firstView.mas_right).offset(5);
//            make.centerY.equalTo(self.firstView);
//            make.right.equalTo(self.secoundView.mas_left).offset(-5);
//            make.height.mas_offset(3);
//        }];
//        self.secoundView.image = [UIImage imageNamed:@"cire2_nowhite"];
//        self.secoundLabel.textColor = GoldColor;
//    }
    
//    else if (type == 2){
//
//        [self.line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.firstView.mas_right).offset(5);
//            make.centerY.equalTo(self.firstView);
//            make.right.equalTo(self.secoundView.mas_left).offset(-5);
//            make.height.mas_offset(3);
//        }];
//
//        [self.line4 mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.secoundView.mas_right).offset(5);
//            make.centerY.equalTo(self.firstView);
//            make.right.equalTo(self.threeView.mas_left).offset(-5);
//            make.height.mas_offset(3);
//        }];
//
//        self.secoundView.image = [UIImage imageNamed:@"cire2_nowhite"];
//        self.threeView.image = [UIImage imageNamed:@"cire3_nowhite"];
//
//        self.secoundLabel.textColor = GoldColor;
//        self.threeLabel.textColor = GoldColor;
//
//    }
}

- (UIImageView *)firstView
{
    if (!_firstView) {
        _firstView = [[UIImageView alloc]init];
        _firstView.image = [UIImage imageNamed:@"cire1_nowhite"];
    }
    return _firstView;
}

//- (UIImageView *)secoundView
//{
//    if (!_secoundView) {
//        _secoundView = [[UIImageView alloc]init];
//        _secoundView.image = [UIImage imageNamed:@"cire2_white"];
//    }
//    return _secoundView;
//}

//- (UIImageView *)threeView
//{
//    if (!_threeView) {
//        _threeView = [[UIImageView alloc]init];
//        _threeView.image = [UIImage imageNamed:@"cire3_white"];
//    }
//    return _threeView;
//}

- (UILabel *)firstLabel
{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.font = [UIFont systemFontOfSize:18];
        _firstLabel.textColor = GoldColor;
        _firstLabel.text = @"提交";
    }
    return _firstLabel;
}

//- (UILabel *)secoundLabel
//{
//    if (!_secoundLabel) {
//        _secoundLabel = [[UILabel alloc]init];
//        _secoundLabel.font = [UIFont systemFontOfSize:18];
//        _secoundLabel.textColor = HEX_COLOR(@"#88898A");
//        _secoundLabel.text = @"核实";
//    }
//    return _secoundLabel;
//}

//- (UILabel *)threeLabel
//{
//    if (!_threeLabel) {
//        _threeLabel = [[UILabel alloc]init];
//        _threeLabel.font = [UIFont systemFontOfSize:18];
//        _threeLabel.textColor = HEX_COLOR(@"#88898A");
//        _threeLabel.text = @"核实";
//    }
//    return _threeLabel;
//}


- (UIView *)line1
{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = HEX_COLOR(@"#DCDDDE");
    }
    return _line1;
}

//- (UIView *)line2
//{
//    if (!_line2) {
//        _line2 = [[UIView alloc]init];
//        _line2.backgroundColor = HEX_COLOR(@"#DCDDDE");
//    }
//    return _line2;
//}
//
//- (UIView *)line3
//{
//    if (!_line3) {
//        _line3 = [[UIView alloc]init];
//        _line3.backgroundColor = GoldColor;
//    }
//    return _line3;
//}

//- (UIView *)line4
//{
//    if (!_line4) {
//        _line4 = [[UIView alloc]init];
//        _line4.backgroundColor = GoldColor;
//    }
//    return _line4;
//}

@end
