//
//  JYAssetsHomeCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAssetsHomeCell.h"

@interface JYAssetsHomeCell ()

@property (nonatomic,strong)UILabel *coinNameLabel;      //币的名称
@property (nonatomic,strong)UILabel *canUseLabel;        //币的可用数量
@property (nonatomic,strong)UILabel *freeLabel;          //币的冻结数量
@property (nonatomic,strong)UILabel *combineLabel;       //币的合计数量
@property (nonatomic,strong)UILabel *cnyLabel;           //折合人民币价格

@property (nonatomic,strong)UIButton *c2cBtn;            //C2C
@property (nonatomic,strong)UIButton *topUpBtn;          //充币
@property (nonatomic,strong)UIButton *withdrawalBtn;     //提币

@property (nonatomic,strong)UIImageView *errorImageView;

@end

@implementation JYAssetsHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.coinNameLabel];
    [self.contentView addSubview:self.canUseLabel];
    [self.contentView addSubview:self.freeLabel];
    [self.contentView addSubview:self.combineLabel];
    [self.contentView addSubview:self.cnyLabel];
    [self.contentView addSubview:self.c2cBtn];
    [self.contentView addSubview:self.topUpBtn];
    [self.contentView addSubview:self.withdrawalBtn];
    [self.contentView addSubview:self.errorImageView];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.font = [UIFont systemFontOfSize:13];
    label1.text = @"可用:";
    label1.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.font = [UIFont systemFontOfSize:13];
    label2.text = @"冻结:";
    label2.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.contentView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.font = [UIFont systemFontOfSize:13];
    label3.text = @"合计:";
    label3.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.contentView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.font = [UIFont systemFontOfSize:13];
    label4.text = @"折合(CNY):";
    label4.dk_textColorPicker = DKColorPickerWithKey(EditOptionalHEADERTEXT);
    [self.contentView addSubview:label4];
    
    
    
    [self.coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(17);
        make.height.mas_equalTo(17);
    }];
    
    
    [self.errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinNameLabel);
        make.left.equalTo(self.coinNameLabel.mas_right).offset(5);
        make.width.height.mas_equalTo(20);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsLine);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coinNameLabel.mas_bottom).offset(11);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(2);
    }];
    
    [self.canUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(11);
        make.height.mas_equalTo(11);
        make.left.equalTo(label1.mas_right).offset(5);
        make.right.equalTo(label2.mas_left).offset(-10);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseLabel);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(11);
    }];
    
    
    [self.combineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canUseLabel.mas_bottom).offset(11);
        make.height.mas_equalTo(11);
        make.left.equalTo(label3.mas_right).offset(5);
        make.right.equalTo(label4.mas_left).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-11);
    }];
    
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.combineLabel);
        make.left.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(11);
    }];
    
    
    
    [self.freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(11);
        make.height.mas_equalTo(11);
        make.left.equalTo(label2.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freeLabel);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(12);
        make.height.mas_equalTo(11);
    }];
    
    
    
    [self.cnyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freeLabel.mas_bottom).offset(11);
        make.height.mas_equalTo(11);
        make.left.equalTo(label4.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cnyLabel);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(30);
        make.height.mas_equalTo(11);
    }];
    
    
    [self.withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(9);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(27);
    }];
    
    [self.topUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(9);
        make.right.equalTo(self.withdrawalBtn.mas_left).offset(-10);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(27);
    }];
    
    
    [self.c2cBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(9);
        make.right.equalTo(self.topUpBtn.mas_left).offset(-10);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(27);
    }];
    
    self.c2cBtn.hidden = YES;
    self.errorImageView.hidden = YES;
}




-(void)setModel:(JYAssetsModel *)model
{
    
    if ([model.coinCode isEqualToString:@"USDT"]) {
        self.c2cBtn.hidden = NO;
        [self.topUpBtn setTitle:@"充币" forState:UIControlStateNormal];
    }else{
        self.c2cBtn.hidden = YES;
        [self.topUpBtn setTitle:@"充币" forState:UIControlStateNormal];
    }
    
//
//    if (model.withdrawStatus.integerValue == 1) {
//        [_withdrawalBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
//        _withdrawalBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithdrawalBG);
//    }else{
//
//        [_withdrawalBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
//        _withdrawalBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnGrey);
//
//    }
    
//    if (model.chargeStatus.integerValue == 1) {
//        [_topUpBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
//        _topUpBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnTopUPBG);
//    }else{
//        [_topUpBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
//        _topUpBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnGrey);
//    }
//    
    
    if (model.chargeStatus.integerValue != 1 || model.withdrawStatus.integerValue != 1) {
        self.errorImageView.hidden = NO;
    }
    else{
        self.errorImageView.hidden = YES;
    }
    
    
    
    self.coinNameLabel.text = model.coinCode;
    
    self.canUseLabel.text = [NSString stringWithFormat:@"%@",model.balance];
    self.freeLabel.text = [NSString stringWithFormat:@"%@",model.freezeBalance];
    self.combineLabel.text = [NSString stringWithFormat:@"%@",model.total];
    self.cnyLabel.text = [NSString stringWithFormat:@"%@",model.fold];
    
}


