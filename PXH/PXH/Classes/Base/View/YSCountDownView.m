//
//  YSCountDownView.m
//  OLCircle
//
//  Created by yu on 2017/4/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCountDownView.h"

@interface YSCountDownView ()

@property (nonatomic, assign) CGFloat   itemWidth;

@property (nonatomic, strong) UILabel   *hoursLabel;

@property (nonatomic, strong) UILabel   *minutesLabel;

@property (nonatomic, strong) UILabel   *secondsLabel;

@property (nonatomic, strong) NSTimer   *timer;

//单位秒
@property (nonatomic, assign) NSInteger     remainingTime;

@end

@implementation YSCountDownView

- (void)dealloc {
    [self resetTimer];
}

- (instancetype)initWithItemWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        _itemWidth = width;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    WS(weakSelf);
    
    UIView *lastView = nil;
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *timeLabel = [self getTimeLabel];
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.top.bottom.height.equalTo(lastView);
                make.left.equalTo(lastView.mas_right);
                if (i == 2) {
                    make.right.offset(0);
                }
            }else {
                make.left.top.bottom.height.equalTo(weakSelf);
            }
        }];
        
        if (i != 2) {
            
            UILabel *label = [UILabel new];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.text = @":";
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                make.left.equalTo(timeLabel.mas_right);
                make.width.equalTo(@10);
            }];
            lastView = label;
        }
        
        switch (i) {
            case 0:
                self.hoursLabel = timeLabel;
                break;
            case 1:
                self.minutesLabel = timeLabel;
                break;
            case 2:
                self.secondsLabel = timeLabel;
                break;
        }
    }
}

- (UILabel *)getTimeLabel {
    WS(weakSelf);
    UILabel *label = [UILabel new];
    label.text = @"00";
    label.textColor = MAIN_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15];
    label.backgroundColor = [UIColor whiteColor];
//    label.layer.borderWidth = 1;
//    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.cornerRadius = 1;
    label.layer.masksToBounds = YES;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.itemWidth);
    }];
    
    return label;
}

- (void)resetTimer {
    [_timer invalidate];
    _timer = nil;
}

    //秒
- (void)setTimerWithRemainingTime:(NSInteger)remainingTime {
    if (remainingTime <= 0) {
        return;
    }
    
    _remainingTime = remainingTime;
    [self updateTimeLabel];
    
    _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimeLabel {
    _remainingTime -= 1;
    if (_remainingTime <= 0) {
        self.hoursLabel.text = @"00";
        
        self.minutesLabel.text = @"00";
        
        self.secondsLabel.text = @"00";
        
        [self resetTimer];
        if (self.block) {
            self.block(nil, nil);
        }
        return;
    }
    
    NSUInteger hour = (NSInteger)(_remainingTime / (60.0 * 60.0));
    NSUInteger minutes = (NSInteger)((_remainingTime - hour * (60.0 * 60.0)) / 60.0);
    NSUInteger seconds = (NSInteger)(_remainingTime - hour * (60.0 * 60.0) - minutes * 60.0);
    
    self.hoursLabel.text = [NSString stringWithFormat:@"%02zd",hour];
    
    self.minutesLabel.text = [NSString stringWithFormat:@"%02zd",minutes];
    
    self.secondsLabel.text = [NSString stringWithFormat:@"%02zd",seconds];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
