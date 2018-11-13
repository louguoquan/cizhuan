//
//  JJShopCell.m
//  PXH
//
//  Created by louguoquan on 2018/9/3.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJShopCell.h"

@interface JJShopCell ()

@property (nonatomic,strong)UILabel *buyLabel;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UIImageView *iconImage;


@end

@implementation JJShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.buyLabel];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_offset(40);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage);
        make.left.equalTo(self.iconImage.mas_right).offset(5);
        make.height.mas_offset(20);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImage);
        make.left.equalTo(self.iconImage.mas_right).offset(5);
        make.height.mas_offset(20);
    }];
    
    
    [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(100*(kScreenWidth/375));
        make.height.mas_offset(40);
    }];
    
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buyLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(60*(kScreenWidth/375));
        make.height.mas_offset(40);
    }];
    
    
}

- (void)setModel:(JJShopModel *)model
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    self.nameLabel.text = model.productName;
    
    self.desLabel.text = @"绑定送300点算力";
    
    self.buyLabel.text = @"立即抢购";
    
    self.typeLabel.text = model.stage;
    
    
}

- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.textAlignment = NSTextAlignmentLeft;
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _desLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = GoldColor;
        _typeLabel.layer.borderWidth = 0.5f;
        _typeLabel.layer.cornerRadius = 4.0f;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.layer.borderColor = GoldColor.CGColor;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}

- (UILabel *)buyLabel
{
    if (!_buyLabel) {
        _buyLabel = [[UILabel alloc]init];
        _buyLabel.textAlignment = NSTextAlignmentLeft;
        _buyLabel.font = [UIFont systemFontOfSize:14];
        _buyLabel.textColor = HEX_COLOR(@"#ffffff");
        _buyLabel.layer.cornerRadius = 4.0f;
        _buyLabel.layer.masksToBounds = YES;
        _buyLabel.backgroundColor = GoldColor;
        _buyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _buyLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
