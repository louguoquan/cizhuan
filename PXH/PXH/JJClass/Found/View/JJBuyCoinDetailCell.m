//
//  JJBuyCoinDetailCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinDetailCell.h"

@interface JJBuyCoinDetailCell ()

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * suLabel;

@end

@implementation JJBuyCoinDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.suLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.suLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

- (void)setTitle:(NSString *)title sub:(NSString *)sub index:(NSInteger)index{
    
    self.titleLabel.text = title;
    
    if (index == 1) {
        self.suLabel.textColor = GoldColor;
    }
    self.suLabel.text = sub;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}



- (UILabel *)suLabel
{
    if (!_suLabel) {
        _suLabel = [[UILabel alloc]init];
        _suLabel.font = [UIFont systemFontOfSize:16];
        _suLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _suLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
