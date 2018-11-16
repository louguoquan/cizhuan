
//
//  CTAskFloorPriceHead.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTAskFloorPriceHead.h"

@interface CTAskFloorPriceHead ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIView *productView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *sizeLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,strong)UIImageView *nextImageView;

@property (nonatomic, strong) YSCellView    *cityCell;
@property (nonatomic, strong) YSCellView    *nameCell;
@property (nonatomic, strong) YSCellView    *phoneCell;

@property (nonatomic,strong)UIButton *btn;

@end

@implementation CTAskFloorPriceHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self addSubview:self.productView];
    [self.productView addSubview:self.iconImageView];
    [self.productView addSubview:self.titleLabel];
    [self.productView addSubview:self.sizeLabel];
    [self.productView addSubview:self.priceLabel];
    [self.productView addSubview:self.nextImageView];
    [self addSubview:self.btn];
    
    
    
    [self.productView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(80);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productView).offset(10);
        make.width.height.mas_offset(60);
        make.left.equalTo(self.productView).offset(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sizeLabel.mas_bottom);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.productView);
        make.right.equalTo(self.productView).offset(-10);
        make.width.height.mas_offset(10);
    }];
    
    
    
    _cityCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeLabel];
    _cityCell.ys_contentFont = [UIFont systemFontOfSize:18];
    _cityCell.ys_title = @"城市";
    _cityCell.ys_titleFont = [UIFont systemFontOfSize:15];
    _cityCell.ys_titleColor = HEX_COLOR(@"#BCBCBC");
    _cityCell.ys_bottomLineHidden = NO;
    _cityCell.ys_text = @"杭州";
    _cityCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    [self addSubview:_cityCell];
    [_cityCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productView.mas_bottom);
        make.left.right.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(50);
    }];
    
    
    _nameCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _nameCell.ys_contentFont = [UIFont systemFontOfSize:18];
    _nameCell.ys_textFiled.placeholder = @"姓名";
    _nameCell.ys_title = @"姓名";
    _nameCell.ys_titleFont = [UIFont systemFontOfSize:15];
    _nameCell.ys_titleColor = HEX_COLOR(@"#BCBCBC");
    _nameCell.ys_bottomLineHidden = NO;
    _nameCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _nameCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    _nameCell.ys_textFiled.textColor = HEX_COLOR(@"#333333");
    [self addSubview:_nameCell];
    [_nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityCell.mas_bottom);
        make.left.right.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(50);
    }];
    
    _phoneCell = [[YSCellView alloc] initWithStyle:YSCellViewTypeTextField];
    _phoneCell.ys_contentFont = [UIFont systemFontOfSize:18];
    _phoneCell.ys_textFiled.placeholder = @"手机号码";
    _phoneCell.ys_titleFont = [UIFont systemFontOfSize:15];
    _phoneCell.ys_title = @"电话";
    _phoneCell.ys_titleColor = HEX_COLOR(@"#BCBCBC");
    _phoneCell.ys_bottomLineHidden = NO;
    _phoneCell.ys_contentTextColor = HEX_COLOR(@"#333333");
    _phoneCell.ys_textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneCell.ys_textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    _phoneCell.ys_textFiled.textColor = HEX_COLOR(@"#333333");
    [self addSubview:_phoneCell];
    [_phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameCell.mas_bottom);
        make.left.right.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(50);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_offset(50);
        make.top.equalTo(self.phoneCell.mas_bottom).offset(5);
    }];
    
    
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = HEX_COLOR(@"#F9F4F8");
    [self addSubview:sectionView];
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_offset(40);
        make.top.equalTo(self.btn.mas_bottom).offset(10);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"咨询厂家";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = HEX_COLOR(@"#999999");
    [sectionView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView).offset(10);
        make.centerY.equalTo(sectionView);
        make.height.mas_offset(20);
    }];
    
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    self.nextImageView.backgroundColor = [UIColor grayColor];
    self.titleLabel.text = @"马可波罗釉面砖LF36898";
    self.sizeLabel.text = @"尺寸400x400";
    self.priceLabel.text = @"指导价：￥15.6-18.8";
    
    
    
    
}

- (UIView *)productView
{
    if (!_productView) {
        _productView = [[UIView alloc]init];
    }
    return _productView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UIImageView *)nextImageView
{
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc]init];
    }
    return _nextImageView;
}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc]init];
        _sizeLabel.font = [UIFont systemFontOfSize:13];
        _sizeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _sizeLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _priceLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}


- (UIButton *)btn
{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
        [_btn setTitle:@"获取底价" forState:0];
        [_btn setTitleColor:HEX_COLOR(@"#ffffff") forState:0];
        [_btn setBackgroundColor:HEX_COLOR(@"#2E77F9")];
        _btn.layer.cornerRadius = 3;
        _btn.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn.layer.masksToBounds = YES;
    }
    return _btn;
}


@end
