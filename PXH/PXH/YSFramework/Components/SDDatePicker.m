//
//  SDDatePicker.m
//  SundayFramework
//
//  Created by 管振东 on 16/4/27.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "SDDatePicker.h"

@interface SDDatePicker ()

@property (nonatomic, copy) pickerHandler dateHandler;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *btnCancel;

@property (nonatomic, strong) UIButton *btnConfirm;

@end

@implementation SDDatePicker

- (instancetype)initWithType:(MMPopupType)popupType datePickerMode:(UIDatePickerMode)datePickerMode handler:(pickerHandler)dateHandler {
    
    self = [super init];
    
    if (self) {
        if (popupType == MMPopupTypeSheet) {
            
            [MMPopupWindow sharedWindow].touchWildToHide = YES;
            
            self.type = MMPopupTypeSheet;
            
            self.backgroundColor = [UIColor whiteColor];
            
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenWidth);
                make.height.mas_equalTo(216+40);
            }];
            
            self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide)];
            [self addSubview:self.btnCancel];
            [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(80, 40));
                make.left.top.equalTo(self);
            }];
            [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
            [self.btnCancel setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
            
            
            self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionConfirm)];
            [self addSubview:self.btnConfirm];
            [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(80, 40));
                make.right.top.equalTo(self);
            }];
            [self.btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
            [self.btnConfirm setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            
            self.datePicker = [UIDatePicker new];
            self.datePicker.datePickerMode = datePickerMode;
            self.dateHandler = dateHandler;
            [self addSubview:self.datePicker];
            [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(40, 0, 0, 0));
            }];
        } else {
            [MMPopupWindow sharedWindow].touchWildToHide = NO;
            
            self.type = MMPopupTypeAlert;
            
            self.layer.cornerRadius = 2.0;
            self.clipsToBounds = YES;
            
            MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
            
            self.backgroundColor = [UIColor whiteColor];
            
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kScreenWidth - 10);
                make.height.mas_equalTo(216+40);
            }];
            
            self.datePicker = [UIDatePicker new];
            self.datePicker.datePickerMode = datePickerMode;
            self.dateHandler = dateHandler;
            [self addSubview:self.datePicker];
            [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 40, 0));
            }];
            
            self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide)];
            [self addSubview:self.btnCancel];
            [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@40);
                make.width.equalTo(self).dividedBy(2);
                make.bottom.equalTo(self);
                make.left.equalTo(self).offset(-MM_SPLIT_WIDTH);
            }];
            [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
            [self.btnCancel setTitleColor:HEX_COLOR(@"#666666") forState:UIControlStateNormal];
            self.btnCancel.layer.borderColor = config.splitColor.CGColor;
            self.btnCancel.layer.borderWidth = MM_SPLIT_WIDTH;
            [self.btnCancel setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
            [self.btnCancel setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
            
            self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionConfirm)];
            [self addSubview:self.btnConfirm];
            [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(self.btnCancel);
                make.bottom.equalTo(self);
                make.right.equalTo(self).offset(-MM_SPLIT_WIDTH);
            }];
            [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
            [self.btnConfirm setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            self.btnConfirm.layer.borderColor = config.splitColor.CGColor;
            self.btnConfirm.layer.borderWidth = MM_SPLIT_WIDTH;
            [self.btnConfirm setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
            [self.btnConfirm setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
        }
    }
    
    return self;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    _datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    
    _datePicker.maximumDate = maximumDate;
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    
    _datePicker.date = defaultDate;
}

- (void)actionConfirm {
    
    if (self.dateHandler) {
        self.dateHandler(_datePicker.date);
    }
    [self hide];
}

- (void)actionHide
{
    [self hide];
}

@end
