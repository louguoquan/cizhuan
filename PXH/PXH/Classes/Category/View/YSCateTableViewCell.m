//
//  YSCateTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/1.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCateTableViewCell.h"

@interface YSCateTableViewCell ()

@property (nonatomic, strong) UIView    *tagView;

@property (nonatomic, strong) UILabel   *nameLabel;

@end

@implementation YSCateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = BACKGROUND_COLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.tagView];
    [self.contentView addSubview:self.nameLabel];
    
    WS(weakSelf);
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(2);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(2);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagView.mas_right).offset(2);
        make.right.offset(-2);
        make.centerY.equalTo(weakSelf.contentView);
    }];
}

- (void)setCategory:(YSCategory *)category {
    _category = category;
    _nameLabel.text = _category.name;
}

#pragma mark - view

- (UIView *)tagView {
    if (!_tagView) {
        _tagView = [UIView new];
        _tagView.backgroundColor = MAIN_COLOR;
    }
    return _tagView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = HEX_COLOR(@"#333333");
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"测试";
    }
    return _nameLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (selected) {
        self.tagView.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel.textColor = MAIN_COLOR;
    }else {
        self.tagView.hidden = YES;
        self.backgroundColor = BACKGROUND_COLOR;
        self.nameLabel.textColor = HEX_COLOR(@"#333333");
    }
}

@end
