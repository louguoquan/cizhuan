//
//  YSSegmentItem.m
//  HouseDoctorMonitor
//
//  Created by yu on 2017/4/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSegmentItem.h"

@implementation YSSegmentItemViewModel

@end

@interface YSSegmentItem ()

@property (nonatomic, strong) YSSegmentStyle    *style;

@property (nonatomic, strong) YSSegmentItemViewModel    *viewModel;

@property (nonatomic, strong) UIImageView   *iconView;

@property (nonatomic, strong) UIView        *bgView;

@property (nonatomic, copy)   SegmentDidClickHandler       block;

// 用于懒加载计算文字的rgb差值, 用于颜色渐变的时候设置
@property (nonatomic, copy)   NSArray *deltaRGB;
@property (nonatomic, copy)   NSArray *selectedColorRgb;
@property (nonatomic, copy)   NSArray *normalColorRgb;

@end

@implementation YSSegmentItem

/*--颜色相关--*/
- (NSArray *)deltaRGB
{
    if (_deltaRGB == nil) {
        NSArray *normalColorRgb = self.normalColorRgb;
        NSArray *selectedColorRgb = self.selectedColorRgb;
        
        NSArray *delta;
        if (normalColorRgb && selectedColorRgb) {
            CGFloat deltaR = [normalColorRgb[0] floatValue] - [selectedColorRgb[0] floatValue];
            CGFloat deltaG = [normalColorRgb[1] floatValue] - [selectedColorRgb[1] floatValue];
            CGFloat deltaB = [normalColorRgb[2] floatValue] - [selectedColorRgb[2] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), nil];
            _deltaRGB = delta;
            
        }
    }
    return _deltaRGB;
}

- (NSArray *)normalColorRgb
{
    if (!_normalColorRgb) {
        NSArray *normalColorRgb = [self getColorRgb:self.style.normalTitleColor];
        NSAssert(normalColorRgb, @"设置普通状态的文字颜色时 请使用RGB空间的颜色值");
        _normalColorRgb = normalColorRgb;
        
    }
    return  _normalColorRgb;
}

- (NSArray *)selectedColorRgb
{
    
    if (!_selectedColorRgb) {
        NSArray *selectedColorRgb = [self getColorRgb:self.style.selectedTitleColor];
        NSAssert(selectedColorRgb, @"设置选中状态的文字颜色时 请使用RGB空间的颜色值");
        _selectedColorRgb = selectedColorRgb;
        
    }
    return  _selectedColorRgb;
}

- (NSArray *)getColorRgb:(UIColor *)color
{
    
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), nil];
    }
    return rgbComponents;
    
}
/*--颜色相关--end*/

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = NO;
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _style.titleFont;
        _titleLabel.userInteractionEnabled = NO;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = _style.subTitleFont;
        _subTitleLabel.userInteractionEnabled = NO;
    }
    return _subTitleLabel;
}

- (instancetype)initWithStyle:(YSSegmentStyle *)style
                    viewModel:(YSSegmentItemViewModel *)viewModel
                 clickHandler:(SegmentDidClickHandler)block
{
    self = [super init];
    if (self) {
        self.style = style;
        self.viewModel = viewModel;
        
        self.currentTransformSx = 1.0;
        self.block = block;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked)];
        self.userInteractionEnabled = YES;
        gesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:gesture];
        
        [self renderUI];
    }
    return self;
}

/**
 设置标题、图片
 
 @param title 标题
 @param image icon  image/image_url
 */
- (void)renderUI
{
    switch (_style.segmentItemType) {
        case YSSegmentItemTypeForText:
            [self renderTextType];
            break;
        case YSSegmentItemTypeForImage:
            [self renderImageType];
            break;
        case YSSegmentItemTypeForTextAndImage:
            [self renderTextAndImageType];
            break;
        case YSSegmentItemTypeForSubTitle:
            [self renderSubTitleLabelType];
            break;
        default:
            break;
    }
    
    [self setSelected:NO];
}

