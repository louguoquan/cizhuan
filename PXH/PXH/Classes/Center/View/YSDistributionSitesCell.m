//
//  YSDistributionSitesCell.m
//  PXH
//
//  Created by yu on 2017/8/11.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDistributionSitesCell.h"

#import "YSButton.h"

@interface YSDistributionSitesCell ()

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@property (nonatomic, strong) YSButton  *distanceButton;

@property (nonatomic, strong) UILabel   *tagLabel;

@end

@implementation YSDistributionSitesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    WS(weakSelf);
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#666666");
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(13);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    
    _distanceButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    [_distanceButton setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    _distanceButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_distanceButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
    _distanceButton.space = 10;
    _distanceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_distanceButton];
    [_distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(13);
        make.left.offset(10);
        make.bottom.offset(-15);
        make.height.mas_equalTo(15);
    }];
    
    _tagLabel = [UILabel new];
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.textColor = MAIN_COLOR;
    _tagLabel.text = @"离我最近";
    [self.contentView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.distanceButton);
        make.left.equalTo(weakSelf.distanceButton.mas_right).offset(10);
    }];
}

- (void)setStation:(YSServiceStation *)station {
    _station = station;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@  %@", _station.name, _station.mobile];
    _addressLabel.text = _station.address;
    
    [_distanceButton setTitle:[NSString stringWithFormat:@"%.2fkm", _station.distance] forState:UIControlStateNormal];
    _tagLabel.hidden = !_station.shortestDistance;
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
