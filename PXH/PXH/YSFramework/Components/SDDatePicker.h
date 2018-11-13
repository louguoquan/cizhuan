//
//  SDDatePicker.h
//  SundayFramework
//
//  Created by 管振东 on 16/4/27.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^pickerHandler)(NSDate *date);

@interface SDDatePicker : MMPopupView

@property (nonatomic, strong) NSDate *defaultDate;

@property (nonatomic, strong) NSDate *maximumDate;

@property (nonatomic, strong) NSDate *minimumDate;

- (instancetype)initWithType:(MMPopupType)popupType datePickerMode:(UIDatePickerMode)datePickerMode handler:(pickerHandler)dateHandler;

@end
