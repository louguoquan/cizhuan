//
//  JJCoinInOrOutCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJCoinInOrOutCell.h"

@interface JJCoinInOrOutCell ()

@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *statusLabel;


@end

@implementation JJCoinInOrOutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.mas_offset(40);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_offset(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.height.greaterThanOrEqualTo(@15);
        make.right.equalTo(self.statusLabel.mas_left).offset(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.addressLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_offset(25);
    }];
    
    
    
    
    
    
}

-(void)setModel:(JJCoinInOrOutModel *)model
{
    
    if (self.type.integerValue == 1) {
         self.iconImageView.image = [UIImage imageNamed:@"chongzhi"];
        self.countLabel.text = [NSString stringWithFormat:@"%@%@",model.money,CoinNameChange];
        self.addressLabel.text = [NSString stringWithFormat:@"转入来源:%@",model.turnMoblie];

    }else{
        self.iconImageView.image = [UIImage imageNamed:@"tixian"];
        self.countLabel.text = [NSString stringWithFormat:@"%@%@",model.money,CoinNameChange];
        self.addressLabel.text = [NSString stringWithFormat:@"接收账户:%@",model.collectMoblie];
    }
   
    self.timeLabel.text = model.createTime;
    
    self.statusLabel.text = @"通过";
}


-(void)setBussinessModel:(JJWalletBussinessModel *)bussinessModel
{
    
    
    if (bussinessModel.type.integerValue == 1) {
        self.iconImageView.image = [UIImage imageNamed:@"chongzhi"];
        self.countLabel.text = [NSString stringWithFormat:@"%@%@",bussinessModel.rechargeAmount,bussinessModel.code];
        self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",bussinessModel.address];
        
    }else{
        self.iconImageView.image = [UIImage imageNamed:@"tixian"];
        self.countLabel.text = [NSString stringWithFormat:@"%@%@",bussinessModel.rechargeAmount,bussinessModel.code];
        self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",bussinessModel.address];
    }
    
    self.timeLabel.text = bussinessModel.createTime;
    
    if (bussinessModel.rechargeStatus.integerValue == 0) {
         self.statusLabel.text = @"区块确认中";
    }else if (bussinessModel.rechargeStatus.integerValue == 1){
         self.statusLabel.text = @"已完成";
    }else if (bussinessModel.rechargeStatus.integerValue == -1){
        self.statusLabel.text = @"区块确认失败";
    }
    
   

    
    
//    if (bussinessModel.type.integerValue == 1) {
//        self.iconImageView.image = [UIImage imageNamed:@"chongzhi"];
//        self.statusLabel.text = [NSString stringWithFormat:@"%@%@",bussinessModel.presentAmount,bussinessModel.code];
////        self.addressLabel.text = [NSString stringWithFormat:@"转入来源:%@",bussinessModel.turnMoblie];
//
//
//    }else{
//        self.iconImageView.image = [UIImage imageNamed:@"tixian"];
//        self.statusLabel.text = [NSString stringWithFormat:@"%@%@",bussinessModel.rechargeAmount,bussinessModel.code];
////        self.addressLabel.text = [NSString stringWithFormat:@"接收账户:%@",bussinessModel.collectMoblie];
//    }
//
//    self.statusLabel.textAlignment = NSTextAlignmentRight;
//
//    self.timeLabel.text = bussinessModel.createTime;
//
//    self.countLabel.text = bussinessModel.address;
//    self.countLabel.numberOfLines = 0;
//    [self.countLabel sizeToFit];
//    self.countLabel.text = @"1213123";
//
    
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:17];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}


- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _addressLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}


- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _statusLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
