//
//  YSGrowingTextView.h
//  HouseDoctorMember
//
//  Created by yu on 2017/6/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPlaceholderTextView.h"

@class YSGrowingTextView;

@protocol YSGrowingTextViewDelegate <NSObject>

- (BOOL)textView:(YSGrowingTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

typedef void(^YSTextViewChangeHandler)(CGFloat height);

@interface YSGrowingTextView : YSPlaceholderTextView

/**
 *  设置输入框最大行数
 */
@property (nonatomic, assign) NSInteger textViewMaxLine;

@property (nonatomic, copy)   YSTextViewChangeHandler block;

@property (nonatomic, assign) id<YSGrowingTextViewDelegate>     growingTextDelegate;

@end

