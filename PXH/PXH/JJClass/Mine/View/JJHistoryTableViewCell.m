//
//  JJHistoryTableViewCell.m
//  PXH
//
//  Created by Kessssss on 2018/11/14.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJHistoryTableViewCell.h"

@interface JJHistoryTableViewCell()
@property (nonatomic,readwrite,weak) UIButton *selBtn;
@property (nonatomic,readwrite,weak) UIImageView *goodsImg;
@property (nonatomic,readwrite,weak) UILabel *titleLabel;
@property (nonatomic,readwrite,weak) UILabel *priceLabel;
@property (nonatomic,readwrite,weak) UILabel *dateLabel;
@end
@implementation JJHistoryTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_equalTo(20);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(20);
    }];
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.selBtn.mas_right).mas_equalTo(20);
        make.height.width.mas_equalTo(70);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImg.mas_top);
        make.left.equalTo(self.goodsImg.mas_right).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(5);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).mas_equalTo(5);
        make.left.equalTo(self.titleLabel.mas_left);
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
- (UIButton *)selBtn{
    if (!_selBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:btn];
        
        _selBtn = btn;
    }
    return _selBtn;
}
- (UIImageView *)goodsImg{
    if (!_goodsImg) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:imageView];
        
        _goodsImg = imageView;
    }
    return _goodsImg;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"xxxx面砖";
        [self.contentView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"指导价：￥16.5~18.5";
        label.textColor = [UIColor lightGrayColor];
        label.font     = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"2018-11-14 12:00";
        label.textColor = [UIColor lightGrayColor];
        label.font     = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        
        _dateLabel = label;
    }
    return _dateLabel;
}
@end
