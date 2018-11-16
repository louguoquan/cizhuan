//
//  CTBrandRankCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTBrandRankCell.h"

@interface CTBrandRankCell ()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *desLabel;
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UIImageView *numImageView;


@end

@implementation CTBrandRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.desLabel];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.numImageView];
    
    [self.numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_offset(30);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_offset(30);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(60);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_offset(40);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.height.mas_offset(20);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView);
        make.height.mas_offset(20);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    
    self.numLabel.text = @"1";
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.text = @"诺贝尔瓷砖";
    self.desLabel.text = @"创立于1988年，品牌单价实打实几点回家坚实的哈哈";
    
    
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UIImageView *)numImageView
{
    if (!_numImageView) {
        _numImageView = [[UIImageView alloc]init];
    }
    return _numImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _desLabel;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.font = [UIFont systemFontOfSize:15];
        _numLabel.textColor = HEX_COLOR(@"#ffffff");
        _numLabel.backgroundColor = HEX_COLOR(@"#7E7E7E");
        _numLabel.layer.cornerRadius = 15;
        _numLabel.layer.masksToBounds = YES;
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
