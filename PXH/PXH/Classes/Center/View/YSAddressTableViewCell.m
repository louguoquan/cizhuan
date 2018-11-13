//
//  YSAddressTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAddressTableViewCell.h"
#import "YSButton.h"

@interface YSAddressTableViewCell ()

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *mobileLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@property (nonatomic, strong) YSButton  *checkButton;

@end

@implementation YSAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.addressLabel];
    UIView *view = [self createButtonView];
    [self.contentView addSubview:view];
    
    WS(weakSelf);
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-10);
        make.height.mas_equalTo(15);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
        make.height.mas_equalTo(15);
        make.right.lessThanOrEqualTo(weakSelf.mobileLabel.mas_left).offset(10);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(15);
        make.left.offset(10);
        make.right.offset(-10);
    }];

    UIView *lineView = [UIView new];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(15);
        make.right.offset(0);
        make.left.offset(10);
        make.height.equalTo(@1);
    }];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)editAddress:(UIButton *)button {
    [self routerEventWithName:kButtonDidClickRouterEvent userInfo:@{kButtonDidClickRouterEvent:@(button.tag - 10), @"model":_address}];
}

- (void)setAddress:(YSAddress *)address {
    _address = address;
    
    _mobileLabel.text = _address.mobile;
    _nameLabel.text = _address.name;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@", _address.provinceName, _address.cityName, _address.districtName, _address.streetName, _address.address];
    
    _checkButton.selected = _address.type == 1 ? YES : NO;
}

#pragma mark - view

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _nameLabel;
}

- (UILabel *)mobileLabel {
    if (!_mobileLabel) {
        _mobileLabel = [UILabel new];
        _mobileLabel.font = [UIFont systemFontOfSize:15];
        _mobileLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _mobileLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = HEX_COLOR(@"#666666");
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

- (UIView *)createButtonView {
    UIView *view = [UIView new];
    
    YSButton *deleteButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    deleteButton.tag = 11;
    deleteButton.space = 5;
    [deleteButton setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    [deleteButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [deleteButton addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(view);
        make.right.offset(-10);
    }];
    
    YSButton *editButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    editButton.tag = 12;
    editButton.space = 5;
    [editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [editButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [editButton addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(view);
        make.right.equalTo(deleteButton.mas_left).offset(-20);
    }];
    
    [view addSubview:self.checkButton];
    [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.height.centerY.equalTo(view);
    }];
    
    
    return view;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
        _checkButton.space = 10;
        _checkButton.tag = 10;
        [_checkButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [_checkButton setTitle:@"默认地址" forState:UIControlStateNormal];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_checkButton setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _checkButton;
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
