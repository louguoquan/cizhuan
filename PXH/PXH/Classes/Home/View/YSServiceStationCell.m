//
//  YSServiceStationCell.m
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSServiceStationCell.h"

#import "YSButton.h"

@interface YSServiceStationCell ()

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UILabel   *addressLabel;

@property (nonatomic, strong) YSButton  *distanceButton;

@property (nonatomic, strong) UILabel   *tagLabel;

@end

@implementation YSServiceStationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkButton setImage:[UIImage imageNamed:@"check-normal"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"check-pressed"] forState:UIControlStateSelected];
    _checkButton.userInteractionEnabled = NO;
    [self.contentView addSubview:_checkButton];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.offset(-10);
        make.height.width.mas_equalTo(20);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEX_COLOR(@"#666666");
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(10);
        make.right.equalTo(_checkButton.mas_left).offset(-10);
    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = HEX_COLOR(@"#666666");
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(13);
        make.left.offset(10);
        make.right.equalTo(_checkButton.mas_left).offset(-10);
    }];
    
    _distanceButton = [YSButton buttonWithImagePosition:YSButtonImagePositionLeft];
    [_distanceButton setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    _distanceButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_distanceButton setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
    _distanceButton.space = 10;
    _distanceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:_distanceButton];
    [_distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).offset(13);
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
        make.centerY.equalTo(_distanceButton);
        make.left.equalTo(_distanceButton.mas_right).offset(10);
    }];
}

- (void)setStation:(YSServiceStation *)station {
    _station = station;
    [self initSubviews];

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
    
    _checkButton.selected = selected;


    // Configure the view for the selected state
}

@end
