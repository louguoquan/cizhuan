//
//  JYTradingBaseCell.m
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYTradingBaseCell.h"

@interface JYTradingBaseCell ()

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *pricelLabel;
@property (nonatomic,strong)UILabel *countLabel;


@end

@implementation JYTradingBaseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.pricelLabel];
    
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).offset(8);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(35);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(11);
    }];
    
    [self.pricelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(7);
        make.bottom.equalTo(self.contentView).offset(-7);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.typeLabel.mas_right).offset(8);
        make.height.mas_equalTo(11);
        
    }];
    
    
}

- (void)setModel:(JYTradingBuyOreSellModel *)model
{
    
    
    if (self.type == 1) {
        //卖
        CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI);
        [self.contentView setTransform:transform];
        
        self.typeLabel.text = [NSString stringWithFormat:@"卖%ld",(long)self.row];
        self.typeLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        self.pricelLabel.text = [model.tradePriceStr isEqualToString:@"empty"]?@"--" :model.tradePriceStr;
        self.pricelLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONGLEEN);
        
        if (model.remainStr.doubleValue > 1000000000.0){
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfB",model.remainStr.doubleValue/1000000000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000000000"]){
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfB",model.remainStr.doubleValue/1000000000.00];
            
        }
        else if (model.remainStr.doubleValue > 1000000.0){
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfM",model.remainStr.doubleValue/1000000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000000"]){
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfM",model.remainStr.doubleValue/1000000.00];
            
        }else if (model.remainStr.doubleValue > 1000.0) {
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfK",model.remainStr.doubleValue/1000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000"]) {
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfK",model.remainStr.doubleValue/1000.00];
            
        }
        else if(model.remainStr.length>0){
            model.remainStr = [NSString stringWithFormat:@"%.2lf",model.remainStr.doubleValue];
        }
        self.countLabel.text = [model.remainStr isEqualToString:@"empty"]?@"--" :model.remainStr;
        
        
    }else{
        //买
        self.typeLabel.text = [NSString stringWithFormat:@"买%ld",(long)self.row];
        self.typeLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
        
        self.pricelLabel.text = [model.tradePriceStr isEqualToString:@"empty"]?@"--" :model.tradePriceStr;
        
        self.pricelLabel.dk_textColorPicker = DKColorPickerWithKey(BUTTONRED);
        
        
        if (model.remainStr.doubleValue > 1000000000.0){
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfB",model.remainStr.doubleValue/1000000000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000000000"]){
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfB",model.remainStr.doubleValue/1000000000.00];
            
        }
        else if (model.remainStr.doubleValue > 1000000.0){
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfM",model.remainStr.doubleValue/1000000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000000"]){
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfM",model.remainStr.doubleValue/1000000.00];
            
        }else if (model.remainStr.doubleValue > 1000.0) {
            
            model.remainStr = [NSString stringWithFormat:@"%.2lfK",model.remainStr.doubleValue/1000.0];
            
        }else if ([model.remainStr isEqualToString:@"1000"]) {
            
            model.remainStr = [NSString stringWithFormat:@"%.0lfK",model.remainStr.doubleValue/1000.00];
            
        }
        else if(model.remainStr.length>0){
            model.remainStr = [NSString stringWithFormat:@"%.2lf",model.remainStr.doubleValue];
        }
        self.countLabel.text = [model.remainStr isEqualToString:@"empty"]?@"--" :model.remainStr;
        
 
        
        
    }
    
    
}



- (UILabel *)countLabel{
    
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _countLabel;
    
}

- (UILabel *)pricelLabel{
    
    if (!_pricelLabel) {
        _pricelLabel = [UILabel new];
        _pricelLabel.font = [UIFont systemFontOfSize:13];
    }
    return _pricelLabel;
    
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _typeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