- (void)click:(UIButton *)btn{
    
    if ([[btn currentTitle]isEqualToString:@"C2C"]) {
        if (self.C2CClick) {
            self.C2CClick();
        }
    }else if ([[btn currentTitle] isEqualToString:@"转币"]){
        if (self.RollOutClick) {
            self.RollOutClick();
        }
    }else if ([[btn currentTitle] isEqualToString:@"充币"]){
        if (self.TopUpClick) {
            self.TopUpClick();
        }
    }else if ([[btn currentTitle] isEqualToString:@"提币"]){
        if (self.WithdrawalClick) {
            self.WithdrawalClick();
        }
    }
    
    
}

- (UILabel *)coinNameLabel
{
    if (!_coinNameLabel) {
        _coinNameLabel = [UILabel new];
        _coinNameLabel.font = [UIFont systemFontOfSize:17];
        _coinNameLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
        _coinNameLabel.textAlignment = NSTextAlignmentRight;
     
    }
    return _coinNameLabel;
}


- (UILabel *)canUseLabel
{
    if (!_canUseLabel) {
        _canUseLabel = [UILabel new];
        _canUseLabel.font = [UIFont systemFontOfSize:13];
        _canUseLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
        _canUseLabel.adjustsFontSizeToFitWidth = YES;
        _canUseLabel.textAlignment = NSTextAlignmentRight;
        _canUseLabel.minimumFontSize = 0.1;
    }
    return _canUseLabel;
}


- (UILabel *)freeLabel
{
    if (!_freeLabel) {
        _freeLabel = [UILabel new];
        _freeLabel.font = [UIFont systemFontOfSize:13];
        _freeLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
        _freeLabel.adjustsFontSizeToFitWidth = YES;
        _freeLabel.textAlignment = NSTextAlignmentRight;
        _freeLabel.minimumFontSize = 0.1;
    }
    return _freeLabel;
}


- (UILabel *)combineLabel
{
    if (!_combineLabel) {
        _combineLabel = [UILabel new];
        _combineLabel.font = [UIFont systemFontOfSize:13];
        _combineLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
        _combineLabel.adjustsFontSizeToFitWidth = YES;
        _combineLabel.textAlignment = NSTextAlignmentRight;
        _combineLabel.minimumFontSize = 0.1;
    }
    return _combineLabel;
}


- (UILabel *)cnyLabel
{
    if (!_cnyLabel) {
        _cnyLabel = [UILabel new];
        _cnyLabel.font = [UIFont systemFontOfSize:13];
        _cnyLabel.textAlignment = NSTextAlignmentRight;
        _cnyLabel.dk_textColorPicker = DKColorPickerWithKey(AssetsTEXT);
        _cnyLabel.adjustsFontSizeToFitWidth = YES;
        _cnyLabel.minimumFontSize = 0.1;
    }
    return _cnyLabel;
}


- (UIButton *)c2cBtn
{
    if (!_c2cBtn) {
        _c2cBtn = [UIButton new];
        [_c2cBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
        [_c2cBtn setTitle:@"C2C" forState:UIControlStateNormal];
        _c2cBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _c2cBtn.layer.cornerRadius = 3.0f;
        _c2cBtn.layer.masksToBounds = YES;
        _c2cBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnTopUPBG);
        [_c2cBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _c2cBtn;
}


- (UIButton *)topUpBtn
{
    if (!_topUpBtn) {
        _topUpBtn = [UIButton new];
        [_topUpBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
        [_topUpBtn setTitle:@"充币" forState:UIControlStateNormal];
        _topUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _topUpBtn.layer.cornerRadius = 3.0f;
        _topUpBtn.layer.masksToBounds = YES;
        _topUpBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsBtnTopUPBG);
        [_topUpBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topUpBtn;
}


- (UIButton *)withdrawalBtn
{
    if (!_withdrawalBtn) {
        _withdrawalBtn = [UIButton new];
        [_withdrawalBtn dk_setTitleColorPicker:DKColorPickerWithKey(AssetsBtnTEXT) forState:UIControlStateNormal];
        [_withdrawalBtn setTitle:@"提币" forState:UIControlStateNormal];
        _withdrawalBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _withdrawalBtn.layer.cornerRadius = 3.0f;
        _withdrawalBtn.layer.masksToBounds = YES;
        _withdrawalBtn.dk_backgroundColorPicker = DKColorPickerWithKey(AssetsWithdrawalBG);
        [_withdrawalBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawalBtn;
}

- (UIImageView *)errorImageView
{
    if (!_errorImageView) {
        _errorImageView = [[UIImageView alloc]init];
        _errorImageView.image = [UIImage imageNamed:@"tanhao"];
        
    }
    return _errorImageView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