- (void)renderTextType
{
    [self addSubview:self.titleLabel];
    WS(weakSelf);
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

- (void)renderImageType
{
    [self addSubview:self.iconView];

    WS(weakSelf);
    [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.style.iconSize);
        make.center.equalTo(weakSelf);
    }];
}

- (void)renderTextAndImageType
{
    WS(weakSelf);
    UIView *bgView = [UIView new];
    bgView.userInteractionEnabled = NO;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
    
    [bgView addSubview:self.iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.equalTo(bgView);
        make.size.mas_equalTo(weakSelf.style.iconSize);
    }];

    [bgView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(weakSelf.style.lineSpacing);
        make.left.right.equalTo(bgView);
        make.bottom.offset(0);
    }];
}

- (void)renderSubTitleLabelType
{
    WS(weakSelf);
    UIView *bgView = [UIView new];
    bgView.userInteractionEnabled = NO;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
    }];
    
    [bgView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.equalTo(bgView);
        make.left.right.equalTo(bgView);
    }];
    
    [bgView addSubview:self.subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(weakSelf.style.lineSpacing);
        make.bottom.offset(0);
        make.centerX.equalTo(bgView);
        make.left.right.equalTo(bgView);
    }];
}

- (void)itemClicked
{
    if (self.block) {
        self.block(self);
    }
}

#pragma mark - public

- (void)setSelected:(BOOL)selected
{
    if ([_viewModel.title isKindOfClass:[NSString class]]) {
        _titleLabel.text = _viewModel.title;
    }else {
        _titleLabel.attributedText = _viewModel.title;
    }
    
    if ([_viewModel.subTitle isKindOfClass:[NSString class]]) {
        _subTitleLabel.text = _viewModel.subTitle;
    }else {
        _subTitleLabel.attributedText = _viewModel.subTitle;
    }

    id image = nil;
    
    UIColor *titleColor = nil;
    UIColor *subTitleColor = nil;
    UIColor *bgColor = nil;
    
    if (selected) {   //选中
        image = _viewModel.selectIcon ? _viewModel.selectIcon : _viewModel.normalIcon;
        
        titleColor = _style.selectedTitleColor ? _style.selectedTitleColor : _style.normalTitleColor;
        subTitleColor = _style.selectedSubTitleColor ? _style.selectedSubTitleColor : _style.normalSubTitleColor;

        
        bgColor = _style.selectedBgColor ? _style.selectedBgColor : _style.normalBgColor;
    }else {
        image = _viewModel.normalIcon;
        
        titleColor = _style.normalTitleColor;
        subTitleColor = _style.normalSubTitleColor;
        
        bgColor = _style.normalBgColor;
    }
    
    _titleLabel.textColor = titleColor;
    _subTitleLabel.textColor = subTitleColor;
    
    self.backgroundColor = bgColor;
    
    if ([image isKindOfClass:[UIImage class]]) {
        _iconView.image = image;
    }else {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:kPlaceholderImage];
    }
}

- (void)setCurrentTransformSx:(CGFloat)currentTransformSx
{
    _currentTransformSx = currentTransformSx;
    self.titleLabel.transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx);
}

- (void)updateTextColorWithCurrentProgress:(CGFloat)progress selected:(BOOL)selected
{
    if (selected) {
        self.titleLabel.textColor = [UIColor colorWithRed:[self.selectedColorRgb[0] floatValue] + [self.deltaRGB[0] floatValue] * progress green:[self.selectedColorRgb[1] floatValue] + [self.deltaRGB[1] floatValue] * progress blue:[self.selectedColorRgb[2] floatValue] + [self.deltaRGB[2] floatValue] * progress alpha:1.0];
    }else {
        self.titleLabel.textColor = [UIColor colorWithRed:[self.normalColorRgb[0] floatValue] - [self.deltaRGB[0] floatValue] * progress green:[self.normalColorRgb[1] floatValue] - [self.deltaRGB[1] floatValue] * progress blue:[self.normalColorRgb[2] floatValue] - [self.deltaRGB[2] floatValue] * progress alpha:1.0];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
