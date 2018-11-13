//
//  JYOutPutCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/30.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYOutPutCell.h"

@interface JYOutPutCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *titleLabel;

@end



@implementation JYOutPutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(7.5);
        make.centerY.equalTo(self.titleLabel);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(11);
    }];
    
    
}

- (void)setModel:(LrdCellModel *)model
{
    self.titleLabel.text = model.title;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"arror_nomal"];
        
    }
    return _iconImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
