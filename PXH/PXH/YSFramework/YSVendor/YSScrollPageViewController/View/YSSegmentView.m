//
//  YSSegmentView.m
//  HouseDoctorMonitor
//
//  Created by yu on 2017/4/6.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSSegmentView.h"
#import "YSScrollView.h"

@interface YSSegmentView ()

@property (nonatomic, strong) YSSegmentStyle    *segmentStyle;

@property (nonatomic, strong) NSArray       *viewModels;

@property (nonatomic, strong) UIView        *maskView;

@property (nonatomic, strong) YSScrollView  *scrollView;


@property (nonatomic, strong) UIImageView   *scrollLine;

@property (nonatomic, strong) NSMutableArray    *segmentItems;

@property (nonatomic, assign) NSInteger     oldIndex;

@property (nonatomic, copy)   SegmentDidClickHandler    block;

@property (nonatomic, copy)   SegmentUpdateHandler      updateBlock;

@end

@implementation YSSegmentView

- (NSMutableArray *)segmentItems
{
    if (!_segmentItems) {
        _segmentItems = [NSMutableArray array];
    }
    return _segmentItems;
}

- (instancetype)initWithFrame:(CGRect )frame
                 segmentStyle:(YSSegmentStyle *)segmentStyle
                   viewModels:(NSArray *)viewModels
         segmentUpdateHandler:(SegmentUpdateHandler)updateBlock
                 clickHandler:(SegmentDidClickHandler)block
{
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.viewModels = viewModels;
        self.block = block;
        self.updateBlock = updateBlock;
        
        self.currentIndex = -1;

        [self initScrollView];
        [self setupTitles];
    }
    return self;
}

- (void)initScrollView
{
    WS(weakSelf);
    _scrollView = [[YSScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = NO;
    _scrollView.backgroundColor = _segmentStyle.backgroundColor;
    [self addSubview:_scrollView];
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];

    _containerView = [UIView new];
    _containerView.backgroundColor = _segmentStyle.containerBackgroundColor;
    [self.scrollView addSubview:_containerView];
    [_containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.scrollView);
        make.bottom.height.equalTo(weakSelf.scrollView).offset(-_segmentStyle.segmentBottomInsets);
    }];

   UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = _segmentStyle.bottomLineColor;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(@0.5);
    }];
}

- (void)setupTitles
{
    WS(weakSelf);
        //创建MaskView
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = _segmentStyle.maskViewColor;
    [self.containerView addSubview:_maskView];
    _maskView.hidden = !_segmentStyle.showMaskView;
    
        //创建标签
    UIView *lastView;
    for (NSInteger i = 0; i < [self.viewModels count]; i ++) {
        YSSegmentItem *segmentItem = [[YSSegmentItem alloc] initWithStyle:_segmentStyle viewModel:self.viewModels[i] clickHandler:self.block];
        segmentItem.tag = i;
        [self.segmentItems addObject:segmentItem];
        [self.containerView addSubview:segmentItem];
        
     
        
        if (_segmentStyle.canScrollTitle) {
            
            //可以滑动.

            CGFloat width = 0.f;
            
            if (_segmentStyle.itemWidth <= 0) {
                //使用文本宽度计算
                
                YSSegmentItemViewModel *viewModel = self.viewModels[i];
                if ([viewModel.title isKindOfClass:[NSString class]]) {
                    width = [viewModel.title widthForFont:_segmentStyle.titleFont];
                }else {
                    width = [viewModel.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.width;
                }

                width = MAX((width + self.segmentStyle.itemMargin), _segmentStyle.iconSize.width);

            
            }else {
                width = _segmentStyle.itemWidth;
            }
            
            //使用itemWidth
            [segmentItem mas_makeConstraints:^(MASConstraintMaker *make) {

                make.width.mas_equalTo(width);
                
                if (lastView) {
                    make.top.bottom.height.equalTo(lastView);
                    make.left.equalTo(lastView.mas_right);
                }else {
                    make.top.equalTo(weakSelf.containerView);
                    make.left.offset(0);
                    make.bottom.equalTo(weakSelf.containerView);
                }
                
                if (i == ([weakSelf.viewModels count] - 1)) {
                    make.right.offset(0);
                }
            }];
            lastView = segmentItem;

        }else {
            //平分
            [segmentItem mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (lastView) {
                    make.top.bottom.height.width.equalTo(lastView);
                    make.left.equalTo(lastView.mas_right);
                }else {
                    make.top.equalTo(weakSelf.containerView);
                    make.left.offset(0);
                    make.bottom.equalTo(weakSelf.containerView);
                }
                
                if (i == ([weakSelf.viewModels count] - 1)) {
                    make.right.offset(0);
                }
            }];
            lastView = segmentItem;
            
            [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(weakSelf.scrollView);
            }];
        }
    }
    
        //创建滚动条
    _scrollLine = [UIImageView new];
    if (_segmentStyle.scrollLineImage) {
        _scrollLine.image = _segmentStyle.scrollLineImage;
    }else {
        _scrollLine.backgroundColor = _segmentStyle.scrollLineColor;
    }
    [self.containerView addSubview:_scrollLine];
    _scrollLine.hidden = !_segmentStyle.showScrollLine;

}

