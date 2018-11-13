//
//  JYInvitationCell.m
//  PXH
//
//  Created by louguoquan on 2018/6/7.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYInvitationCell.h"

@interface JYInvitationCell ()

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *peopleLabel;
@property (nonatomic,strong)UILabel *priceLabel;

@end

@implementation JYInvitationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {

    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.peopleLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(15);
    }];

    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(10);
        make.left.equalTo(self.numberLabel).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];

    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(1);
    }];


}

-(void)setModel:(JYInvitationModel *)model
{
    self.numberLabel.text = @"No.1";
    self.phoneLabel.text = @"15757836166";
    self.peopleLabel.text = @"200人";
    self.priceLabel.text = @"0.000112";
}


- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        _numberLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _numberLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _phoneLabel;
}

- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [UILabel new];
        _peopleLabel.font = [UIFont systemFontOfSize:13];
        _peopleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _peopleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _priceLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
