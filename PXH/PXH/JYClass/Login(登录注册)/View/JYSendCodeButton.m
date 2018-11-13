//
//  JYSendCodeButton.m
//  PXH
//
//  Created by LX on 2018/5/30.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYSendCodeButton.h"

static NSString *JYSendCode_URL = @"/mobile/user/sendCode";

@interface JYSendCodeButton ()

@property (nonatomic, strong) NSTimer *timer;



@property (nonatomic, assign) NSInteger countSeconds;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, copy) NSString *mobile;

@end


@implementation JYSendCodeButton

- (instancetype)initWithSeconds:(NSInteger)seconds currentVC:(id)vc action:(SEL)action
{
    _seconds = seconds;
    
    self = [JYSendCodeButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self = [JYSendCodeButton buttonWithType:UIButtonTypeCustom];
        [self setTitle:@" 获取验证码 " forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
        
        [self addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)sendCodeMobile:(NSString *)mobile yzm:(NSString *)yzm type:(NSString *)type;
{
    _mobile = mobile;
    
    self.enabled = NO;
    [self setTitle:@"正在发送" forState:UIControlStateNormal];
    
    NSString *keys = [[NSUserDefaults standardUserDefaults] objectForKey:JYFigureCheckCodeKey];
    NSLog(@"\n+++图形验证码key: %@", keys);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:4];
    parameters[@"mobile"] = mobile;
    parameters[@"yzm"] = yzm;
    parameters[@"type"] = type;
    parameters[@"key"] = keys;
    
    [[SDDispatchingCenter sharedCenter] POST:JYSendCode_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MBProgressHUD showText:@"验证码已发送,请注意查收" toContainer:nil];
        [self setTitle:@"60s" forState:UIControlStateNormal];
        _seconds = 60;
        [self setUpTimer];
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        self.enabled = YES;
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


- (void)setUpTimer
{
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

- (void)countDown
{
    _countSeconds --;
    if (_countSeconds <= 0) {
        [self invalidTimer];
        return;
    }
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%zds", _countSeconds] forState:UIControlStateNormal];
}

- (void)invalidTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
        _startDate = nil;
        self.enabled = YES;
        self.backgroundColor = GoldColor;
        [self setTitle:@"再次获取" forState:UIControlStateNormal];
    }
}


- (void)dealloc
{
    [self invalidTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
