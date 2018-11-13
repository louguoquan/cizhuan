//
//  YSValidateButton.m
//  ZSMStores
//
//  Created by yu on 16/8/5.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSValidateButton.h"

@interface YSValidateButton ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, assign) NSInteger countSeconds;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, copy) NSString *number;

@end

@implementation YSValidateButton

- (instancetype)initWithSeconds:(NSInteger)seconds {
    
    _seconds = seconds;
    self = [YSValidateButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self = [YSValidateButton buttonWithType:UIButtonTypeCustom];
        [self setTitle:@" 获取验证码 " forState:UIControlStateNormal];
//        [self setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
//        self.backgroundColor = MAIN_COLOR;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupTimer) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    return self;
}

- (void)sendCodeToPhoneNumber:(NSString *)number type:(NSInteger)type
{
    _number = number;
    
    if (![number matchesRegex:@"^[1][3-8]\\d{9}$" options:NSRegularExpressionCaseInsensitive]) {
        [MBProgressHUD showErrorMessage:@"手机号码格式不正确" toContainer:nil];
        return;
    }
    
    self.enabled = NO;
    [self setTitle:@"正在发送" forState:UIControlStateNormal];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"mobile"] = number;
    parameters[@"type"] = @(type);
    [[SDDispatchingCenter sharedCenter] POST:kSendCode_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD showSuccessMessage:@"验证码已发送,请注意查收" toContainer:nil];
        [self setTitle:@"60s" forState:UIControlStateNormal];
        _seconds = 60;
        [self setupTimer];
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        self.enabled = YES;
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

- (void)setupTimer {
    
    if (!_timer && !_startDate && _seconds > 0) {
        _countSeconds = _seconds;
        _startDate = [NSDate date];
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    } else {
        NSDate *nowDate = [NSDate date];
        NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:_startDate];
        _countSeconds = _seconds - timeInterval;
    }
}

- (void)countDown {
    _countSeconds --;
    if (_countSeconds <= 0) {
        [self invalidTimer];
        return;
    }
    [self setTitle:[NSString stringWithFormat:@"%zds", _countSeconds] forState:UIControlStateNormal];
}

- (void)invalidTimer {
    
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
        _startDate = nil;
        self.enabled = YES;
        [self setTitle:@"再次获取" forState:UIControlStateNormal];
    }
}

- (void)dealloc {
    [self invalidTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
