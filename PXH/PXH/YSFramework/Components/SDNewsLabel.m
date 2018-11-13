//
//  SDNewsLabel.m
//  haoyi
//
//  Created by 管振东 on 16/10/8.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "SDNewsLabel.h"

@interface SDNewsLabel ()

@property (nonatomic, strong) UILabel *newsLabel;

@property (nonatomic, strong) NSTimer *timer;

@end

static NSInteger count = 0;

@implementation SDNewsLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
    }
    
    return self;
}

- (void)initSubviews {
    self.clipsToBounds = YES;
    
    _newsLabel = [UILabel new];
    _newsLabel.font = [UIFont systemFontOfSize:13.0];
    _newsLabel.textColor = HEX_COLOR(@"#666666");
    [self addSubview:_newsLabel];
    
    WS(weakSelf);
    [_newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10);
        make.left.offset(10);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
    
    _timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(displayNews) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)setNewsArray:(NSArray *)newsArray {
    _newsArray = [newsArray copy];
    
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (newsArray.count <= 0) {
        _newsLabel.text = @"";
    } else if (newsArray.count == 1) {
        _newsLabel.text = newsArray[0];
    } else {
        _newsLabel.text = newsArray[0];
        count = 1;
        _timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(displayNews) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)displayNews {
    if (self.newsArray.count <= 0) {
        return;
    }
    count ++;
    if (count >= self.newsArray.count) {
        count = 0;
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    
    [_newsLabel.layer addAnimation:animation forKey:@"animationID"];
    _newsLabel.text = self.newsArray[count];
}

- (void)click {
    
    if (self.newsArray.count > 0) {
        if (self.handler) {
            self.handler(count);
        }
    }
}

- (void)clickCallBack:(clickHandler)handler {
    
    self.handler = handler;
}

- (void)dealloc {
    
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
