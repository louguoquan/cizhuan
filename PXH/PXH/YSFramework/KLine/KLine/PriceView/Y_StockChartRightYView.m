//
//  Y_StockChartRightYView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartRightYView.h"
#import "UIColor+Y_StockChart.h"
#import "Masonry.h"

@interface Y_StockChartRightYView ()

@property(nonatomic,strong) UILabel *maxValueLabel;

@property(nonatomic,strong) UILabel *middleValueLabel;

@property(nonatomic,strong) UILabel *minValueLabel;

@end


@implementation Y_StockChartRightYView

-(void)setMaxValue:(CGFloat)maxValue
{
    _maxValue = maxValue;
    if (maxValue>1000000000.0) {
         self.maxValueLabel.text = [NSString stringWithFormat:@"%.2fB",maxValue/1000000000.0];
    }else if(maxValue>1000000.0){
        self.maxValueLabel.text = [NSString stringWithFormat:@"%.2fM",maxValue/1000000.0];
    }else if(maxValue>1000.0){
        self.maxValueLabel.text = [NSString stringWithFormat:@"%.2fK",maxValue/1000.0];
    }else {
         self.maxValueLabel.text = [NSString stringWithFormat:@"%.2f",maxValue];
    }
}

-(void)setMiddleValue:(CGFloat)middleValue
{
    _middleValue = middleValue;
    if (middleValue>1000000000.0) {
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2fB",middleValue/1000000000.0];
    }else if(middleValue>1000000.0){
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2fM",middleValue/1000000.0];
    }else if(middleValue>1000.0){
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2fK",middleValue/1000.0];
    }else {
        self.middleValueLabel.text = [NSString stringWithFormat:@"%.2f",middleValue];
    }
}

-(void)setMinValue:(CGFloat)minValue
{
    _minValue = minValue;
    if (minValue>1000000000.0) {
        self.minValueLabel.text = [NSString stringWithFormat:@"%.2fB",minValue/1000000000.0];
    }else if(minValue>1000000.0){
        self.minValueLabel.text = [NSString stringWithFormat:@"%.2fM",minValue/1000000.0];
    }else if(minValue>1000.0){
        self.minValueLabel.text = [NSString stringWithFormat:@"%.2fK",minValue/1000.0];
    }else {
        self.minValueLabel.text = [NSString stringWithFormat:@"%.2f",minValue];
    }

}

-(void)setMinLabelText:(NSString *)minLabelText
{
    _minLabelText = minLabelText;
    self.minValueLabel.text = minLabelText;
}

#pragma mark - get方法
#pragma mark maxPriceLabel的get方法
-(UILabel *)maxValueLabel
{
    if (!_maxValueLabel) {
        _maxValueLabel = [self private_createLabel];
        [self addSubview:_maxValueLabel];
        [_maxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.width.equalTo(self);
            make.height.equalTo(@20);
        }];
    }
    return _maxValueLabel;
}

#pragma mark middlePriceLabel的get方法
-(UILabel *)middleValueLabel
{
    if (!_middleValueLabel) {
        _middleValueLabel = [self private_createLabel];
        [self addSubview:_middleValueLabel];
        [_middleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _middleValueLabel;
}

#pragma mark minPriceLabel的get方法
-(UILabel *)minValueLabel
{
    if (!_minValueLabel) {
        _minValueLabel = [self private_createLabel];
        [self addSubview:_minValueLabel];
        [_minValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self);
            make.height.width.equalTo(self.maxValueLabel);
        }];
    }
    return _minValueLabel;
}

#pragma mark - 私有方法
#pragma mark 创建Label
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor assistTextColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
}
@end
