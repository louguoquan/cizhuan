//
//  YSCellView.m
//  ZSMMember
//
//  Created by yu on 16/7/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSCellView.h"

@interface YSCellView ()

@property (nonatomic, assign) YSCellViewType    type;


@property (nonatomic, strong) UIImageView       *ys_leftImageView;

@property (nonatomic, strong) UIImageView       *ys_accessoryImageView;


@property (nonatomic, strong) UIView            *ys_leftContrastView;

@property (nonatomic, strong) UIView            *ys_rightContrastView;

@property (nonatomic, strong) UILabel           *ys_titleLabel;


@end

@implementation YSCellView

- (instancetype)initWithStyle:(YSCellViewType)type
{
    self = [super init];
    if (self) {
        _type = type;
        [self initSubviews];
        
        self.ys_contentFont = [UIFont systemFontOfSize:10];
        self.ys_contentTextColor = HEX_COLOR(@"#999999");
        
        self.ys_titleFont = [UIFont systemFontOfSize:14];
        self.ys_titleColor = HEX_COLOR(@"#333333");

    }
    return self;
}

- (void)initSubviews
{
    if (_type == YSCellViewTypeTextField) {
        _ys_textFiled = [UITextField new];
        [self addSubview:_ys_textFiled];
    } else {
        _ys_contentLabel = [UILabel new];
        _ys_contentLabel.numberOfLines = 0;
        [self addSubview:_ys_contentLabel];
    }
    
    _ys_bottomLine = [UIView new];
    _ys_bottomLine.backgroundColor = BACKGROUND_COLOR;
    _ys_bottomLine.hidden = YES;
    [self addSubview:_ys_bottomLine];
    
}

#pragma mark - set

//商品图片
- (void)setYs_leftImage:(UIImage *)ys_leftImage
{
    _ys_leftImage = ys_leftImage;
    
    //左侧images视图
    if (!_ys_leftImageView) {
        _ys_leftImageView = [UIImageView new];
        _ys_leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_ys_leftImageView];
        [_ys_leftImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_ys_leftImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    _ys_leftImageView.image = ys_leftImage;
    
    WS(weakSelf);
    [_ys_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.equalTo(weakSelf);
        make.left.offset(10);
        make.width.mas_equalTo(ys_leftImage.size.width);
    }];
    
    if (!_ys_titleLabel) {
        _ys_leftContrastView = _ys_leftImageView;
    }
}

//限量秒杀
- (void)setYs_title:(NSString *)ys_title
{
    _ys_title = ys_title;
    
    if (!_ys_titleLabel) {
        _ys_titleLabel = [UILabel new];
        
        _ys_titleLabel.font = _ys_titleFont;
        _ys_titleLabel.textColor = _ys_titleColor;
        
        [self addSubview:_ys_titleLabel];
        [_ys_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_ys_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    _ys_titleLabel.text = _ys_title;
    
    _ys_leftContrastView = _ys_titleLabel;
}

- (void)setYs_titleFont:(UIFont *)ys_titleFont
{
    _ys_titleFont = ys_titleFont;
    _ys_titleLabel.font = _ys_titleFont;
}

- (void)setYs_titleColor:(UIColor *)ys_titleColor
{
    _ys_titleColor = ys_titleColor;
    _ys_titleLabel.textColor = ys_titleColor;
}

- (void)setYs_accessoryType:(YSCellAccessoryType)ys_accessoryType
{
    _ys_accessoryType = ys_accessoryType;
    if (_ys_accessoryType == YSCellAccessoryDropdown) {
        [self setYs_accessoryImage:[UIImage imageNamed:@"pull-down"]];
    }else {
        [self setYs_accessoryImage:[UIImage imageNamed:@"more-right"]];
    }
}

- (void)setYs_accessoryImage:(UIImage *)ys_accessoryImage
{
    _ys_accessoryImage = ys_accessoryImage;
    
    [_ys_accessoryView removeFromSuperview];
    
    if (!_ys_accessoryImageView) {
        _ys_accessoryImageView = [UIImageView new];
        _ys_accessoryImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_ys_accessoryImageView];
        [_ys_accessoryImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_ys_accessoryImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    _ys_accessoryImageView.image = _ys_accessoryImage;
    
    WS(weakSelf);
    
    [_ys_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.height.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(weakSelf.ys_accessoryImage.size.width);
    }];
    
    _ys_rightContrastView = _ys_accessoryImageView;
}

- (void)setYs_accessoryView:(UIView *)ys_accessoryView
{
    [_ys_accessoryImageView removeFromSuperview];
    [_ys_accessoryView removeFromSuperview];
    
    _ys_accessoryView = ys_accessoryView;
    _ys_rightContrastView = _ys_accessoryView;
    
    [self addSubview:_ys_accessoryView];
    
    WS(weakSelf);
    [_ys_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(weakSelf);
    }];
}

- (void)setYs_accessoryRightInsets:(CGFloat)ys_accessoryRightInsets
{
    _ys_accessoryRightInsets = ys_accessoryRightInsets;
    
    if (_ys_accessoryView) {
        [_ys_accessoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-ys_accessoryRightInsets);
        }];
    }
    
    if (_ys_accessoryImageView) {
        [_ys_accessoryImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-ys_accessoryRightInsets);
        }];
    }
    
}

