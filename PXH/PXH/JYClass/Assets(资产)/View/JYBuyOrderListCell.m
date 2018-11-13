//
//  JYBuyOrderListCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBuyOrderListCell.h"

@interface JYBuyOrderListCell ()

@property (nonatomic,strong)UILabel *orderNumLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UIView *line2;

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *basePriceLabel;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *statusLabel;


@property (nonatomic,strong)UIButton *paySuccessBtn;
@property (nonatomic,strong)UIButton *cancelBtn;


@end

@implementation JYBuyOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    [self.contentView addSubview:self.orderNumLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_offset(12);
        make.top.equalTo(self.contentView).offset(13);
        //        make.bottom.equalTo(self.contentView).offset(-13);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_offset(12);
        make.top.equalTo(self.contentView).offset(13);
        //        make.bottom.equalTo(self.contentView).offset(-13);
    }];
    
    self.line = [UIView new];
    self.line.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset(13);
        make.height.mas_offset(1);
    }];
    
    self.line2 = [UIView new];
    self.line2.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    [self.contentView addSubview:self.line2];
    
    
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.basePriceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.paySuccessBtn];
    [self.contentView addSubview:self.cancelBtn];
    
    
    [self.paySuccessBtn addTarget:self action:@selector(paySuccess) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(payCancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(15);
        make.left.equalTo(self.line);
        make.height.mas_equalTo(12);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    
    [self.basePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.left.equalTo(self.typeLabel.mas_right).offset(15);
        make.height.mas_equalTo(12);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.left.equalTo(self.basePriceLabel.mas_right).offset(15);
        make.height.mas_equalTo(12);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.left.equalTo(self.countLabel.mas_right).offset(15);
        make.height.mas_equalTo(12);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.left.equalTo(self.priceLabel.mas_right).offset(15);
        make.height.mas_equalTo(12);
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    
    [self.paySuccessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.right.equalTo(self.cancelBtn.mas_left).offset(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    
    
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(13);
        make.height.mas_offset(1);
        make.bottom.equalTo(self.contentView).offset(-1);
    }];
    
    
}


- (void)paySuccess{
    if (self.OrderPaySuccess) {
        self.OrderPaySuccess();
    }
    
}

- (void)payCancel{
    
    if (self.OrderPayCancel) {
        self.OrderPayCancel();
    }
}

-(void)setModel:(JYBuyOrderListModel *)model
{
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderNo];
    self.timeLabel.text = [NSString stringWithFormat:@"成交时间:%@",model.createTime];
    
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset(13);
        make.height.mas_offset(1);
    }];
    
    
    self.typeLabel.hidden = NO;
    self.basePriceLabel.hidden = NO;
    self.countLabel.hidden = NO;
    self.priceLabel.hidden = NO;
    self.statusLabel.hidden = NO;
    

    
    self.typeLabel.text = @"买入";
    
    
    self.basePriceLabel.text = model.usdtMoney;
    self.countLabel.text = model.tradeNum;
    self.priceLabel.text = model.tradePrice ;
    
    if (model.orderStatus.integerValue == 0) {
        self.statusLabel.text = @"未付款";
    }else if (model.orderStatus.integerValue == 1){
        self.statusLabel.text = @"待放币";
    }else if (model.orderStatus.integerValue == 2){
        self.statusLabel.text = @"已完成";
    }else if ([model.orderStatus isEqualToString:@"-1"]){
        self.statusLabel.text = @"已取消";
    }

    
    if (model.orderStatus.integerValue == 0) {
        self.paySuccessBtn.hidden = NO;
        self.cancelBtn.hidden = NO;
    }else{
        self.paySuccessBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
    }
}

- (UILabel *)orderNumLabel
{
    if (!_orderNumLabel) {
        _orderNumLabel = [UILabel new];
        _orderNumLabel.font = [UIFont systemFontOfSize:12];
        _orderNumLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _orderNumLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _timeLabel;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _typeLabel;
}

- (UILabel *)basePriceLabel
{
    if (!_basePriceLabel) {
        _basePriceLabel = [UILabel new];
        _basePriceLabel.font = [UIFont systemFontOfSize:12];
        _basePriceLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _basePriceLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _countLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _priceLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:12];
        _statusLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsOrderTEXT);
    }
    return _statusLabel;
}


- (UIButton *)paySuccessBtn
{
    if (!_paySuccessBtn) {
        _paySuccessBtn = [UIButton new];
        _paySuccessBtn.layer.cornerRadius = 3.0f;
        _paySuccessBtn.layer.masksToBounds = YES;
        _paySuccessBtn.layer.borderColor  = HEX_COLOR(@"#2DA5D6").CGColor;
        _paySuccessBtn.layer.borderWidth = 1.0;
        _paySuccessBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_paySuccessBtn setTitle:@"完成付款" forState:UIControlStateNormal];
        [_paySuccessBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsWithBtnBG) forState:UIControlStateNormal];
        _paySuccessBtn.dk_backgroundColorPicker = DKColorPickerWithKey(KLINEHEADBG);
    }
    return _paySuccessBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        _cancelBtn.layer.cornerRadius = 3.0f;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancelBtn dk_setTitleColorPicker:DKColorPickerWithKey(KLINEHEADBG) forState:UIControlStateNormal];
        _cancelBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithBtnBG);
    }
    return _cancelBtn;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
