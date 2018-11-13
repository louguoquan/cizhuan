//
//  YSCateCollectionViewCell.m
//  PXH
//
//  Created by yu on 2017/8/1.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateCollectionViewCell.h"

@interface YSCateCollectionViewCell ()

@property (nonatomic, strong) UIImageView   *iconView;

@property (nonatomic, strong) UILabel       *nameLabel;

@end

@implementation YSCateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    
    WS(weakSelf);
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.height.width.mas_equalTo(60);
        make.top.offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-15);
    }];
}

- (void)setCategory:(YSCategory *)category {
    _category = category;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_category.logo] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _category.name;
}

#pragma mark - view

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;

}

@end
