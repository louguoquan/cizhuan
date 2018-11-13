//
//  FloatingBallHeader.m
//  FloatingBall
//
//  Created by CygMac on 2018/6/7.
//  Copyright © 2018年 XunKu. All rights reserved.
//

#import "FloatingBallHeader.h"
#import "PaopaoButton.h"
#import <RBBAnimation/RBBTweenAnimation.h>

// 最多显示泡泡的数量
static NSInteger const PaopaoMaxNum = 10;

@interface FloatingBallHeader ()

// 背景图
@property (nonatomic, strong) UIImageView *bgIcon;

// 背景图
@property (nonatomic, strong) UIImageView *bgIcon1;

// 泡泡button，固定十个，隐藏显示控制
@property (nonatomic, strong) NSArray <PaopaoButton *> *paopaoBtnArray;
// 当前显示的泡泡数据
@property (nonatomic, strong) NSMutableArray *showDatas;
// x最多可选取的随机数值因数
@property (nonatomic, strong) NSMutableArray <NSNumber *> *xFactors;
// y最多可选取的随机数值因数
@property (nonatomic, strong) NSMutableArray <NSNumber *> *yFactors;

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *countLabel1;

//创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
@property(nonatomic,strong)NSTimer*countDownTimer;

@end

@implementation FloatingBallHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化数组
        self.showDatas = [NSMutableArray arrayWithCapacity:PaopaoMaxNum];
        
        // 布局
        [self addSubview:self.bgIcon];
        self.bgIcon.frame = frame;
        
        for (UIButton *paopao in self.paopaoBtnArray) {
            paopao.frame = CGRectMake(0, 0, 50.0/(375.0/kScreenWidth), 60.0/(375.0/kScreenWidth));
            [self addSubview:paopao];        }
        
        
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"bg_bg6"];
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self).offset(80);
            make.height.mas_offset(35);
            make.width.mas_offset(124);
        }];
        [img addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(img);
        }];
        
        
        UIImageView *img1 = [[UIImageView alloc]init];
        img1.image = [UIImage imageNamed:@"bg_bg6_1"];
        [self addSubview:img1];
        [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(80);
            make.height.mas_offset(35);
            make.width.mas_offset(124);
        }];
        [img1 addSubview:self.countLabel1];
        [self.countLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(img1);
        }];
        
        
        
        UITapGestureRecognizer *TAP = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        img.userInteractionEnabled = YES;
        [img addGestureRecognizer:TAP];
    }
    
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    
    if (self.JJMineCalculateClick) {
        self.JJMineCalculateClick();
    }
    
}

-(void)setCount:(NSString *)count
{
    self.countLabel.text = [NSString stringWithFormat:@"当前算力:%@",count];
}

- (void)setCount1:(NSString *)count1
{
    self.countLabel1.text = [NSString stringWithFormat:@"%@:%@",CoinNameChange,count1];
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    if (_dataList.count == 0) {
        
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
        //启动倒计时后会每秒钟调用一次方法 countDownAction
        PaopaoButton *paopao = self.paopaoBtnArray[0];
        //设置倒计时显示的时间
        NSString *str_hour = [NSString stringWithFormat:@"%02lld",self.secondsCountDown/3600];//时
        NSString *str_minute = [NSString stringWithFormat:@"%02lld",(self.secondsCountDown%3600)/60];//分
//        NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];//秒
        NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_hour,str_minute];
        paopao.centerLabel.text = [NSString stringWithFormat:@"%@",format_time];
        paopao.bottomLabel.text = @"正在生成";
        [paopao setPaopaoImage:[UIImage imageNamed:@"golabel_notCan"]];
        paopao.userInteractionEnabled = NO;
        paopao.tag = 0;
        paopao.hidden = NO;
//        [paopao setTitle:@"正在生成中"];
        CGPoint randomPoint = [self getRandomPoint];
        paopao.center = randomPoint;
        [self addFloatAnimationWithPaopao:paopao];
        [self.showDatas addObject:@"format_time"];
    }else{
        
        for (NSInteger i = 0; i < dataList.count; i++) {
            if (self.showDatas.count == PaopaoMaxNum) {
                return;
            }
            PaopaoButton *paopao = self.paopaoBtnArray[i];
            paopao.tag = i;
            paopao.hidden = NO;
            [paopao setTitle:dataList[i]];
            CGPoint randomPoint = [self getRandomPoint];
            paopao.center = randomPoint;
            [self addFloatAnimationWithPaopao:paopao];
            [self.showDatas addObject:dataList[i]];
        }
    }
}


