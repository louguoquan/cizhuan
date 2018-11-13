//
//  JYBenefitsCell.m
//  PXH
//
//  Created by LX on 2018/6/8.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYBenefitsCell.h"

@interface JYBenefitsCell ()

@property (nonatomic, strong) UILabel       *serialNumLab;

@property (nonatomic, strong) UILabel       *iphoneNumLab;

@property (nonatomic, strong) UILabel       *peopleNumLab;

@property (nonatomic, strong) UILabel       *coinNumLab;

@property (nonatomic, strong) UILabel       *coinTypeLab;

@end

@implementation JYBenefitsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
//
//        self.iphoneNumLab.text = [self replaceStringWithAsterisk:@"15279898989" startLocation:3 lenght:4];
    }
    return self;
}

- (void)setUpUI
{
    UILabel *noLab = [UILabel new];
    noLab.text = @"NO.";
    noLab.textAlignment = NSTextAlignmentLeft;
    noLab.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15];
    noLab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
    [self.contentView addSubview:noLab];

    WS(weakSelf)
    [noLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    [self.serialNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noLab.mas_right);
        make.bottom.equalTo(noLab.mas_bottom);
    }];
    
    [self.iphoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noLab.mas_bottom).mas_offset(10);
        make.left.equalTo(noLab);
        make.bottom.mas_equalTo(-15);
        make.width.mas_equalTo(100);
    }];
    
    [self.peopleNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iphoneNumLab);
        make.left.equalTo(weakSelf.iphoneNumLab.mas_right).mas_offset(10);
    }];
    
    [self.coinTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iphoneNumLab);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(55);
    }];
    
    [self.coinNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iphoneNumLab);
        make.left.equalTo(weakSelf.peopleNumLab.mas_right).mas_offset(10);
        make.right.equalTo(weakSelf.coinTypeLab.mas_left).mas_offset(-10);
    }];
}


- (void)setModel:(JYBenefitsModel *)model
{
 
    self.serialNumLab.text = self.index;
    self.peopleNumLab.text = [NSString stringWithFormat:@"%@人", model.peopleNum];
    
   self.iphoneNumLab.text = [self replaceStringWithAsterisk:model.mobile startLocation:3 lenght:4];
    
    self.coinNumLab.text = model.commission;
    
}

//MARK: -- 字符串星号处理
-(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght
{
    NSString *newStr = originalStr;
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    
    return newStr;
}


-(UILabel *)serialNumLab
{
    if (!_serialNumLab) {
        UILabel *lab = [UILabel new];
        lab.text = @"1";
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont fontWithName:@"Verdana-Italic" size:17];
        [self.contentView addSubview:lab];
        
        _serialNumLab = lab;
    }
    return _serialNumLab;
}

-(UILabel *)iphoneNumLab
{
    if (!_iphoneNumLab) {
        UILabel *lab = [UILabel new];
//        lab.text = @"152****4688";
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab];
        
        _iphoneNumLab = lab;
    }
    return _iphoneNumLab;
}

-(UILabel *)peopleNumLab
{
    if (!_peopleNumLab) {
        UILabel *lab = [UILabel new];
        lab.text = @"136人";
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab];
        
        _peopleNumLab = lab;
    }
    return _peopleNumLab;
}

-(UILabel *)coinNumLab
{
    if (!_coinNumLab) {
        UILabel *lab = [UILabel new];
        lab.text = @"12344.78951";
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab];
        
        _coinNumLab = lab;
    }
    return _coinNumLab;
}

-(UILabel *)coinTypeLab
{
    if (!_coinTypeLab) {
        UILabel *lab = [UILabel new];
        lab.text = @"AT";
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:lab];
        lab.dk_textColorPicker = DKColorPickerWithKey(WEALLABELTEXT);
        
        _coinTypeLab = lab;
    }
    return _coinTypeLab;
}

@end
