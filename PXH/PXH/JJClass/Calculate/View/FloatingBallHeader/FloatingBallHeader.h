//
//  FloatingBallHeader.h
//  FloatingBall
//
//  Created by CygMac on 2018/6/7.
//  Copyright © 2018年 XunKu. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const FloatingBallHeaderHeight = 430;

typedef void(^JJMineCalculateClick)();
typedef void(^JJMineCalculateTimeOut)();

@class FloatingBallHeader;
@protocol FloatingBallHeaderDelegate <NSObject>

- (void)floatingBallHeader:(FloatingBallHeader *)floatingBallHeader didPappaoAtIndex:(NSInteger)index isLastOne:(BOOL)isLastOne;

@end

@interface FloatingBallHeader : UIView

@property (nonatomic, weak) id<FloatingBallHeaderDelegate> delegate;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic,strong)NSString *count;
@property (nonatomic,strong)NSString *count1;
@property (nonatomic,strong)JJMineCalculateClick JJMineCalculateClick;
@property (nonatomic,strong)JJMineCalculateTimeOut JJMineCalculateTimeOut;

@property (nonatomic,assign)long long secondsCountDown;

// 重置动画，因为页面disappear会将layer动画移除
- (void)resetAnimation;
// 移除所有泡泡
- (void)removeAllPaopao;

@end
