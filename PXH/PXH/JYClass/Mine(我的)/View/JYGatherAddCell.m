//
//  JYGatherAddCell.m
//  PXH
//
//  Created by LX on 2018/6/13.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYGatherAddCell.h"

@interface JYGatherAddCell ()

@property (nonatomic, strong) UIView            *bgView;

@property (nonatomic, strong) UIImageView       *iconImgView;
@property (nonatomic, strong) UILabel           *bankNameLab;
@property (nonatomic, strong) UISwitch          *defaultSwitch;
@property (nonatomic, strong) UILabel           *cardNumLab;

@end


@implementation JYGatherAddCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    WS(weakSelf)

    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.iconImgView];
    [self.bgView addSubview:self.bankNameLab];
    [self.bgView addSubview:self.defaultSwitch];
    [self.bgView addSubview:self.cardNumLab];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(20.f);
        make.width.height.mas_equalTo(45.f);
    }];
    
    [self.bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImgView);
        make.left.equalTo(weakSelf.iconImgView.mas_right).offset(20);
    }];
    
    [self.defaultSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bankNameLab);
        make.right.mas_equalTo(-20);
        make.left.equalTo(weakSelf.bankNameLab.mas_right).offset(30);
    }];
    
    [self.cardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImgView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.bankNameLab);
        make.right.equalTo(weakSelf.defaultSwitch);
        make.bottom.mas_equalTo(-20.f);
    }];
}

//设置阴影、圆角
- (void)setShadow:(UIView *)view
{
    //提前告诉CoreAnimation要渲染的View的形状Shape,减少离屏渲染计算
//    [view.layer setShadowPath:[UIBezierPath bezierPathWithRect:view.bounds].CGPath];
    view.layer.shadowColor = [UIColor grayColor].CGColor;
    view.layer.shadowRadius = 3.f;
    view.layer.shadowOffset = CGSizeMake(0, -3);
    view.layer.shadowOpacity = 0.5f;
    view.layer.cornerRadius = 5.f;
    view.clipsToBounds = NO;
}

- (void)setUpDefaultAction:(UISwitch *)dSwitch
{
    !_setDefaultAddBlock?:_setDefaultAddBlock(dSwitch, dSwitch.isOn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


-(void)setAddModel:(JYGatherAddModel *)addModel
{
    _addModel = addModel;
    
    self.iconImgView.image = [UIImage imageNamed:@"icon_bankCard"];
    
    self.bankNameLab.text = addModel.openBank;

    self.cardNumLab.text = [self getNewBankNumWitOldBankNum:addModel.cardNum];
    
    self.defaultSwitch.on = addModel.ifDefault.boolValue;
}


//银行卡号，星号格式化处理
- (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum
{
    if (!bankNum.length) return bankNum;
    
//    //指定格式（非真实位数）
//    if(bankNum.length<4){
//        [MBProgressHUD showText:@"请确认银行卡号" toContainer:nil];
//        return bankNum;
//    }
    
    return [NSString stringWithFormat:@"****    ****    ****    %@", [bankNum substringFromIndex:bankNum.length-4]];
    
    //根据真实位数
    NSMutableString *mutableStr = [NSMutableString stringWithString:bankNum];
    for (int i=0; i<bankNum.length; i++) {//bankNum.length-4
        //星号处理(2 = @"  ".length)
        if (i<bankNum.length-4) [mutableStr replaceCharactersInRange:NSMakeRange(i+(i/4)*2, 1) withString:@"*"];
        //空格处理( || (i==bankNum.length-4-1))
        if ((i%4)==3) [mutableStr insertString:@"  " atIndex:i+1+(i/4)*2];
    }
    return mutableStr;
}


-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.dk_backgroundColorPicker = DKColorPickerWithKey(BUTTONBG);
        [self setShadow:_bgView];
    }
    return _bgView;
}

-(UIImageView *)iconImgView
{
    if (!_iconImgView) {
        UIImageView *imgView = [UIImageView new];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.layer.cornerRadius = 45/2;
        imgView.layer.masksToBounds = YES;
        
        _iconImgView = imgView;
    }
    return _iconImgView;
}

-(UILabel *)bankNameLab
{
    if (!_bankNameLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:15.f];
        lab.dk_textColorPicker = DKColorPickerWithKey(LABELTEXT);
        
        _bankNameLab = lab;
    }
    return _bankNameLab;
}

- (UISwitch *)defaultSwitch
{
    if (!_defaultSwitch) {
        UISwitch *dSwitch = [[UISwitch alloc] init];
        dSwitch.layer.masksToBounds = YES;
        dSwitch.layer.cornerRadius = 15.5f;//默认大小 51.0f 31.0f
        [dSwitch addTarget:self action:@selector(setUpDefaultAction:) forControlEvents:UIControlEventValueChanged];
        dSwitch.dk_backgroundColorPicker = DKColorPickerWithKey(LABELTEXT);
        dSwitch.dk_tintColorPicker = DKColorPickerWithKey(LABELTEXT);
        
        _defaultSwitch = dSwitch;
    }
    return _defaultSwitch;
}


-(UILabel *)cardNumLab
{
    if (!_cardNumLab) {
        UILabel *lab = [UILabel new];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:17.f];
//        lab.dk_textColorPicker = DKColorPickerWithKey(LABELTEXT);
        
        _cardNumLab = lab;
    }
    return _cardNumLab;
}


@end
