//
//  CTProductDetailCommentCell.m
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import "CTProductDetailCommentCell.h"

@interface CTProductDetailCommentCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *colorAndSpecialLabel;
@property (nonatomic,strong)UILabel *starLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *addressLabel;

@property (nonatomic,strong)UILabel *starMessageLabel;
@property (nonatomic,strong)UILabel *priceMessageLabel;
@property (nonatomic,strong)UILabel *addressMessageLabel;

@property (nonatomic,strong)UILabel *agreeLabel;
@property (nonatomic,strong)UILabel *disagreeLabel;
@property (nonatomic,strong)UIView *imagesView;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *zanBtn;


@end

@implementation CTProductDetailCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.colorAndSpecialLabel];
    [self.contentView addSubview:self.starLabel];
    [self.contentView addSubview:self.starMessageLabel];
    [self.contentView addSubview:self.priceMessageLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.addressMessageLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.contentView addSubview:self.agreeLabel];
    [self.contentView addSubview:self.disagreeLabel];
    [self.contentView addSubview:self.imagesView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.zanBtn];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(10);
        make.height.width.mas_offset(30);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImageView);
        make.height.mas_offset(15);
    }];
    
    [self.colorAndSpecialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(3);
        make.centerY.equalTo(self.iconImageView);
        make.height.mas_offset(15);
    }];
    
    [self.starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
    }];
    
    [self.starMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.starLabel.mas_bottom);
    }];
    
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
    }];
    
    [self.priceMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.priceLabel.mas_bottom);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
    }];
    
    [self.addressMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.mas_offset((kScreenWidth-2)/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.addressLabel.mas_bottom);
       
    }];
    
    UILabel * ag = [[UILabel alloc]init];
    ag.font = [UIFont systemFontOfSize:12];
    ag.textColor = HEX_COLOR(@"#ffffff");
    ag.backgroundColor = HEX_COLOR(@"#B5B5B5");
    ag.layer.cornerRadius = 2;
    ag.layer.masksToBounds = YES;
    ag.text = @"最满意";
    ag.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:ag];
    [ag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starMessageLabel.mas_bottom).offset(15);
        make.left.equalTo(self.iconImageView);
        make.height.mas_offset(15);
        make.width.mas_offset(50);
    }];
    
    [self.agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ag);
        make.left.equalTo(ag.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    
    UILabel * ag1 = [[UILabel alloc]init];
    ag1.font = [UIFont systemFontOfSize:12];
    ag1.textColor = HEX_COLOR(@"#ffffff");
    ag1.backgroundColor = HEX_COLOR(@"#B5B5B5");
    ag1.layer.cornerRadius = 2;
    ag1.layer.masksToBounds = YES;
    ag1.text = @"最不满意";
    ag1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:ag1];
    [ag1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.agreeLabel.mas_bottom).offset(15);
        make.left.equalTo(self.iconImageView);
        make.height.mas_offset(15);
        make.width.mas_offset(50);
    }];
    
    [self.disagreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ag1);
        make.left.equalTo(ag1.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.disagreeLabel.mas_bottom).offset(15);
        make.height.mas_offset(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.imagesView.mas_bottom).offset(15);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.timeLabel);
        make.height.mas_offset(20);
        make.width.mas_offset(100);
    }];
    
    
    
    
    
    self.iconImageView.backgroundColor = [UIColor redColor];
    self.iconImageView.layer.cornerRadius = 15;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.nameLabel.text = @"hongrong";
    self.colorAndSpecialLabel.text = @"米色 400x400";
    self.starLabel.text = [NSString stringWithFormat:@"%@分",@"4.9"];
    self.starMessageLabel.text = @"综合评分";
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",@"15.6"];
    self.priceMessageLabel.text = @"单片价格";
    self.addressLabel.text = @"杭州";
    self.addressMessageLabel.text = @"购买地点";
    
    self.agreeLabel.text = @"和图片差不多，及时维萨多卡市地税局的撒娇看了巴萨发的省部级的萨芬报价单";
    self.agreeLabel.numberOfLines = 0;
    [self.agreeLabel sizeToFit];
    self.disagreeLabel.text = @"减傻地方很近ad手机号复活甲卡收到货饭卡上交电话费建行卡撒打飞机啊都放假咖啡";
    self.disagreeLabel.numberOfLines = 0;
    [self.disagreeLabel sizeToFit];
    
    self.imagesView.backgroundColor = [UIColor redColor];
    
    self.timeLabel.text = @"2018-10-10";
    
    
}

- (void)zan:(UIButton *)btn{
    
    
    
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = HEX_COLOR(@"#777777");
    }
    return _timeLabel;
}

- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [[UIButton alloc]init];
        [_zanBtn setTitle:@"100" forState:0];
        [_zanBtn setImage:[UIImage imageNamed:@"location_icon"] forState:0];
        [_zanBtn setTitleColor:HEX_COLOR(@"#417CF8") forState:0];
        _zanBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_zanBtn addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanBtn;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}



- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = HEX_COLOR(@"#444444");
    }
    return _nameLabel;
}

- (UILabel *)colorAndSpecialLabel
{
    if (!_colorAndSpecialLabel) {
        _colorAndSpecialLabel = [[UILabel alloc]init];
        _colorAndSpecialLabel.font = [UIFont systemFontOfSize:12];
        _colorAndSpecialLabel.textColor = HEX_COLOR(@"#999999");
    }
    return _colorAndSpecialLabel;
}

- (UILabel *)starLabel
{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.font = [UIFont systemFontOfSize:12];
        _starLabel.textColor = HEX_COLOR(@"#444444");
        _starLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _starLabel;
}

- (UILabel *)starMessageLabel
{
    if (!_starMessageLabel) {
        _starMessageLabel = [[UILabel alloc]init];
        _starMessageLabel.font = [UIFont systemFontOfSize:12];
        _starMessageLabel.textColor = HEX_COLOR(@"#444444");
        _starMessageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _starMessageLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = HEX_COLOR(@"#444444");
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

- (UILabel *)priceMessageLabel
{
    if (!_priceMessageLabel) {
        _priceMessageLabel = [[UILabel alloc]init];
        _priceMessageLabel.font = [UIFont systemFontOfSize:12];
        _priceMessageLabel.textColor = HEX_COLOR(@"#444444");
        _priceMessageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceMessageLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = HEX_COLOR(@"#444444");
        _addressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressLabel;
}

- (UILabel *)addressMessageLabel
{
    if (!_addressMessageLabel) {
        _addressMessageLabel = [[UILabel alloc]init];
        _addressMessageLabel.font = [UIFont systemFontOfSize:12];
        _addressMessageLabel.textColor = HEX_COLOR(@"#444444");
        _addressMessageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressMessageLabel;
}


- (UILabel *)agreeLabel
{
    if (!_agreeLabel) {
        _agreeLabel = [[UILabel alloc]init];
        _agreeLabel.font = [UIFont systemFontOfSize:12];
        _agreeLabel.textColor = HEX_COLOR(@"#444444");
    }
    return _agreeLabel;
}

- (UILabel *)disagreeLabel
{
    if (!_disagreeLabel) {
        _disagreeLabel = [[UILabel alloc]init];
        _disagreeLabel.font = [UIFont systemFontOfSize:12];
        _disagreeLabel.textColor = HEX_COLOR(@"#444444");
    }
    return _disagreeLabel;
}

- (UIView *)imagesView
{
    if (!_imagesView) {
        _imagesView = [[UIView alloc]init];
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
