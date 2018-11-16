//
//  JJOrderTableViewCell.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJOrderTableViewCell.h"
@interface JJOrderTableViewCell()
@property (nonatomic,readwrite,weak) UILabel *titleLabel;
@property (nonatomic,readwrite,weak) UILabel *addressLabel;
@property (nonatomic,readwrite,weak) UIButton *linkBtn;
@property (nonatomic,readwrite,weak) UIView *line;
@property (nonatomic,readwrite,weak) UIImageView *goodsImg;
@property (nonatomic,readwrite,weak) UILabel *goodsNameLabel;
@property (nonatomic,readwrite,weak) UILabel *priceLabel;
@property (nonatomic,readwrite,weak) UILabel *dateLabel;
@end
@implementation JJOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.contentView.backgroundColor = [UIColor sd_colorWithHexString:@"f8f4f8"];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView).width.insets(UIEdgeInsetsMake(0, 0, 10, 0));
        
    }];
//    [self.contentView addSubview:self.titleLabel];
//    [self.contentView addSubview:self.addressLabel];
//    [self.contentView addSubview:self.linkBtn];
//    [self.contentView addSubview:self.line];
//    [self.contentView addSubview:self.goodsImg];
//    [self.contentView addSubview:self.goodsNameLabel];
//    [self.contentView addSubview:self.priceLabel];
//    [self.contentView addSubview:self.dateLabel];
    
    [self.linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_equalTo(15);
        make.right.equalTo(self.contentView).mas_equalTo(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_equalTo(20);
        make.left.equalTo(self.contentView).mas_equalTo(20);
        make.right.equalTo(self.linkBtn).mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.linkBtn).mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).mas_equalTo(20);
        make.left.right.equalTo(self.contentView).mas_equalTo(0);
        make.height.mas_equalTo(0.8f);
    }];
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).mas_equalTo(20);
        make.left.equalTo(self.contentView).mas_equalTo(20);
        make.width.height.mas_equalTo(70);
    }];
//
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).mas_equalTo(20);
        make.left.equalTo(self.goodsImg.mas_right).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsNameLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.goodsImg.mas_right).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.goodsImg.mas_right).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --------------getters--------------
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"诺贝尔瓷砖";
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)addressLabel{
    if (!_addressLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"宁围镇新华村88号";
        label.textColor = [UIColor lightGrayColor];
        label.font     = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        _addressLabel = label;
    }
    return _addressLabel;
}
- (UIButton *)linkBtn{
    if (!_linkBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"联系Ta" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:button];
        _linkBtn = button;
    }
    return _linkBtn;
}
- (UIView *)line{
    if (!_line) {
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
        _line = line;
    }
    return _line;
}
- (UIImageView *)goodsImg{
    if (!_goodsImg) {
        UIImageView *image = [UIImageView new];
        image.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:image];
        _goodsImg = image;
    }
    return _goodsImg;
}
- (UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"xxxxxxxx瓷砖";
        [self.contentView addSubview:label];
        _goodsNameLabel = label;
    }
    return _goodsNameLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"指导价：15.0￥~16.0￥";
        label.textColor = [UIColor lightGrayColor];
        label.font     = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"2018-11-24 8:00";
        label.textColor = [UIColor lightGrayColor];
        label.font     = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        _dateLabel = label;
    }
    return _dateLabel;
}
@end
