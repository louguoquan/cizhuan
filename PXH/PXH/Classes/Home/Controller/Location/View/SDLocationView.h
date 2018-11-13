//
//  SDLocationView.h
//  PXH
//
//  Created by 刘鹏程 on 2017/11/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDLocationView;
@protocol SDLocationViewDelegate <NSObject>

- (void)headerViewDidClickLocationButton:(SDLocationView *)headerView;
- (void)headerViewReturnBack;
- (void)headerView:(SDLocationView *)headerView didClickHistoricalCity:(NSString *)city;
@end

@interface SDLocationView : UIView

@property (nonatomic, strong)UIButton *currentButton;
@property (weak ,nonatomic) id <SDLocationViewDelegate>delegate;

//重新定位
@property (nonatomic, strong)UIButton *relocation;

- (void)updateCurrentCity:(NSString *)city;

@end
