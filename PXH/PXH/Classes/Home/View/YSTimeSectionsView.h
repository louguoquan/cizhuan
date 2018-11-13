//
//  YSTimeSectionsView.h
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSLimitBuyTime.h"

typedef void(^TimeSelectBlock)(YSLimitBuyTime *time);

@interface YSTimeSectionsView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSArray *timeSections;

- (void)setTimeSections:(NSArray *)timeSections currentTime:(YSLimitBuyTime *)currentTime;

- (void)timeSectionDidChange:(TimeSelectBlock)block;

@end
