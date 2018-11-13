//
//  JYMarketBaseCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMarketBaseCell.h"

@interface JYMarketBaseCell ()


@property (nonatomic, strong) UIImageView   *iconImageView;

@property (nonatomic, strong) UILabel  *nameLabel;

@property (nonatomic, strong) UILabel  *countNumLabel;

@property (nonatomic, strong) UILabel  *btcPricelLabel;

@property (nonatomic, strong) UILabel  *cnyPriceLael;

@property (nonatomic, strong) UILabel  *upOrDownLabel;




@end

@implementation JYMarketBaseCell


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
    [self.contentView addSubview:self.countNumLabel];
    [self.contentView addSubview:self.btcPricelLabel];
    [self.contentView addSubview:self.cnyPriceLael];
    [self.contentView addSubview:self.upOrDownLabel];
    
    WS(weakSelf);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.offset(10);
        make.height.width.mas_equalTo(34);
        make.top.equalTo(weakSelf.contentView).offset(12);
        make.bottom.equalTo(weakSelf.contentView).offset(-12);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImageView.mas_top);
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(10);
        make.height.offset(16);
    }];
    
    
    [self.countNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-11);
        make.left.equalTo(weakSelf.iconImageView.mas_right).offset(10);
        make.height.offset(11);
    }];
    
    [self.upOrDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).offset(-10);
        make.height.offset(34);
        make.width.offset(71);
    }];
    
    [self.btcPricelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImageView.mas_top);
        make.right.equalTo(weakSelf.upOrDownLabel.mas_left).offset(-10);
        make.height.offset(14);
    }];
    
    [self.cnyPriceLael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-11);
        make.right.equalTo(weakSelf.upOrDownLabel.mas_left).offset(-10);
        make.height.offset(11);
    }];
}


- (void)setProduct:(JYMarketModel *)product
{
    
    _product = product;
    
    //    self.iconImageView.backgroundColor = [UIColor redColor];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:[UIImage imageNamed:@"默认图"]];
    
    
    NSString * bName = product.code;
    
    
    NSString *count = [NSString stringWithFormat:@"24H量：%@",product.yesterdaySalesView];
    
    NSString *price;
    if (product.type.integerValue == 0) {
        price = product.usdtPriceView;
    }else{
        price = product.btcPriceView;
    }
    NSString *btc = [NSString stringWithFormat:@"%@",price];
    NSString *cny = [NSString stringWithFormat:@"￥%.2lf",[product.priceView floatValue]];
    
    NSString *updown = product.lastGainsView;
    NSString *upordown = [NSString stringWithFormat:@"%.2lf%%",[updown floatValue]];
    
    if (upordown.doubleValue>0) {
        
        self.upOrDownLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
        self.btcPricelLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
        upordown = [NSString stringWithFormat:@"+%.2lf%%",[updown floatValue]];
        
    }else if (upordown.doubleValue == 0){
        
        self.upOrDownLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONDefault);
        self.btcPricelLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONDefault);
        upordown = [NSString stringWithFormat:@"+%.2lf%%",[updown floatValue]];
        
        
    }else{
        self.upOrDownLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        self.btcPricelLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        upordown = [NSString stringWithFormat:@"%.2lf%%",[updown floatValue]];
        
    }
    
    
    NSString * allName;
    if ([self.type isEqualToString:@"1"]) {
        
        allName   = [NSString stringWithFormat:@"(%@)",product.name];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",bName,allName]];
        NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:allName].location, [[noteStr string] rangeOfString:allName].length);
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:redRange];
        [noteStr addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"#555555") range:redRange];
        [self.nameLabel setAttributedText:noteStr];
        
    }else if ([self.type isEqualToString:@"2"]){
        if (product.type.integerValue == 0) {
            allName  = [NSString stringWithFormat:@"/%@",@"USDT"];
        }else{
            allName  = [NSString stringWithFormat:@"/%@",@"BTC"];
        }
        
        self.nameLabel.text = [NSString stringWithFormat:@"%@%@",bName,allName];
    }
    
    
    
    
    self.countNumLabel.text = count;
    
    self.btcPricelLabel.text = btc;
    self.cnyPriceLael.text = cny;
    self.upOrDownLabel.text = upordown;
    
}


- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 17.0f;
        _iconImageView.layer.masksToBounds = YES;
        
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        //        _nameLabel.font = [UIFont  fontWithName:@"Helvetica-Bold" size:15];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = HEX_COLOR(@"#000000");
    }
    return _nameLabel;
}

- (UILabel *)countNumLabel
{
    if (!_countNumLabel) {
        _countNumLabel = [UILabel new];
        _countNumLabel.font = [UIFont systemFontOfSize:13];
        _countNumLabel.textColor = HEX_COLOR(@"#555555");
    }
    return _countNumLabel;
    
}

- (UILabel *)btcPricelLabel
{
    if (!_btcPricelLabel) {
        _btcPricelLabel = [UILabel new];
        _btcPricelLabel.font = [UIFont systemFontOfSize:14];
        _btcPricelLabel.textColor = HEX_COLOR(@"#555555");
    }
    return _btcPricelLabel;
    
}

- (UILabel *)cnyPriceLael
{
    if (!_cnyPriceLael) {
        _cnyPriceLael = [UILabel new];
        _cnyPriceLael.font = [UIFont systemFontOfSize:12];
        _cnyPriceLael.textColor = HEX_COLOR(@"#555555");
    }
    return _cnyPriceLael;
    
}

- (UILabel *)upOrDownLabel
{
    if (!_upOrDownLabel) {
        _upOrDownLabel = [UILabel new];
        _upOrDownLabel.font = [UIFont systemFontOfSize:13];
        _upOrDownLabel.textColor = HEX_COLOR(@"#ffffff");
        _upOrDownLabel.textAlignment = NSTextAlignmentCenter;
        _upOrDownLabel.layer.cornerRadius = 3.0f;
        _upOrDownLabel.layer.masksToBounds = YES;
        _upOrDownLabel.adjustsFontSizeToFitWidth = YES;
        _upOrDownLabel.minimumFontSize = 0.1;
    }
    return _upOrDownLabel;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
