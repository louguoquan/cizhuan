//
//  JYExchangeCell.m
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYExchangeCell.h"

@interface JYExchangeCell ()

@property (nonatomic, strong) UILabel       *numLab;
@property (nonatomic, strong) UILabel       *poundageLab;
@property (nonatomic, strong) UILabel       *addressLab;
@property (nonatomic, strong) UILabel       *dateLab;
@property (nonatomic, strong) UILabel       *stausLab;

@end


@implementation JYExchangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI
{
    UILabel *numNameLab = [self creatLabWithText:@"提币数量："];
    UILabel *poundageNameLab = [self creatLabWithText:@"手续费："];
    UILabel *addressNameLab = [self creatLabWithText:@"提币地址："];
    UILabel *dateNameLab = [self creatLabWithText:@"提币日期："];
    
    WS(weakSelf)
    [numNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15.f);
        make.width.mas_equalTo(80);
    }];

    [self.stausLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(numNameLab);
        make.left.equalTo(numNameLab.mas_right);
        make.right.equalTo(self.stausLab.mas_left).mas_offset(-10);
    }];
    
    
    [poundageNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numNameLab.mas_bottom).mas_offset(10);
        make.left.width.equalTo(numNameLab);
    }];
    [self.poundageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(poundageNameLab);
        make.left.equalTo(poundageNameLab.mas_right);
        make.right.mas_equalTo(-15.f);
    }];
    
    [addressNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(poundageNameLab.mas_bottom).mas_offset(10);
        make.left.width.equalTo(numNameLab);
    }];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressNameLab);
        make.left.equalTo(addressNameLab.mas_right);
        make.right.mas_equalTo(-15.f);
    }];
    
    [dateNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLab.mas_bottom).mas_offset(10);
        make.left.width.equalTo(numNameLab);
        make.bottom.mas_equalTo(-15.f);
    }];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateNameLab);
        make.left.equalTo(dateNameLab.mas_right);
        make.right.mas_equalTo(-15.f);
    }];
}


-(void)setModel:(JYExchangeModel *)model
{
    self.numLab.text = [NSString stringWithFormat:@"%@%@", model.amount, model.coinCode];
    self.poundageLab.text = [NSString stringWithFormat:@"%@%@", model.tradeFee?model.tradeFee:@"0", model.coinCode];
    self.addressLab.text = model.toAddress;
    self.dateLab.text = model.createTime;
    
    NSInteger statusId = model.tradeStatus.integerValue;
    NSString *statusTitle = @"取消";
    switch (statusId) {
        case 0:statusTitle = @"未完成"; break;
        case 1:statusTitle = @"已完成"; break;
    }
    self.stausLab.text = statusTitle;
}


- (UILabel *)creatLabWithText:(NSString *)text
{
    UILabel *lab = UILabel.new;
    lab.font = [UIFont systemFontOfSize:15];
    lab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lab];
    lab.text = text;
    
    return lab;
}


-(UILabel *)numLab
{
    if (!_numLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _numLab = lab;
    }
    return _numLab;
}

-(UILabel *)poundageLab
{
    if (!_poundageLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _poundageLab = lab;
    }
    return _poundageLab;
}

-(UILabel *)addressLab
{
    if (!_addressLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _addressLab = lab;
    }
    return _addressLab;
}

-(UILabel *)dateLab
{
    if (!_dateLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _dateLab = lab;
    }
    return _dateLab;
}

-(UILabel *)stausLab
{
    if (!_stausLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 5.f;
        lab.dk_textColorPicker = DKColorPickerWithKey(NAVBG);
        lab.dk_backgroundColorPicker = DKColorPickerWithKey(VIEW_BG);
        [self.contentView addSubview:lab];
        
        _stausLab = lab;
    }
    return _stausLab;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
