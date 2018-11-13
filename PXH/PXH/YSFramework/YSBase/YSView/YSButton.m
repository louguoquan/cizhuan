//
//  YSButton.m
//  HouseDoctorMember
//
//  Created by yu on 2017/7/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSButton.h"

#import "UIView+Badge.h"

@interface YSButton ()

@property (nonatomic, strong) UIView    *contentView;

@property (nonatomic, strong) UILabel   *ysTextLabel;

@property (nonatomic, assign) YSButtonImagePosition imagePosition;

@end

@implementation YSButton

- (void)setBadgeValue:(NSInteger)value {
    if(value > 0) {
       [_ysImageView setBadgeValue:value];
    } 
}

+ (instancetype)buttonWithImagePosition:(YSButtonImagePosition)imagePosition
{
    YSButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.imagePosition = imagePosition;
    [button initSubviews];
    return button;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    YSButton *button = [super buttonWithType:buttonType];
    button.imagePosition = YSButtonImagePositionLeft;
    [button initSubviews];
    return button;
    
}

- (void)initSubviews
{
    _contentView = [UIView new];
    _contentView.userInteractionEnabled = NO;
    [self addSubview:_contentView];
    
    _ysImageView = [UIImageView new];
//    _ysImageView.layer.masksToBounds = YES;
    [_contentView addSubview:_ysImageView];
    [_ysImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_ysImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    _ysTextLabel = [UILabel new];
    [_contentView addSubview:_ysTextLabel];
    
    self.space = 10;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}

- (void)updateConstraints
{
    WS(weakSelf);
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.right.lessThanOrEqualTo(weakSelf.mas_right);
        }];
    }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.offset(0);
            make.left.greaterThanOrEqualTo(weakSelf.mas_left);
        }];
    }else {
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.height.lessThanOrEqualTo(weakSelf.mas_height);
            make.width.lessThanOrEqualTo(weakSelf.mas_width);
        }];
    }
    
    if (!_ysImageView.image) {
            //没有图片
        [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.contentView);
            make.left.right.offset(0);
        }];
        
        [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }else if (!(_ysTextLabel.text && _ysTextLabel.attributedText)) {
            //没有文字
        [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.contentView);
            make.left.right.offset(0);
            if (!CGSizeEqualToSize(weakSelf.imageViewSize , CGSizeZero)) {
                make.size.mas_equalTo(weakSelf.imageViewSize);
            }
        }];
        [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }else {
        //都存在
        switch (self.imagePosition) {
            case YSButtonImagePositionLeft:
            {
                [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(0);
                    make.centerY.equalTo(weakSelf.contentView);
                    if (!CGSizeEqualToSize(weakSelf.imageViewSize , CGSizeZero)) {
                        make.size.mas_equalTo(weakSelf.imageViewSize);
                    }
                }];
                
                [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakSelf.contentView);
                    make.left.equalTo(weakSelf.ysImageView.mas_right).offset(weakSelf.space);
                    make.right.offset(0);
                }];
            }
                break;
            case YSButtonImagePositionRight:
            {
                [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(0);
                    make.centerY.equalTo(weakSelf.contentView);
                    if (!CGSizeEqualToSize(weakSelf.imageViewSize , CGSizeZero)) {
                        make.size.mas_equalTo(weakSelf.imageViewSize);
                    }
                }];
                
                [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(weakSelf.contentView);
                    make.left.offset(0);
                    make.right.equalTo(weakSelf.ysImageView.mas_left).offset(-weakSelf.space);
                }];
                
            }
                break;
            case YSButtonImagePositionTop:
            {
                [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.offset(0);
                    make.centerX.equalTo(weakSelf.contentView);
                    if (!CGSizeEqualToSize(weakSelf.imageViewSize , CGSizeZero)) {
                        make.size.mas_equalTo(weakSelf.imageViewSize);
                    }
                }];
                
                [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(weakSelf.contentView);
                    make.bottom.offset(0);
                    make.top.equalTo(weakSelf.ysImageView.mas_bottom).offset(weakSelf.space);
                    make.left.right.offset(0);
                }];
                
            }
                break;
            case YSButtonImagePositionBottom:
            {
                [_ysImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.offset(0);
                    make.centerX.equalTo(weakSelf.contentView);
                    if (!CGSizeEqualToSize(weakSelf.imageViewSize , CGSizeZero)) {
                        make.size.mas_equalTo(weakSelf.imageViewSize);
                    }
                }];
                
                [_ysTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(weakSelf.contentView);
                    make.top.offset(0);
                    make.bottom.lessThanOrEqualTo(weakSelf.ysImageView.mas_top).offset(-weakSelf.space);
                    make.left.right.offset(0);
                }];
                
            }
                break;
        }
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _ysTextLabel.font = self.titleLabel.font;
    _ysTextLabel.textColor = self.currentTitleColor;
    if (self.currentAttributedTitle) {
        _ysTextLabel.attributedText = self.currentAttributedTitle;
    }else {
        _ysTextLabel.text = self.currentTitle;
    }
    
    _ysImageView.image = self.currentImage;
    _ysImageView.contentMode = self.imageView.contentMode;

    [self setNeedsUpdateConstraints];
#warning iOS 9 注释掉  iOS11 可以解开
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) {
        [self updateConstraintsIfNeeded];
    }
    
    
    self.titleLabel.hidden = YES;
    self.imageView.hidden = YES;
}

#pragma mark - setter

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    if (contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
        self.ysTextLabel.textAlignment = NSTextAlignmentLeft;
        self.ysTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else if (contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
        self.ysTextLabel.textAlignment = NSTextAlignmentRight;
        self.ysTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else {
        self.ysTextLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.ysTextLabel.textAlignment = NSTextAlignmentCenter;
    }
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