//实现倒计时动作
-(void)countDownAction{
    //倒计时-1
    self.secondsCountDown--;
    
    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02lld",self.secondsCountDown/3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02lld",(self.secondsCountDown%3600)/60];
    
//    NSString *str_second = [NSString stringWithFormat:@"%02ld",secondsCountDown%60];
    
    //启动倒计时后会每秒钟调用一次方法 countDownAction
    PaopaoButton *paopao = self.paopaoBtnArray[0];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_hour,str_minute];
     paopao.centerLabel.text = [NSString stringWithFormat:@"%@",format_time];
    
    
    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(self.secondsCountDown==0){
        
        if (self.JJMineCalculateTimeOut) {
            self.JJMineCalculateTimeOut();
        }
        [_countDownTimer invalidate];
    }
    
}


#pragma mark - 泡泡加动画

- (void)addFloatAnimationWithPaopao:(PaopaoButton *)paopao {
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        paopao.alpha =1.0;
    } completion:^(BOOL finished) {
        
    }];
    
    
    RBBTweenAnimation *sinus = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    sinus.fromValue = @(0);
    sinus.toValue = @(3);
    sinus.easing = ^CGFloat (CGFloat fraction) {
        return sin((fraction) * 2 * M_PI);
    };
    sinus.additive = YES;
    sinus.duration = [self getRandomNumber:3 to:5];
    sinus.repeatCount = HUGE_VALF;
    [paopao.layer addAnimation:sinus forKey:@"sinus"];
}

// 重置动画，因为页面disappear会将layer动画移除
- (void)resetAnimation {
    for (NSInteger i = 0; i < self.showDatas.count; i++) {
        PaopaoButton *paopao = self.paopaoBtnArray[i];
        [self addFloatAnimationWithPaopao:paopao];
    }
}

// 移除所有泡泡
- (void)removeAllPaopao {
    for (PaopaoButton *paopao in self.paopaoBtnArray) {
        paopao.hidden = YES;
    }
    [self.showDatas removeAllObjects];
}

#pragma mark - 获取随机点坐标

- (CGPoint)getRandomPoint {
    CGFloat x = [self getRandomX];
    CGFloat y = [self getRandomY];
    return CGPointMake(x, y);
}

- (CGFloat)getRandomX {
    NSInteger index = arc4random() % self.xFactors.count;
    CGFloat factor = self.xFactors[index].floatValue;
    CGFloat x = 33 + (self.frame.size.width - 60) * factor;
    [self.xFactors removeObjectAtIndex:index];
    return x;
}

- (CGFloat)getRandomY {
    NSInteger index = arc4random() % self.yFactors.count;
    CGFloat factor = self.yFactors[index].floatValue;
    CGFloat y = (150 + (FloatingBallHeaderHeight - 150 - 120) * factor)/(667/kScreenHeight);
    [self.yFactors removeObjectAtIndex:index];
    return y;
}

/*
 - (CGPoint)getRandomPoint {
 CGFloat x = [self getRandomNumber:50 to:SCREEN_WIDTH - 50];
 CGFloat y = [self getRandomNumber:130 to:HomeHeaderBgIconHeight - 160];
 return CGPointMake(x, y);
 }
 */
- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}


#pragma mark - 泡泡点击

- (void)paopaoClick:(UITapGestureRecognizer *)tap {
    
    UIView * sender = tap.view;
    
    
    [JYAccountModel sharedAccount].BallClick(sender.tag);
    
    
    [JYAccountModel sharedAccount].BallClickReceive = ^{
        [self hide:sender];
    };
    
    
    
    

}

