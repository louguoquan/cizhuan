//
//  JJCalculateTaskCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/27.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateTaskCell.h"

@interface JJCalculateTaskCell ()

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *namelabel;
@property (nonatomic,strong)UILabel *deslabel;
@property (nonatomic,strong)UILabel *templabel;
@end


@implementation JJCalculateTaskCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithSubViews];
    }
    return self;
}


- (void)initWithSubViews{
    
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.namelabel];
    [self.contentView addSubview:self.deslabel];
    [self.contentView addSubview:self.templabel];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.height.with.mas_offset(50);
        make.top.equalTo(self.contentView).offset(20);
    }];
    
    [self.contentView addSubview:self.namelabel];
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_offset(15);
        make.top.equalTo(self.iconImage.mas_bottom);
    }];
    
    [self.contentView addSubview:self.deslabel];
    [self.deslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_offset(15);
        make.top.equalTo(self.namelabel.mas_bottom);
    }];
    
    [self.templabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(15);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.deslabel.mas_bottom);
        make.bottom.equalTo(self.contentView).offset(-20);
        
    }];

}

- (void)setModel:(JJTaskModel *)model
{
    

    
    
    
    if (model.img.length == 0) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.borderColor = GoldColor.CGColor;
        self.contentView.layer.borderWidth = 1.0f;
        self.namelabel.textColor = GoldColor;
        self.iconImage.hidden = YES;
        self.deslabel.hidden = NO;
        self.deslabel.text = model.content;
        self.deslabel.textColor = GoldColor;
        self.namelabel.text = model.title;
        [self.namelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.mas_offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    }else
    {
        
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
        self.namelabel.text = model.title;
        self.deslabel.text = model.content;
        self.templabel.text = model.time;
        self.contentView.backgroundColor = GoldColor;
        self.namelabel.textColor = [UIColor whiteColor];
        self.deslabel.textColor = [UIColor whiteColor];
    }
    
}



- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImage;
}

- (UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.textColor = HEX_COLOR(@"#ffffff");
        _namelabel.font = [UIFont systemFontOfSize:14];
        _namelabel.textAlignment = NSTextAlignmentCenter;
        _namelabel.adjustsFontSizeToFitWidth = YES;
        _namelabel.minimumFontSize = 0.1;
    }
    return _namelabel;
}

- (UILabel *)deslabel
{
    if (!_deslabel) {
        _deslabel = [[UILabel alloc]init];
        _deslabel.textColor = HEX_COLOR(@"#ffffff");
        _deslabel.font = [UIFont systemFontOfSize:14];
        _deslabel.textAlignment = NSTextAlignmentCenter;
        _deslabel.adjustsFontSizeToFitWidth = YES;
        _deslabel.minimumFontSize = 0.1;
    }
    return _deslabel;
}

- (UILabel *)templabel
{
    if (!_templabel) {
        _templabel = [[UILabel alloc]init];
        _templabel.textColor = HEX_COLOR(@"#ffffff");
        _templabel.font = [UIFont systemFontOfSize:14];
        _templabel.textAlignment = NSTextAlignmentCenter;
        _templabel.adjustsFontSizeToFitWidth = YES;
        _templabel.minimumFontSize = 0.1;

    }
    return _templabel;
}

@end
