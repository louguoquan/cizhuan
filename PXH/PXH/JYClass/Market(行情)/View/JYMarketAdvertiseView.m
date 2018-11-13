//
//  JYMarketAdvertiseView.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMarketAdvertiseView.h"

@interface JYMarketAdvertiseView ()

@property (nonatomic,strong)UIImageView *advertiseImageView;

@property (nonatomic,strong)UILabel *advertiseLabel;

@property (nonatomic,strong)UIButton *closeBtn;

@end


@implementation JYMarketAdvertiseView


- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseBG);
    [self addSubview:self.advertiseImageView];
    [self addSubview:self.advertiseLabel];
    [self addSubview:self.closeBtn];
    
    [self.closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    [self.advertiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(17);
        make.width.mas_equalTo(29);
        make.height.mas_equalTo(14);
    }];
    
    [self.advertiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.advertiseImageView.mas_right).offset(17);
        make.height.mas_equalTo(13);
        make.right.equalTo(self).offset(-28);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.advertiseLabel.mas_right);
        make.height.width.mas_equalTo(24);
        make.right.equalTo(self);
    }];
}

- (void)hide{
    
    if (self.AdvertiseViewHide) {
        self.AdvertiseViewHide();
    }
    
}


- (void)setModel:(JYCmsIndexModel *)model
{
    self.advertiseLabel.text = model.title;
}

- (UIImageView *)advertiseImageView
{
    if (!_advertiseImageView) {
        _advertiseImageView = [UIImageView new];
        _advertiseImageView.image = [UIImage imageNamed:@"affiche"];
    }
    
    return _advertiseImageView;
}

- (UILabel *)advertiseLabel
{
    if (!_advertiseLabel) {
        _advertiseLabel = [UILabel new];
        _advertiseLabel.dk_textColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _advertiseLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _advertiseLabel;
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
        _closeBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _closeBtn;
    
}

@end
