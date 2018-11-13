
//
//  YSSetupTableViewCell.m
//  HouseDoctorMember
//
//  Created by yu on 2017/3/24.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSetupTableViewCell.h"

@interface YSSetupTableViewCell ()


@end

@implementation YSSetupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = HEX_COLOR(@"#333333");
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.leftImageView);
    }];
    
    _descLabel = [UILabel new];
    _descLabel.textColor = HEX_COLOR(@"#999999");
    _descLabel.font = [UIFont systemFontOfSize:11];
    _descLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.left.greaterThanOrEqualTo(weakSelf.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.contentView);
    }];
    
    _rightImageView = [UIImageView new];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageView.layer.cornerRadius = 20;
    _rightImageView.clipsToBounds = YES;
    [self.contentView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.height.width.equalTo(@40);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}

- (void)setLeftImage:(UIImage *)leftImage title:(NSString *)title content:(NSString *)content rightImage:(id)rightImage
{
    WS(weakSelf);
    _titleLabel.text = title;
    _leftImageView.image = leftImage;
    if (leftImage) {
        _leftImageView.hidden = NO;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.leftImageView.mas_right).offset(10);
        }];
    }else {
        _leftImageView.hidden = YES;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.leftImageView.mas_right);
        }];
    }
    
    if (rightImage) {
        _descLabel.hidden = YES;
        
        if ([rightImage isKindOfClass:[UIImage class]]) {
            _rightImageView.image = rightImage;
        }else {
            [_rightImageView sd_setImageWithURL:[NSURL URLWithString:rightImage] placeholderImage:kPlaceholderImage];
        }
    }else {
        _descLabel.hidden = NO;
        _descLabel.text = content;
    }
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
