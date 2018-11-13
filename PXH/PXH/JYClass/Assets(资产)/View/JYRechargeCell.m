//
//  JYRechargeCell.m
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYRechargeCell.h"

@interface JYRechargeCell ()

@property (nonatomic, strong) UILabel       *rechargeNumLab;
@property (nonatomic, strong) UILabel       *presentNumLab;
@property (nonatomic, strong) UILabel       *dateLab;
@property (nonatomic, strong) UILabel       *stausLab;

@end


@implementation JYRechargeCell

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
    UILabel *rechargeNameLab = [self creatLabWithText:@"充币数额："];
    UILabel *presentNameLab = [self creatLabWithText:@"赠送数额："];
    UILabel *dateNameLab = [self creatLabWithText:@"充币日期："];
    
    WS(weakSelf)
    [rechargeNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15.f);
        make.width.mas_equalTo(80);
    }];
    
    [self.stausLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.rechargeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rechargeNameLab);
        make.left.equalTo(rechargeNameLab.mas_right);
        make.right.equalTo(self.stausLab.mas_left).mas_offset(-10);
    }];
    
    
    [presentNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rechargeNameLab.mas_bottom).mas_offset(10);
        make.left.width.equalTo(rechargeNameLab);
    }];
    [self.presentNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(presentNameLab);
        make.left.equalTo(presentNameLab.mas_right);
        make.right.mas_equalTo(-15.f);
    }];

    [dateNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.presentNumLab.mas_bottom).mas_offset(10);
        make.left.width.equalTo(rechargeNameLab);
        make.bottom.mas_equalTo(-15.f);
    }];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateNameLab);
        make.left.equalTo(dateNameLab.mas_right);
        make.right.mas_equalTo(-15.f);
    }];
}

-(void)setModel:(JYRechargeModel *)model
{
    self.rechargeNumLab.text = [NSString stringWithFormat:@"%@%@", model.rechargeAmount, model.coinCode];
    self.presentNumLab.text = [NSString stringWithFormat:@"%@AT", model.presentAmount?model.presentAmount:@"0"];
    self.dateLab.text = model.rechargeDate;
    
    NSInteger statusId = model.rechargeStatus.integerValue;
    NSString *statusTitle = @"转入失败";
    switch (statusId) {
        case 0:statusTitle = @"转入中"; break;
        case 1:statusTitle = @"转入成功"; break;
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


-(UILabel *)rechargeNumLab
{
    if (!_rechargeNumLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _rechargeNumLab = lab;
    }
    return _rechargeNumLab;
}

-(UILabel *)presentNumLab
{
    if (!_presentNumLab) {
        UILabel *lab = UILabel.new;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab];
        
        _presentNumLab = lab;
    }
    return _presentNumLab;
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
