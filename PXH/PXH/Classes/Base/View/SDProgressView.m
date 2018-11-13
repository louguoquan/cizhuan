//
//  SDProgressView.m
//  yzr
//
//  Created by 管振东 on 2017/3/2.
//  Copyright © 2017年 guanzd. All rights reserved.
//

#import "SDProgressView.h"

@interface SDProgressView () <CAAnimationDelegate>

@property (nonatomic, copy) progressHandler handler;

@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, strong) CAShapeLayer  *trackLayer;

@property (nonatomic, strong) CAShapeLayer  *progressLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) UIBezierPath  *path;

@end

@implementation SDProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.trackColor = [UIColor blackColor];
    self.progressColor = [UIColor grayColor];
    self.animationDuration = 1.5;
    self.lineWidth = 2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self trackLayer];
    [self gradientLayer];
    
    _trackLayer.frame = self.bounds;
    _gradientLayer.frame = self.bounds;
}

#pragma mark - getter

- (UIBezierPath *)path {
    
    switch (_style) {
        case SDProgressLineStyle: {
            _path = [UIBezierPath bezierPath];
            [_path moveToPoint:CGPointMake(self.lineWidth / 2.0, self.lineWidth/2)];
            [_path addLineToPoint:CGPointMake(self.width - self.lineWidth / 2.0, self.lineWidth/2)];
        }
            break;
        case SDProgressCircleStyle: {
            CGFloat halfWidth = self.width * 0.5;
            _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfWidth, halfWidth)
                                                   radius:(self.width - self.lineWidth)/2
                                               startAngle:-M_PI/2
                                                 endAngle:M_PI/2*3
                                                clockwise:YES]; // 顺时针
        }
            break;
        default:
            break;
    }
    
    return _path;
}

- (CAShapeLayer *)trackLayer {
    
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.zPosition = -1;
        [self setLayer:_trackLayer withColor:self.trackColor];
        [self.layer addSublayer:_trackLayer];
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        //这里的颜色不起作用
        [self setLayer:_progressLayer withColor:[UIColor redColor]];
        _progressLayer.strokeEnd = 0;
    }
    return _progressLayer;
}

- (CAGradientLayer *)gradientLayer {
    
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.zPosition = -1;
        if (_progressColor && !self.gradientColors) {
            self.gradientColors = @[_progressColor,_progressColor];
        }
        NSMutableArray *arr = [NSMutableArray array];
        for (UIColor *color in self.gradientColors) {
            [arr addObject:(id)color.CGColor];
        }
        _gradientLayer.colors = arr;
        switch (_style) {
            case SDProgressCircleStyle:
                _gradientLayer.startPoint = CGPointMake(0.5, 1);
                _gradientLayer.endPoint = CGPointMake(0.5, 0);
                break;
            case SDProgressLineStyle:
                _gradientLayer.startPoint = CGPointMake(0, 0.5);
                _gradientLayer.endPoint = CGPointMake(1, 0.5);
                break;
            default:
                break;
        }
        _gradientLayer.mask = self.progressLayer;
        [self.layer addSublayer:_gradientLayer];
    }
    return _gradientLayer;
}

- (void)setLayer:(CAShapeLayer *)layer withColor:(UIColor *)color {
    
    layer.frame = self.bounds;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = self.lineWidth;
    layer.path = self.path.CGPath;
    
    switch (_style) {
        case SDProgressCircleStyle:
            layer.lineCap = kCALineCapButt; // 无端点
            break;
        case SDProgressLineStyle:
            layer.lineCap = kCALineCapRound; // 圆形端点
            break;
        default:
            break;
    }
}

- (void)updatePercent:(CGFloat)percent animated:(BOOL)animated progress:(progressHandler)handler {

    self.percent = percent;
    self.handler = handler;
    
    [self.progressLayer removeAllAnimations];
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0.0);
        animation.toValue = @(self.percent / 100.);
        animation.duration = self.animationDuration * self.percent / 100.;
        animation.removedOnCompletion = YES;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        self.progressLayer.strokeEnd = self.percent / 100.;
        [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:self.animationDuration];
        
        self.progressLayer.strokeEnd = self.percent / 100.0;
        
        [CATransaction commit];
        
        if (self.handler) {
            self.handler(self.percent);
        }
    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"首页刷新" object:nil];
}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    
    _percent = _percent > 100 ? 100 : _percent;
    _percent = _percent < 0 ? 0: _percent;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
    if (self.handler) {
        [self invalidateTimer];
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerAction)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self invalidateTimer];
    }
}

- (void)timerAction {
    id strokeEnd = [[_progressLayer presentationLayer] valueForKey:@"strokeEnd"];
    if (![strokeEnd isKindOfClass:[NSNumber class]]) {
        return;
    }
    CGFloat progress = [strokeEnd floatValue];
    if (self.handler) {
        self.handler(progress * 100);
    }
}

- (void)invalidateTimer {
    if (!self.displayLink) {
        return;
    }
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
