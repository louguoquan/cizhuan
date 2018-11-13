//
//  YSDIYBackFooter.m
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSDIYBackFooter.h"

@interface YSDIYBackFooter ()

@property (nonatomic, strong) UIView    *lineView;

@property (nonatomic, strong) UILabel   *tipsLabel;

@end

@implementation YSDIYBackFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = RefrenshHeight;
    self.backgroundColor = BACKGROUND_COLOR;
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = LINE_COLOR;
    [self addSubview:self.lineView];
    
    self.tipsLabel = [UILabel new];
    self.tipsLabel.backgroundColor = BACKGROUND_COLOR;
    self.tipsLabel.font = [UIFont systemFontOfSize:13];
    self.tipsLabel.textColor = HEX_COLOR(@"#333333");
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.text = @"继续拖动，查看详情";
    [self addSubview:self.tipsLabel];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    self.lineView.frame = CGRectMake(0, self.height / 2.0, self.width, 1);
    
    CGFloat width = 11 * 13 + 30;
    self.tipsLabel.frame = CGRectMake((self.width - width) / 2.0, 0, width, self.height);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    //    switch (state) {
    //        case MJRefreshStateIdle:
    //            [self.loading stopAnimating];
    //            [self.s setOn:NO animated:YES];
    //            self.label.text = @"赶紧上拉吖(开关是打酱油滴)";
    //            break;
    //        case MJRefreshStatePulling:
    //            [self.loading stopAnimating];
    //            [self.s setOn:YES animated:YES];
    //            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
    //            break;
    //        case MJRefreshStateRefreshing:
    //            [self.loading startAnimating];
    //            [self.s setOn:YES animated:YES];
    //            self.label.text = @"加载数据中(开关是打酱油滴)";
    //            break;
    //        case MJRefreshStateNoMoreData:
    //            [self.loading stopAnimating];
    //            self.label.text = @"木有数据了(开关是打酱油滴)";
    //            [self.s setOn:NO animated:YES];
    //        default:
    //            break;
    //    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    //    // 1.0 0.5 0.0
    //    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
