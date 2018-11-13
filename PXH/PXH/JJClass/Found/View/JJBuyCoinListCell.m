//
//  JJBuyCoinListCell.m
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "JJBuyCoinListCell.h"

@interface JJBuyCoinListCell ()

@property (nonatomic,strong)UILabel *countLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *statusLabel;

@end

@implementation JJBuyCoinListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.height.mas_offset(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.countLabel.mas_bottom).offset(5);
        make.height.mas_offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_offset(20);
    }];
    
}

- (void)setModel:(JJBuyCoinListModel *)model
{
    self.countLabel.text = [NSString stringWithFormat:@"%@ %@",CoinNameChange,model.buyNumber];
    self.timeLabel.text = model.ct;
    
    self.statusLabel.textColor = HEX_COLOR(@"#333333");
    if (model.orderStatus.integerValue == 0) {
        self.statusLabel.text = @"未完成";
    }else if (model.orderStatus.integerValue == 1){
        self.statusLabel.text = @"审核中";
        self.statusLabel.textColor = GoldColor;
    }else if (model.orderStatus.integerValue == 2){
        self.statusLabel.text = @"已完成";
    }
    
    
    
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:18];
        _countLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _countLabel;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = HEX_COLOR(@"#666666");
    }
    return _timeLabel;
}


- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = [UIFont systemFontOfSize:20];
        _statusLabel.textColor = HEX_COLOR(@"#333333");
    }
    return _statusLabel;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
