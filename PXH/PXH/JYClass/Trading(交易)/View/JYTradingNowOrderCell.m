//
//  JYTradingNowOrderCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/27.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingNowOrderCell.h"

@interface JYTradingNowOrderCell ()

@property (nonatomic,strong)UIView *baseView;

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *statusLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *coinLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *priceOther1Label;
@property (nonatomic,strong)UILabel *priceOther2Label;

@property (nonatomic,strong)UIButton *cancelBtn;


@end


@implementation JYTradingNowOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    [self.baseView addSubview:self.statusLabel];
    [self.baseView addSubview:self.typeLabel];
    [self.baseView addSubview:self.timeLabel];
    [self.baseView addSubview:self.coinLabel];
    [self.baseView addSubview:self.priceLabel];
    [self.baseView addSubview:self.priceOther1Label];
    [self.baseView addSubview:self.priceOther2Label];
    [self.baseView addSubview:self.cancelBtn];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.baseView).offset(10);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.centerX.equalTo(self.baseView);
        make.height.mas_equalTo(30);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView).offset(-10);
        make.centerY.equalTo(self.timeLabel);
        make.height.mas_offset(25);
        make.width.mas_equalTo(60);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(13);
    }];
    
    [self.priceOther1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel);
        make.top.equalTo(self.coinLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(13);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel);
        make.centerX.equalTo(self.baseView);
        make.height.mas_equalTo(13);
    }];
    
    [self.priceOther2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceOther1Label);
        make.centerX.equalTo(self.baseView);
        make.height.mas_equalTo(13);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLabel.mas_bottom).offset(10);
        make.right.left.equalTo(self.statusLabel);
        make.height.mas_equalTo(30);
    }];
}

- (void)setModel:(JYTradingOrderModel *)model
{
    
    self.statusLabel.text = @"委托中";
    
    if (model.buyType.integerValue == 0){
        self.typeLabel.text = @"买";
        self.typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONRED);
    }else if (model.buyType.integerValue == 1){
        self.typeLabel.text = @"卖";
        self.typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
    }
    
    self.timeLabel.text = model.createTime; //订单时间
    
    self.priceLabel.text = model.tradePrice;  //委托价格
    self.priceOther1Label.text = model.priceDeal; //买入价格
    
    self.coinLabel.text = model.coinNum;   //委托数量
    self.priceOther2Label.text = model.coinDeal;  //成交数量
    
}

- (void)matchCancel{
    
    if (self.MatchCancel) {
        self.MatchCancel();
    }
    
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.layer.cornerRadius = 2.0f;
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.dk_textColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _typeLabel.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
    }
    return _typeLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _timeLabel;
}

- (UILabel *)coinLabel
{
    if (!_coinLabel) {
        _coinLabel = [UILabel new];
        _coinLabel.font = [UIFont systemFontOfSize:13];
        _coinLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _coinLabel;
}


- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _priceLabel;
}

- (UILabel *)priceOther1Label
{
    if (!_priceOther1Label) {
        _priceOther1Label = [UILabel new];
        _priceOther1Label.font = [UIFont systemFontOfSize:13];
        _priceOther1Label.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _priceOther1Label;
}

- (UILabel *)priceOther2Label
{
    if (!_priceOther2Label) {
        _priceOther2Label = [UILabel new];
        _priceOther2Label.font = [UIFont systemFontOfSize:13];
        _priceOther2Label.dk_textColorPicker = DKColorPickerWithKey(AssetsTimeTEXT);
    }
    return _priceOther2Label;
}

- (UIView *)baseView
{
    if (!_baseView ) {
        _baseView = [UIView new];
        _baseView.layer.cornerRadius = 4.0f;
        _baseView.layer.masksToBounds = YES;
        _baseView.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBG);
    }
    return _baseView;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:13];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.layer.cornerRadius = 2.0f;
        _statusLabel.layer.masksToBounds = YES;
        _statusLabel.dk_textColorPicker = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _statusLabel.dk_backgroundColorPicker = DKColorPickerWithKey(TRADINGStatusBG);
    }
    return _statusLabel;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"撤单" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_cancelBtn dk_setTitleColorPicker:DKColorPickerWithKey(TRADINGStatusBG) forState:UIControlStateNormal];
        _cancelBtn.dk_backgroundColorPicker  = DKColorPickerWithKey(MARKETBottomAdvertiseTEXT);
        _cancelBtn.layer.cornerRadius = 4.0f;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderColor = HEX_COLOR(@"#218DBC").CGColor;
        _cancelBtn.layer.borderWidth = 1.0f;
        [_cancelBtn addTarget:self action:@selector(matchCancel) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _cancelBtn;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
