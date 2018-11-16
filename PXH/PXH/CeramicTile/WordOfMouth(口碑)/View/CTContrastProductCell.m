//
//  CTContrastProductCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTContrastProductCell.h"

@interface CTContrastProductCell ()

@property (nonatomic,strong)UIButton *selBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UIImageView *iconImageView;

@end


@implementation CTContrastProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.selBtn];
    [self.contentView addSubview:self.iconImageView];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selBtn.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.height.mas_offset(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
        make.bottom.equalTo(self.iconImageView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.addressLabel.mas_left).offset(-10);
        make.height.mas_offset(20);
        make.bottom.equalTo(self.iconImageView);
    }];
    


    self.iconImageView.backgroundColor = [UIColor redColor];
    self.titleLabel.text = @"杭州萧山区马可波罗瓷砖";
    self.addressLabel.text = @"详情 >";
    self.priceLabel.text = @"参考价:￥100-100";
    
}

- (void)sel:(UIButton *)btn{
    
    
    
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

- (UIButton *)selBtn
{
    if (!_selBtn) {
        _selBtn = [[UIButton alloc]init];
        [_selBtn setImage:[UIImage imageNamed:@"box_NoSel"] forState:0];
        [_selBtn setImage:[UIImage imageNamed:@"box_Sel"] forState:UIControlStateSelected];
        [_selBtn addTarget:self action:@selector(sel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selBtn;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
