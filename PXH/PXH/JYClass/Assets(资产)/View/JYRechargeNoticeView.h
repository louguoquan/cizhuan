//
//  JYRechargeNoticeView.h
//  PXH
//
//  Created by LX on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPopupView.h"

@interface JYRechargeNoticeView : JYPopupView

/**
 @param content 须知内容
 */
- (instancetype)initWithNoticeContent:(NSString *)content;

@property (nonatomic, copy) void(^afterForPromptBlock)(BOOL sel);

@end
