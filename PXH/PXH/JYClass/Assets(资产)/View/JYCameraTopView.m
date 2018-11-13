//
//  JYCameraTopView.m
//  PXH
//
//  Created by LX on 2018/6/4.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYCameraTopView.h"

@interface JYCameraTopView ()

/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;

@end

@implementation JYCameraTopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"scanBack"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"scanCameraLight"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightRItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"scanPhotoAlbum"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightRButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:_rightItemButton];
    [self addSubview:_rightRItemButton];
    [self addSubview:_leftItemButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@35);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.height.equalTo(@35);
    }];
    
    [_rightRItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(_rightItemButton.mas_left).offset(-10);
        make.width.height.equalTo(@35);
    }];
}


- (void)rightButtonItemClick
{
    !_rightItemClickBlock ? : _rightItemClickBlock();
}


- (void)leftButtonItemClick
{
    !_leftItemClickBlock ? : _leftItemClickBlock();
}

- (void)rightRButtonItemClick
{
    !_rightRItemClickBlock ? : _rightRItemClickBlock();
}


@end
