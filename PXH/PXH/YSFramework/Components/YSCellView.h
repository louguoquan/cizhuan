//
//  YSCellView.h
//  ZSMMember
//
//  Created by yu on 16/7/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellClickHandler)();

typedef NS_ENUM(NSInteger, YSCellViewType) {
    YSCellViewTypeLabel = 0,
    YSCellViewTypeTextField,
};

typedef NS_ENUM(NSUInteger, YSCellAccessoryType) {
    YSCellAccessoryDisclosureIndicator,
    YSCellAccessoryDropdown,
};

@interface YSCellView : UIButton

@property (nonatomic, strong) UITextField    *ys_textFiled;

@property (nonatomic, assign) CGFloat        ys_titleWidth;

@property (nonatomic, strong) UIView            *ys_bottomLine;
    //accessoryView
@property (nonatomic, strong) UIImage        *ys_leftImage;

@property (nonatomic, assign) YSCellAccessoryType       ys_accessoryType;

@property (nonatomic, strong) UIImage        *ys_accessoryImage;

@property (nonatomic, strong) UIView         *ys_accessoryView;

@property (nonatomic, assign) CGFloat        ys_accessoryRightInsets;


    //title
@property (nonatomic, strong) NSString      *ys_title;

@property (nonatomic, strong) UIFont        *ys_titleFont;

@property (nonatomic, strong) UIColor       *ys_titleColor;

    //content
@property (nonatomic, copy)   NSString      *ys_text;   //tf text

@property (nonatomic, copy)   NSString      *ys_contentPlaceHolder;

@property (nonatomic, strong) UIFont        *ys_contentFont;

@property (nonatomic, strong) UIColor       *ys_contentTextColor;

@property (nonatomic, assign) BOOL          ys_tfEnable;  //tf enable. default YES

@property (nonatomic, assign) NSTextAlignment          ys_contentTextAlignment;

@property (nonatomic, copy)   NSAttributedString       *ys_attributedText;   //tf text

@property (nonatomic, copy)   NSAttributedString       *ys_attributedPlaceHolder;

//lineView
@property (nonatomic, assign) BOOL          ys_bottomLineHidden;   //default YES

@property (nonatomic, assign) UIEdgeInsets  ys_separatorInset;

@property (nonatomic, strong) UIColor       *ys_separatorColor;


@property (nonatomic, strong) UILabel           *ys_contentLabel;


- (instancetype)initWithStyle:(YSCellViewType)type;

@end
