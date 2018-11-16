//
//  JJPublicTableViewCell.m
//  PXH
//
//  Created by Kessssss on 2018/11/15.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJPublicTableViewCell.h"
@interface JJPublicTableViewCell()
@property (nonatomic,readwrite,weak) UILabel *titleLabel;
@property (nonatomic,readwrite,strong) UIButton *typeBtn;
@property (nonatomic,readwrite,strong) UIImageView *contentImg;
@property (nonatomic,readwrite,strong) UILabel *dateLabel;
@property (nonatomic,readwrite,strong) UILabel *statuLabel;
@end
@implementation JJPublicTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).mas_equalTo(20);
        make.right.equalTo(self.typeBtn).mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    [self.contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.contentView).mas_equalTo(20);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.height.mas_equalTo(0);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImg.mas_bottom).mas_equalTo(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    [self.statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_top);
        make.right.equalTo(self.contentView).mas_equalTo(-20);
        make.width.mas_equalTo(60);
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
        label.text     = @"xxxxx瓷砖";
        [self.contentView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIButton *)typeBtn{
    if (!_typeBtn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"口碑" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:button];
        
        _typeBtn = button;
    }
    return _typeBtn;
}
- (UIImageView *)contentImg{
    if (!_contentImg) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageView];
        _contentImg = imageView;
    }
    return _contentImg;
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"2018-11-15 8:00";
        label.font     = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:label];
        
        _dateLabel = label;
    }
    return _dateLabel;
}
- (UILabel *)statuLabel{
    if (!_statuLabel) {
        UILabel *label = [UILabel new];
        label.text     = @"审核中";
        label.font     = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _statuLabel = label;
    }
    return _statuLabel;
}
@end
