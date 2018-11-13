//
//  YSTimeSectionsView.m
//  PXH
//
//  Created by yu on 2017/8/13.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSTimeSectionsView.h"

typedef void(^ViewTapCallback)(id object);

@interface YSSubtitleView : UIView

@property (nonatomic, strong) UILabel   *titleLabel;

@property (nonatomic, strong) UILabel   *subtitleLabel;

@property (nonatomic, copy)   ViewTapCallback   block;

@end

@implementation YSSubtitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
            if (self.block) {
                self.block(nil);
            }
        }]];

    }
    return self;
}

- (void)setup {
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = HEX_COLOR(@"#333333");
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _subtitleLabel = [UILabel new];
    _subtitleLabel.font = [UIFont systemFontOfSize:13];
    _subtitleLabel.textColor = HEX_COLOR(@"#999999");
    _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_subtitleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
    }];
    
    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.right.left.offset(0);
    }];
}

@end


@interface YSTimeSectionsView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, copy)   TimeSelectBlock block;

@end

@implementation YSTimeSectionsView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *maskView = [UIImageView new];
    maskView.image = [[UIImage imageNamed:@"多边形-1"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 20) resizingMode:UIImageResizingModeStretch];
    [self.contentView addSubview:maskView];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _containerView = [UIView new];
    [_scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(60);
    }];
}

- (void)setTimeSections:(NSArray *)timeSections currentTime:(YSLimitBuyTime *)currentTime {
    _timeSections = timeSections.copy;
    
    [_containerView removeAllSubviews];
    
    NSInteger index = 0;
    
    CGFloat leftMargin = kScreenWidth / 2 - 30;
    
    for (int i = 0; i < timeSections.count; i ++) {
        YSLimitBuyTime *section = timeSections[i];
        YSSubtitleView *view = [YSSubtitleView new];
        view.tag = 10000 + i;
        [_containerView addSubview:view];
        
        view.block = ^(id object) {
            [self updateStatusForIndex:i];
            
            if (self.block) {
                YSLimitBuyTime *time = _timeSections[i];
                self.block(time);
            }
        };
        
        view.titleLabel.text = [NSString stringWithFormat:@"%@:00", section.startTime];
        if (section.type == 1) {
            view.subtitleLabel.text = @"已结束";
        }else if (section.type == 2) {
            view.subtitleLabel.text = @"进行中";
        }else {
            view.subtitleLabel.text = @"预热中";
        }
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(60 * i + leftMargin);
            make.centerY.offset(0);
            make.height.mas_equalTo(55);
            make.width.mas_equalTo(60);
        }];
        
        if (currentTime) {
            if (currentTime == section) {
                index = i;
                view.titleLabel.textColor = [UIColor whiteColor];
                view.subtitleLabel.textColor = [UIColor whiteColor];
            }
        }else if (section.type == 2) {
            index = i;
            view.titleLabel.textColor = [UIColor whiteColor];
            view.subtitleLabel.textColor = [UIColor whiteColor];
        }
        
        if (i == timeSections.count-1) {
            [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(view).offset(leftMargin);
            }];
        }
    }
    
    [self.contentView layoutIfNeeded];
    
    [self updateStatusForIndex:index];
}

- (void)updateStatusForIndex:(NSInteger)index {
    
    [_scrollView setContentOffset:CGPointMake(60 * index, 0) animated:NO];
    
    for (int i = 0; i < 10; i ++) {
        YSSubtitleView *view = [_containerView viewWithTag:10000 + i];
        if (i == index) {
            view.titleLabel.textColor = [UIColor whiteColor];
            view.subtitleLabel.textColor = [UIColor whiteColor];
        } else {
            view.titleLabel.textColor = HEX_COLOR(@"#333333");
            view.subtitleLabel.textColor = HEX_COLOR(@"#666666");
        }
    }
}

- (void)timeSectionDidChange:(TimeSelectBlock)block {
    
    self.block = block;
}

- (void)scrollDidEnd {
    
    CGFloat offsetX = _scrollView.contentOffset.x;
    
    NSInteger index = offsetX / 60;
    
    if ((offsetX - 60 * index) > (60 * (index + 1) - offsetX)) {
        index ++;
    }
    
    if (index < 0) {
        index = 0;
    }else if (index >= _timeSections.count) {
        index = _timeSections.count - 1;
    }
    
    [self updateStatusForIndex:index];
    
    if (self.block) {
        YSLimitBuyTime *time = _timeSections[index];
        self.block(time);
    }
}

#pragma mark - delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        [self scrollDidEnd];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollDidEnd];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