- (void)setYs_bottomLineHidden:(BOOL)ys_bottomLineHidden
{
    _ys_bottomLineHidden = ys_bottomLineHidden;
    
    _ys_bottomLine.hidden = _ys_bottomLineHidden;
}

- (void)setYs_separatorColor:(UIColor *)ys_separatorColor
{
    _ys_separatorColor = ys_separatorColor;
    _ys_bottomLine.backgroundColor = _ys_separatorColor;
}

- (void)setYs_separatorInset:(UIEdgeInsets)ys_separatorInset
{
    _ys_separatorInset = ys_separatorInset;
    [self.ys_bottomLine setNeedsUpdateConstraints];
    [self.ys_bottomLine updateConstraintsIfNeeded];
}

#pragma mark - content

- (void)setYs_contentFont:(UIFont *)ys_contentFont
{
    _ys_contentFont = ys_contentFont;
    _ys_textFiled.font = _ys_contentFont;
    _ys_contentLabel.font = _ys_contentFont;
}

- (void)setYs_contentTextAlignment:(NSTextAlignment)ys_contentTextAlignment
{
    _ys_contentTextAlignment = ys_contentTextAlignment;
    
    _ys_contentLabel.textAlignment = _ys_contentTextAlignment;
    _ys_textFiled.textAlignment = _ys_contentTextAlignment;
}

- (void)setYs_contentTextColor:(UIColor *)ys_contentTextColor
{
    _ys_contentTextColor = ys_contentTextColor;
    
    _ys_textFiled.textColor = _ys_contentTextColor;
    _ys_contentLabel.textColor = _ys_contentTextColor;
}

- (void)setYs_contentPlaceHolder:(NSString *)ys_contentPlaceHolder
{
    _ys_contentPlaceHolder = ys_contentPlaceHolder;
    _ys_textFiled.placeholder = _ys_contentPlaceHolder;
}

- (void)setYs_attributedPlaceHolder:(NSAttributedString *)ys_attributedPlaceHolder
{
    _ys_attributedPlaceHolder = ys_attributedPlaceHolder;
    
    _ys_textFiled.attributedPlaceholder = _ys_attributedPlaceHolder;

}

- (void)setYs_tfEnable:(BOOL)ys_tfEnable
{
    _ys_tfEnable = ys_tfEnable;
    _ys_textFiled.userInteractionEnabled = _ys_tfEnable;
}

- (void)setYs_text:(NSString *)ys_text
{
    if (_type == YSCellViewTypeTextField) {
        _ys_textFiled.text = ys_text;
    }else {
        _ys_contentLabel.text = ys_text;
    }
}

- (NSString *)ys_text
{
    if (_type == YSCellViewTypeTextField) {
        return _ys_textFiled.text;
    }else {
        return _ys_contentLabel.text;
    }
}

- (void)setYs_attributedText:(NSAttributedString *)ys_attributedText
{
    if (_type == YSCellViewTypeTextField) {
        _ys_textFiled.attributedText = ys_attributedText;
    }else {
        _ys_contentLabel.attributedText = ys_attributedText;
    }
}

- (NSAttributedString *)ys_attributedText
{
    if (_type == YSCellViewTypeTextField) {
        return _ys_textFiled.attributedText;
    }else {
        return _ys_contentLabel.attributedText;
    }
}

//更新布局
- (void)updateConstraints
{
    WS(weakSelf);
    
    [_ys_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        if (weakSelf.ys_leftImageView) {
            make.left.equalTo(weakSelf.ys_leftImageView.mas_right).offset(10);
        }else {
            make.left.offset(10);
        }
        
        if (weakSelf.ys_titleWidth > 0) {
            make.width.mas_equalTo(weakSelf.ys_titleWidth);
        }
    }];
    
    if (_type == YSCellViewTypeTextField) {
        
        [_ys_textFiled mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.centerY.equalTo(weakSelf);
            if (weakSelf.ys_leftContrastView) {
                make.left.equalTo(weakSelf.ys_leftContrastView.mas_right).offset(10);
            }else {
                make.left.offset(10);
            }
            
            if (weakSelf.ys_rightContrastView) {
                make.right.equalTo(weakSelf.ys_rightContrastView.mas_left);
            }else {
                make.right.offset(-10);
            }
        }];
    }else {
        
        [_ys_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            if (weakSelf.ys_contentLabel.numberOfLines == 0) {
                make.top.greaterThanOrEqualTo(weakSelf).offset(10);
            }
    
            if (weakSelf.ys_leftContrastView) {
                make.left.equalTo(weakSelf.ys_leftContrastView.mas_right).offset(10);
            }else {
                make.left.offset(10);
            }
            
            if (weakSelf.ys_rightContrastView) {
                make.right.equalTo(weakSelf.ys_rightContrastView.mas_left);
            }else {
                make.right.offset(-10);
            }
        }];
    }
    [_ys_bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(weakSelf.ys_separatorInset.left);
        make.right.offset(-weakSelf.ys_separatorInset.right);
        make.height.equalTo(@1.0);
    }];
    
    [self bringSubviewToFront:_ys_bottomLine];
    
    [super updateConstraints];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    self.ys_contentLabel.preferredMaxLayoutWidth = self.ys_contentLabel.width;
//}

@end