- (void)hide:(UIView *)sender{
    
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        sender.alpha = 0.0;
        //        sender.frame = CGRectMake(sender.frame.origin.x, -70, sender.frame.size.width, sender.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            sender.hidden = YES;
            NSInteger num = 0;
            for (NSInteger i = 0; i < self.paopaoBtnArray.count; i++) {
                PaopaoButton *paopao = self.paopaoBtnArray[i];
                if (paopao.isHidden) {
                    num++;
                }
            }
            if (num == PaopaoMaxNum) {
                [self.showDatas removeAllObjects];
                self.xFactors = nil;
                self.yFactors = nil;
            }
            if ([self.delegate respondsToSelector:@selector(floatingBallHeader:didPappaoAtIndex:isLastOne:)]) {
                [self.delegate floatingBallHeader:self didPappaoAtIndex:sender.tag isLastOne:num == PaopaoMaxNum];
            }
        }
    }];
    
}

#pragma mark - Get

- (UIImageView *)bgIcon {
    if (!_bgIcon) {
        _bgIcon = [[UIImageView alloc] init];
        _bgIcon.contentMode = UIViewContentModeScaleAspectFill;
        _bgIcon.clipsToBounds = YES;
        _bgIcon.image = [UIImage imageNamed:@"suanliBanner"];
    }
    return _bgIcon;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = GoldColor;
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.adjustsFontSizeToFitWidth = YES;
        _countLabel.minimumFontSize = 0.1;
        
    }
    return _countLabel;
}

- (UIImageView *)bgIcon1 {
    if (!_bgIcon1) {
        _bgIcon1 = [[UIImageView alloc] init];
        _bgIcon1.contentMode = UIViewContentModeScaleAspectFill;
        _bgIcon1.clipsToBounds = YES;
        _bgIcon1.image = [UIImage imageNamed:@"suanliBanner"];
    }
    return _bgIcon1;
}

- (UILabel *)countLabel1
{
    if (!_countLabel1) {
        _countLabel1 = [[UILabel alloc]init];
        _countLabel1.textColor = GoldColor;
        _countLabel1.font = [UIFont systemFontOfSize:14];
        _countLabel1.textAlignment = NSTextAlignmentCenter;
        _countLabel1.adjustsFontSizeToFitWidth = YES;
        _countLabel1.minimumFontSize = 0.1;
    }
    return _countLabel1;
}


- (NSArray<PaopaoButton *> *)paopaoBtnArray {
    if (!_paopaoBtnArray) {
        NSMutableArray *marr = [NSMutableArray arrayWithCapacity:PaopaoMaxNum];
        for (NSInteger i = 0; i < PaopaoMaxNum; i++) {
            PaopaoButton *button = [[PaopaoButton alloc] init];
            [button setPaopaoImage:[UIImage imageNamed:@"golabel"]];
            button.hidden = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(paopaoClick:)];
            button.userInteractionEnabled = YES;
            [button addGestureRecognizer:tap];
//            [button addTarget:self action:@selector(paopaoClick:) forControlEvents:UIControlEventTouchUpInside];
            [marr addObject:button];
        }
        _paopaoBtnArray = marr;
    }
    return _paopaoBtnArray;
}

- (NSMutableArray<NSNumber *> *)xFactors {
    if (!_xFactors) {
        _xFactors = [NSMutableArray arrayWithArray:@[@(0.00f), @(0.11f), @(0.22f), @(0.33f), @(0.44f), @(0.55f), @(0.66f), @(0.77f), @(0.88f), @(0.99)]];
    }
    return _xFactors;
}

- (NSMutableArray<NSNumber *> *)yFactors {
    if (!_yFactors) {
        _yFactors = [NSMutableArray arrayWithArray:@[@(0.00f), @(0.11f), @(0.22f), @(0.33f), @(0.44f), @(0.55f), @(0.66f), @(0.77f), @(0.88f), @(0.99)]];
    }
    return _yFactors;
}

@end
