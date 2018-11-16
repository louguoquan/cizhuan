//
//  CTAskOtherFactoryCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/15.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTAskOtherFactoryCell.h"


@interface CTAskOtherFactoryCell ()

@property (nonatomic,strong)UIButton *selBtn;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end


@implementation CTAskOtherFactoryCell

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
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.height.width.mas_offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.selBtn.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.selBtn.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom);
        make.left.equalTo(self.selBtn.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(20);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    
    self.titleLabel.text = @"杭州萧山区马可波罗瓷砖";
    self.addressLabel.text = @"明和芦丹氏附近爱豆世纪";
    self.priceLabel.text = @"参考价:￥100-100";
    
}

- (void)sel:(UIButton *)btn{
    
    
    
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
