//
//  CTProductDetailSpecialCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductDetailSpecialCell.h"

@interface CTProductDetailSpecialCell ()

@property (nonatomic,strong)UILabel *sizeLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *colorLabel;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UIButton *askBtn;

@end

@implementation CTProductDetailSpecialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.sizeLabel];
    [self.contentView addSubview:self.colorLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.addBtn];
    [self.contentView addSubview:self.askBtn];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(15);
        make.height.mas_offset(20);
    }];
    
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sizeLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.left.equalTo(self.sizeLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sizeLabel);
        make.height.mas_offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeLabel);
        make.top.equalTo(self.colorLabel.mas_bottom).offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
    }];
    
    [self.askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.colorLabel.mas_bottom).offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];

    self.sizeLabel.text = [NSString stringWithFormat:@"尺寸:%@",@"400x400"];
    self.colorLabel.text = [NSString stringWithFormat:@"颜色:%@",@"琥珀色 和田玉 吉祥语 翡翠玉"];
    self.priceLabel.text = [NSString stringWithFormat:@"指导价:%@",@"14.6"];
    
    
    
    
}

- (void)add:(UIButton *)btn{
    
    
    
}

- (void)ask:(UIButton *)btn{
    
    
    
}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.font = [UIFont systemFontOfSize:15];
        _sizeLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _sizeLabel;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc]init];
        _colorLabel.font = [UIFont systemFontOfSize:13];
        _colorLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _colorLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _priceLabel;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn setTitle:@"加入对比" forState:0];
        [_addBtn setImage:[UIImage imageNamed:@"location_icon"] forState:0];
        [_addBtn setTitleColor:HEX_COLOR(@"#417CF8") forState:0];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


- (UIButton *)askBtn
{
    if (!_askBtn) {
        _askBtn = [[UIButton alloc]init];
        [_askBtn setTitle:@"询底价" forState:0];
        [_askBtn setTitleColor:HEX_COLOR(@"#417CF8") forState:0];
        [_askBtn setBackgroundColor:HEX_COLOR(@"#F4F9FF")];
        _askBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_askBtn addTarget:self action:@selector(ask:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _askBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
