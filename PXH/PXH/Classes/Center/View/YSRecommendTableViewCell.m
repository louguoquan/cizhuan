//
//  YSRecommendTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRecommendTableViewCell.h"

@interface YSRecommendTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *timeLabel;

@end

@implementation YSRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    
    WS(weakSelf);
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40);
        make.left.offset(10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.offset(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.logo);
        make.left.equalTo(weakSelf.logo.mas_right).offset(10);
        make.right.offset(-10);
    }];
}

- (void)setFans:(YSFans *)fans {
    _fans = fans;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_fans.logo] placeholderImage:kPlaceholderImage];
//    _nameLabel.text = _fans.nickName;
    _nameLabel.text = _fans.mobile;
    _timeLabel.text = _fans.regTime;
}

#pragma mark - view

- (UIImageView *)logo {
    if (!_logo) {
        _logo = [UIImageView new];
        _logo.layer.cornerRadius = 20;
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = YES;
    }
    return _logo;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _timeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