#pragma mark - public helper

/** 重新刷新标题的内容*/
- (void)reloadTitlesWithNewViewModels:(NSArray *)viewModels
{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.viewModels = viewModels;
    
    [self.segmentItems removeAllObjects];
    self.segmentItems = nil;
    
    [self setupTitles];
}

/** 设置选中的下标*/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated
{
    
    YSSegmentItem *currentLabel = (YSSegmentItem *)self.segmentItems[index];

    if (index < 0 || index >= self.viewModels.count) {
        return;
    }
    if (!currentLabel || currentLabel.selected) {
        return;
    }
    
    [self adjustUIWhenBtnOnClickWithIndex:currentLabel.tag Animated:NO];
    
    _currentIndex = index;
}

#pragma mark - private

///** 点击按钮的时候调整UI*/
- (void)adjustUIWhenBtnOnClickWithIndex:(NSInteger)index Animated:(BOOL)animated
{
    YSSegmentItem *currentLabel = (YSSegmentItem *)self.segmentItems[index];
    
    //调整选中按钮的位置
    [self adjustTitleOffSetToCurrentIndex:index];
    
    [self adjustMaskViewAndScrollLineWithLabel:currentLabel oldItem:nil progress:nil animated:animated];
}

/** 让选中的标题居中*/
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex
{
    YSSegmentItem *currentLabel = (YSSegmentItem *)self.segmentItems[currentIndex];

    //偏移量
    CGFloat offSetx = currentLabel.center.x - self.scrollView.width * 0.5;
    
    if (offSetx < 0) { //小于0 scrollView 应滑动到最左端
        offSetx = 0;
    }
    
    //最大偏移量
    CGFloat maxOffSetX = self.containerView.width - self.scrollView.width;
    
    if (maxOffSetX <= 0) {  //小于0 代表scrollView 不能滑动
        maxOffSetX = 0;
    }
    
    if (offSetx > maxOffSetX) { //偏移量 大于 最大偏移量 scrollView 应滑动到最左端
        offSetx = maxOffSetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offSetx, 0.0) animated:YES];
    
    if (!self.segmentStyle.gradualChangeTitleColor) {
        for (NSInteger i = 0; i < self.segmentItems.count; i ++) {
            YSSegmentItem *item = self.segmentItems[i];
            if (i == currentIndex) {
                [item setSelected:YES];
                if (self.segmentStyle.scaleTitle) {
                    [item setCurrentTransformSx:self.segmentStyle.titleBigScale];
                }
            }else {
                [item setSelected:NO];
                if (self.segmentStyle.scaleTitle) {
                    [item setCurrentTransformSx:1.0];
                }
            }
            if (self.updateBlock) {
                self.updateBlock(item);
            }
        }
    }
}

