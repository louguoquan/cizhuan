//
//  JJCardListCell.m
//  PXH
//
//  Created by louguoquan on 2018/9/4.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCardListCell.h"

@interface JJCardListCell ()

@property (nonatomic,strong)UILabel *comeLabel;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UISwitch *stateSwitch;
@property (nonatomic,strong)UILabel *stateLabel;

@end

@implementation JJCardListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (UILabel *)comeLabel
{
    if (!_comeLabel) {
        _comeLabel = [[UILabel alloc]init];
        _comeLabel.font = [UIFont systemFontOfSize:15];
        _comeLabel.textColor = HEX_COLOR(@"#333333");
        _comeLabel.textAlignment = NSTextAlignmentCenter;
        _comeLabel.minimumFontSize = 0.1;
        _comeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _comeLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:15];
        _numberLabel.textColor = HEX_COLOR(@"#333333");
        _numberLabel.adjustsFontSizeToFitWidth = YES;
        _numberLabel.minimumFontSize = 0.1;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.minimumFontSize = 0.1;
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = [UIFont systemFontOfSize:15];
        _stateLabel.textColor = HEX_COLOR(@"#666666");
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

- (UISwitch *)stateSwitch
{
    if (!_stateSwitch) {
        _stateSwitch = [[UISwitch alloc]init];
        [_stateSwitch setBackgroundColor:HEX_COLOR(@"#E1E1E1")];
        [_stateSwitch setOnTintColor:GoldColor];
        [_stateSwitch setThumbTintColor:[UIColor whiteColor]];
        _stateSwitch.layer.cornerRadius = 15.5f;
        _stateSwitch.layer.masksToBounds = YES;
        [_stateSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _stateSwitch;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.comeLabel];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.stateSwitch];
    
    [self.comeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.mas_offset(kScreenWidth/3.0);
        make.height.mas_offset(20);
        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comeLabel.mas_right);
        make.width.mas_offset(kScreenWidth/3.0);
        make.height.mas_offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.stateSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-((kScreenWidth/3.0-60)/2.0));
        //        make.width.mas_offset(kScreenWidth/3.0);
        make.height.mas_offset(30);
        make.centerY.equalTo(self.contentView);
    }];
    
    
    
    
    
}

- (void)switchAction:(UISwitch *)sw{
    
    if (self.JJCardListCellClick) {
        self.JJCardListCellClick();
    }
    
}


- (void)setModel:(JJCardListModel *)model
{
    
    self.comeLabel.text = model.productName;
    self.numberLabel.text = model.trialNo;
    
    if (model.status.integerValue == 1) {
        self.stateSwitch.on = YES;
    }else{
        self.stateSwitch.on = NO;
    }
    
    if ([self.type isEqualToString:@"1"]) {
        
        self.stateSwitch.hidden = YES;
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numberLabel.mas_right);
            make.width.mas_offset(kScreenWidth/3.0);
            make.height.mas_offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        self.stateLabel.text = @"已绑定";
    }
    
}

- (void)setGiftModel:(JJGiftModel *)giftModel
{
 
    [self.comeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@20);
    }];
    self.comeLabel.numberOfLines = 0;
    self.comeLabel.text = giftModel.source;
    [self.comeLabel sizeToFit];
    self.numberLabel.text = [NSString stringWithFormat:@"%@%@",giftModel.machNum,CoinNameChange];
    
    
    if (giftModel.status.integerValue == 1) {
        self.stateSwitch.on = YES;
        self.stateSwitch.userInteractionEnabled = NO;
        self.stateSwitch.alpha = 0.5;
        
        
    }else{
        self.stateSwitch.on = NO;
        self.stateSwitch.userInteractionEnabled = YES;
        self.stateSwitch.alpha = 1;
    }
    
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comeLabel.mas_right);
        make.width.mas_offset(kScreenWidth/3.0);
        make.height.mas_offset(20);
        make.top.equalTo(self.contentView).offset(5);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel);
        make.width.mas_offset(kScreenWidth/3.0);
        make.height.mas_offset(15);
        make.top.equalTo(self.numberLabel.mas_bottom).offset(5);
    }];
    self.timeLabel.text = giftModel.createTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
