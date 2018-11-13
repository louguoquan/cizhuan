//
//  YSProfileTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/7.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSProfileTableViewCell.h"

@implementation YSProfileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.rightImageView];
    
    WS(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.offset(-10);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.offset(-10);
        make.height.width.mas_equalTo(40);
    }];
    
}


#pragma mark - view

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _descLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.layer.cornerRadius = 20;
        _rightImageView.clipsToBounds = YES;
    }
    
    return _rightImageView;
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