/** 切换下标的时候根据progress同步设置UI*/
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex
{
    _oldIndex = currentIndex;
    YSSegmentItem *oldLabel = (YSSegmentItem *)self.segmentItems[oldIndex];
    YSSegmentItem *currentLabel = (YSSegmentItem *)self.segmentItems[currentIndex];
    
    if (progress >= 1.0) {
        [self adjustTitleOffSetToCurrentIndex:currentIndex];
    }
    
    [self adjustMaskViewAndScrollLineWithLabel:currentLabel oldItem:oldLabel progress:@(progress) animated:YES];
    
    // 渐变
    if (self.segmentStyle.gradualChangeTitleColor) {
        [oldLabel updateTextColorWithCurrentProgress:progress selected:YES];
        [currentLabel updateTextColorWithCurrentProgress:progress selected:NO];
    }
    
    if (self.segmentStyle.scaleTitle) {
        CGFloat deltaScale = self.segmentStyle.titleBigScale - 1.0;
        oldLabel.currentTransformSx = self.segmentStyle.titleBigScale - deltaScale * progress;
        currentLabel.currentTransformSx = 1.0 + deltaScale * progress;
    }
}

    //调整 scrollLine/maskView 位置
- (void)adjustMaskViewAndScrollLineWithLabel:(YSSegmentItem *)referenceItem oldItem:(YSSegmentItem *)oldItem progress:(NSNumber *)progress animated:(BOOL)animated
{
    WS(weakSelf);
    
    if (progress) {
        CGFloat xDistance = referenceItem.centerX - oldItem.centerX;
        
        CGFloat oldLabelWidth = oldItem.width;
        CGFloat currentLabelWidth = referenceItem.width;
        CGFloat wDistance = currentLabelWidth - oldLabelWidth;

        [_maskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.containerView);
            make.centerX.equalTo(oldItem).offset(xDistance * [progress doubleValue]);
            if (weakSelf.segmentStyle.maskViewWidth > 0) {
                make.width.mas_equalTo(weakSelf.segmentStyle.maskViewWidth);
            }else {
                make.width.mas_equalTo(oldLabelWidth + wDistance * [progress doubleValue]);
            }
        }];
        
        
        oldLabelWidth = oldItem.titleLabel.intrinsicContentSize.width;
        currentLabelWidth = referenceItem.titleLabel.intrinsicContentSize.width;
        wDistance = currentLabelWidth - oldLabelWidth;
        
        [self.scrollLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.scrollView);
            make.height.mas_equalTo(weakSelf.segmentStyle.scrollLineSize.height);
            make.centerX.equalTo(oldItem).offset(xDistance * [progress doubleValue]);
            if (weakSelf.segmentStyle.scrollLineSize.width <= 0) {
                make.width.mas_equalTo(oldLabelWidth + wDistance * [progress doubleValue]);
            }else {
                make.width.mas_equalTo(weakSelf.segmentStyle.scrollLineSize.width);
            }
        }];
    }else {
        [_maskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf.containerView);
            make.centerX.equalTo(referenceItem);
            if (weakSelf.segmentStyle.maskViewWidth > 0) {
                make.width.mas_equalTo(weakSelf.segmentStyle.maskViewWidth);
            }else {
                make.width.equalTo(referenceItem);
            }
        }];
        
        
        [self.scrollLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.scrollView);
            make.height.mas_equalTo(weakSelf.segmentStyle.scrollLineSize.height);
            if (weakSelf.segmentStyle.scrollLineSize.width <= 0) {
                make.width.mas_equalTo(referenceItem.titleLabel.intrinsicContentSize.width);
            }else {
                make.width.mas_equalTo(weakSelf.segmentStyle.scrollLineSize.width);
            }
            make.centerX.equalTo(referenceItem);
        }];
    }
    
    [self.scrollLine setNeedsLayout];
    [self.maskView setNeedsLayout];
    
    CGFloat animatedTime = animated ? 0.3 : 0.0;
    [UIView animateWithDuration:animatedTime animations:^{
        
        [weakSelf.scrollLine layoutIfNeeded];
        [weakSelf.maskView layoutIfNeeded];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
