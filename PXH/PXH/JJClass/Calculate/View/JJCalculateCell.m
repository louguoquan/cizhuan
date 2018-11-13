//
//  JJCalculateCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/24.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCalculateCell.h"

@interface JJCalculateCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *countLabel;

@end


@implementation JJCalculateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.countLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.width.height.mas_offset(30);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    self.iconImageView.layer.cornerRadius = 15;
    self.iconImageView.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.height.mas_offset(15);
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(15);
        make.centerY.equalTo(self.iconImageView);
    }];
    
}

- (void)setModel:(JJCalculateModel *)model
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"eth"]];
    if (model.userName.length == 11) {
        NSString *string=[model.userName stringByReplacingOccurrencesOfString:[model.userName substringWithRange:NSMakeRange(3,4)]withString:@"****"];
        self.nameLabel.text = string;
        
    }else if ([model.userName rangeOfString:@"@"].location!=NSNotFound){
        
        model.userName = @"123@qq.com";
        NSString *string=[model.userName stringByReplacingOccurrencesOfString:[model.userName substringWithRange:NSMakeRange([model.userName rangeOfString:@"@"].location-2,2)]withString:@"**"];
        self.nameLabel.text = string;
    }else{
        self.nameLabel.text = model.userName;
    }
    self.countLabel.text = [NSString stringWithFormat:@"当前算力:%@",model.countNum];
    
}

- (void)setInvitationModel:(JJInveterModel *)invitationModel
{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:invitationModel.head] placeholderImage:[UIImage imageNamed:@"eth"]];
    
    self.nameLabel.text = invitationModel.username;
    self.countLabel.text = invitationModel.ct;
    self.countLabel.font = [UIFont systemFontOfSize:12];
    self.countLabel.textColor = HEX_COLOR(@"#666666");
    
    
}


- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
