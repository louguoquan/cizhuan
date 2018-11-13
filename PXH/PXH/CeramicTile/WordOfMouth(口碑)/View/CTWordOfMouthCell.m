//
//  CTWordOfMouthCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTWordOfMouthCell.h"

@interface CTWordOfMouthCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *desLabel;


@end

@implementation CTWordOfMouthCell

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
    [self.contentView addSubview:self.iconImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_offset(60);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.iconImageView);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.iconImageView);
        make.height.mas_offset(15);
    }];
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.numberOfLines = 3;
    self.titleLabel.text = @"东鹏次钻第三季的痕迹sad阿贾克斯的挥洒好烦按时间款到发货";
    [self.titleLabel sizeToFit];
    
    self.desLabel.text = @"东鹏瓷砖";
    


}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]init];
        _desLabel.textColor = HEX_COLOR(@"#333333");
        _desLabel.font = [UIFont systemFontOfSize:11];
    }
    return _desLabel;
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
