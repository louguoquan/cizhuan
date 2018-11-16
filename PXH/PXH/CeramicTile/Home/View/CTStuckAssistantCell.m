//
//  CTStuckAssistantCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTStuckAssistantCell.h"

@interface CTStuckAssistantCell ()

@property (nonatomic,strong)UIButton *selBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIImageView *iconImageView;


@end

@implementation CTStuckAssistantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.selBtn];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.width.mas_offset(80);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
        make.top.equalTo(self.iconImageView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
        make.bottom.equalTo(self.iconImageView);
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.iconImageView);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"马可波罗釉面砖LF36898";
    self.priceLabel.text = @"￥15.6-18";
    self.addressLabel.text = @"规格:400x400mm";

    
    
    
    
}

- (void)sel:(UIButton *)btn{
    
    
    
}

- (UIButton *)selBtn
{
    if (!_selBtn) {
        _selBtn = [[UIButton alloc]init];
        [_selBtn setTitle:@"查看效果" forState:0];
        [_selBtn setTitleColor:HEX_COLOR(@"#2D75F7") forState:0];
        [_selBtn setBackgroundColor:HEX_COLOR(@"#EAF2FE")];
        _selBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_selBtn addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selBtn;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
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

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _addressLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = HEX_COLOR(@"#888888");
    }
    return _priceLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
