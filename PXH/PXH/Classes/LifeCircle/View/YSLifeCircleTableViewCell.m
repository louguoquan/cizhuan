//
//  YSLifeCircleTableViewCell.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSLifeCircleTableViewCell.h"

@interface YSLifeCircleTableViewCell ()

@property (nonatomic, strong) UIImageView   *logo;

@property (nonatomic, strong) UILabel       *nameLabel;

@property (nonatomic, strong) UILabel       *descLabel;

@property (nonatomic, strong) UILabel       *addressLabel;

@end

@implementation YSLifeCircleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    _logo = [UIImageView new];
    _logo.frame = CGRectMake(10, 10, 120, 120);
//    _logo.center = CGPointMake(65, CGRectGetHeight(self.frame) / 2);
    _logo.contentMode = UIViewContentModeScaleAspectFill;
    _logo.clipsToBounds = YES;
    [self.contentView addSubview:_logo];
//    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.width.mas_equalTo(120);
//        make.left.offset(10);
//        make.centerY.offset(0);
//    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_logo.frame) + 10, 10, ScreenWidth - 150, 20);
    _nameLabel.textColor = HEX_COLOR(@"#333333");
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_logo);
//        make.right.offset(-10);
//        make.left.equalTo(_logo.mas_right).offset(10);
//    }];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(140, 105, 12, 15)];
    iconView.image = [UIImage imageNamed:@"life_address"];
    [self.contentView addSubview:iconView];
//    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(iconView.image.size);
//        make.left.equalTo(_logo.mas_right).offset(10);
//        make.bottom.equalTo(_logo);
//    }];
    
    _addressLabel = [UILabel new];
    _addressLabel.frame = CGRectMake(165, 105, ScreenWidth - 175, 15);
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.textColor = MAIN_COLOR;
    [self.contentView addSubview:_addressLabel];
//    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(iconView);
//        make.left.equalTo(iconView.mas_right).offset(10);
//        make.right.offset(-10);
//    }];
    
    _descLabel = [UILabel new];
    _descLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 10, CGRectGetWidth(_nameLabel.frame), 20);
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = HEX_COLOR(@"#999999");
    _descLabel.numberOfLines = 0;
    [self.contentView addSubview:_descLabel];
//    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
//        make.left.equalTo(_logo.mas_right).offset(10);
//        make.right.offset(-10);
//        make.bottom.lessThanOrEqualTo(iconView.mas_top).offset(-10);
//    }];
}

- (void)setMerchants:(YSLifeMerchants *)merchants {
    
    _merchants = merchants;
    
    [_logo sd_setImageWithURL:[NSURL URLWithString:_merchants.image] placeholderImage:kPlaceholderImage];
    
    _nameLabel.text = _merchants.name;
    
    _addressLabel.text = _merchants.area;
    
    _descLabel.text = _merchants.desc;
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
