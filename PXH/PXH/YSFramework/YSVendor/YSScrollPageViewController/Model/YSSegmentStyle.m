//
//  YSSegmentStyle.m
//  HouseDoctorMonitor
//
//  Created by yu on 16/8/26.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSSegmentStyle.h"

@implementation YSSegmentStyle

- (instancetype)init {
    if(self = [super init]) {
            //纯文本
        self.segmentItemType = YSSegmentItemTypeForText;
        
        self.canScrollTitle = NO;

        self.itemHeight = 45;
        self.itemMargin = 15;
        
        self.titleFont = [UIFont systemFontOfSize:14];
        
        self.subTitleFont = [UIFont systemFontOfSize:12];
        
        self.normalSubTitleColor = HEX_COLOR(@"#333333");
        self.selectedSubTitleColor = HEX_COLOR(@"#333333");
        
        self.titleBigScale = 1.3;
        self.scaleTitle = NO;

        self.normalTitleColor = HEX_COLOR(@"#333333");
        self.selectedTitleColor = GoldColor;
        
        self.gradualChangeTitleColor = NO;
        
        self.showMaskView = NO;
    
        self.showScrollLine = YES;
        
        self.scrollLineColor = GoldColor;
        
        self.scrollLineSize = CGSizeMake(0, 2.f);
        
        self.backgroundColor = [UIColor whiteColor];

        self.containerBackgroundColor = [UIColor whiteColor];
        
        self.bottomLineColor = HEX_COLOR(@"#EFEFEF");
        
    }
    return self;
}

@end
