//
//  YSCalendarView.m
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCalendarView.h"

#import "YSCalendarView.h"

@interface YSCalendarItem : UIView

@property (nonatomic, strong) UILabel  *dateLabel;

@property (nonatomic, strong) UIImageView   *markImageView;

@property (nonatomic, assign) NSInteger  day;

@property (nonatomic, strong) YSCalendarComponent   *component;

@end

@implementation YSCalendarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    WS(weakSelf);
    
    _dateLabel = [UILabel new];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textColor = HEX_COLOR(@"#666666");
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
    
    _markImageView = [UIImageView new];
    _markImageView.image = [UIImage imageNamed:@"signin_check"];
    [self addSubview:_markImageView];
    [_markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(_dateLabel.mas_right).offset(5);
    }];
    
    _markImageView.hidden = YES;
    
}

- (void)setDay:(NSInteger)day
{
    _day = day;
    
    _dateLabel.text = [NSString stringWithFormat:@"%zd",_day];
    
}

- (void)setComponent:(YSCalendarComponent *)component
{
    _component = component;
    
    BOOL status = [_component.status integerValue] == 1 ? NO : YES;
    _markImageView.hidden = status;
    
//    WS(weakSelf);
//    CGFloat offset = status ? 0 : -10;
//    [_dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf).offset(offset);
//    }];
}

@end


@implementation YSCalendarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    NSDate *today = [NSDate date];
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:today];
    
    NSDate *firstDate = [today dateByAddingDays:-today.day + 1];
    NSInteger weekDay = firstDate.weekday - 1;
    
    CGFloat width = kScreenWidth / 7.0;
    
    CGFloat maxHeight = 0;
    for (NSInteger i = weekDay; i < (days.length + weekDay); i ++) {
        NSInteger x = i % 7;
        NSInteger y = i / 7;
        YSCalendarItem *item = [YSCalendarItem new];
        item.day = i - weekDay + 1;
        item.frame = CGRectMake(x * width, y * 30, width, 30);
        [self addSubview:item];
        
        maxHeight = CGRectGetMaxY(item.frame);
    }
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(maxHeight));
    }];
}

- (void)setComponents:(NSArray *)components
{
    _components = components;
    if ([_components count] <= 0) {
        return;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSDate *today = [NSDate date];
    
    NSDate *firstDate = [today dateByAddingDays:-today.day + 1];
    NSInteger weekDay = firstDate.weekday - 1;
    
    CGFloat width = kScreenWidth / 7.0;
    
    CGFloat maxHeight = 0;
    for (NSInteger i = weekDay; i < ([_components count] + weekDay); i ++) {
        NSInteger x = i % 7;
        NSInteger y = i / 7;
        YSCalendarItem *item = [YSCalendarItem new];
        item.day = i - weekDay + 1;
        item.component = _components[(i - weekDay)];
        item.frame = CGRectMake(x * width, y * 30, width, 30);
        [self addSubview:item];
        
        maxHeight = CGRectGetMaxY(item.frame);
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(maxHeight));
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
