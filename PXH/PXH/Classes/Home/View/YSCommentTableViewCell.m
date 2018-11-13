//
//  YSCommentTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCommentTableViewCell.h"
#import <HCSStarRatingView.h>
#import "YSImagesView.h"

@interface YSCommentTableViewCell ()

@property (nonatomic, strong) UIImageView   *avatar;

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *timeLabel;

@property (nonatomic, strong) UILabel   *contentLabel;

@property (nonatomic, strong) YSImagesView   *imagesView;

@property (nonatomic, strong) HCSStarRatingView   *ratingView;

@property (nonatomic, strong) UILabel *ratelabel;

@end

@implementation YSCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.ratelabel];
    [self.contentView addSubview:self.ratingView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.imagesView];
        
    WS(weakSelf);
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
        make.height.width.mas_equalTo(30);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.avatar);
        make.right.offset(-10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatar);
        make.left.equalTo(weakSelf.avatar.mas_right).offset(10);
        make.right.lessThanOrEqualTo(weakSelf.timeLabel.mas_right).offset(-10);
    }];
    
    [self.ratelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.avatar);
        make.left.equalTo(weakSelf.avatar.mas_right).offset(10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(50);
    }];
    
    [self.ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.avatar);
//        make.left.equalTo(weakSelf.avatar.mas_right).offset(10);
        make.left.equalTo(weakSelf.ratelabel.mas_right);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15 * 5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatar.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(0);
        make.bottom.offset(-10);
    }];
}

- (void)setComment:(YSProductComment *)comment {
    _comment = comment;
    
    [_avatar sd_setImageWithURL:[NSURL URLWithString:_comment.memberLogo] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _comment.memberName;
    _timeLabel.text = _comment.time;
    
    _contentLabel.text = _comment.content;
    
    [_imagesView setImages:_comment.images];

    _ratingView.value = _comment.score;
}

#pragma mark - view

- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [UIImageView new];
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
        _avatar.layer.cornerRadius = 15;
        _avatar.clipsToBounds = YES;
        _avatar.backgroundColor = RANDOM_COLOR;
    }
    return _avatar;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = HEX_COLOR(@"#999999");
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _nameLabel;
}

- (UILabel *)ratelabel
{
    if (!_ratelabel) {
        _ratelabel = [UILabel new];
        _ratelabel.font = [UIFont systemFontOfSize:11];
        _ratelabel.textColor = HEX_COLOR(@"#333333");
        _ratelabel.text = @"产品评分:";
    }
    return _ratelabel;
}

- (HCSStarRatingView *)ratingView {
    if (!_ratingView) {
        _ratingView = [[HCSStarRatingView alloc] init];
        _ratingView.userInteractionEnabled = NO;
        _ratingView.maximumValue = 5;
        _ratingView.continuous = YES;
        _ratingView.emptyStarImage = [UIImage imageNamed:@"evaluate_star_grey"];
        _ratingView.filledStarImage = [UIImage imageNamed:@"evaluate_star"];
        [self.contentView addSubview:_ratingView];
    }
    return _ratingView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = HEX_COLOR(@"#666666");
        _contentLabel.numberOfLines = 0;
        [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _contentLabel;
}

- (YSImagesView *)imagesView {
    if (!_imagesView) {
        _imagesView = [YSImagesView new];
    }
    return _imagesView;
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
