//
//  YSCenterTagsView.m
//  PXH
//
//  Created by yu on 2017/3/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSCenterTagsView.h"

@interface YSCenterTagsView ()

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) UIView        *containerView;

@end

@implementation YSCenterTagsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.textFont = [UIFont systemFontOfSize:14];
        self.textColor = HEX_COLOR(@"#333333");
    
        self.borderColor = HEX_COLOR(@"#333333");
                
        self.itemHeight = 20;
        self.lineSpacing = 5;
        self.columnSpacing = 5;
        
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    
    _scrollView = [UIScrollView new];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    _containerView = [UIView new];
    [_scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
    }];
}

- (void)setTags:(NSArray *)tags
{
    [_containerView removeAllSubviews];
    [self layoutIfNeeded];
    
    WS(weakSelf);
    UIView *lastView = nil;
    UIView *rowFirstView = nil;
    CGFloat rowMaxRight = 0;
    for (NSInteger i = 0; i < tags.count; i ++) {
        UILabel *tagLabel = [UILabel new];
        tagLabel.text = tags[i];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = self.textFont;
        tagLabel.textColor = self.textColor;
        [tagLabel jm_setCornerRadius:2 withBorderColor:self.borderColor borderWidth:1 backgroundColor:[UIColor clearColor] backgroundImage:nil contentMode:UIViewContentModeScaleAspectFill];
        [_containerView addSubview:tagLabel];
        
        CGFloat width = [tagLabel.text widthForFont:self.textFont] + 25;
        
        width = MIN(width, self.width - 2 * _columnSpacing);
        
        if (!lastView) {// 第一个
            [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(weakSelf.columnSpacing);
                make.top.offset(weakSelf.lineSpacing);
                make.height.mas_equalTo(weakSelf.itemHeight);
                make.width.mas_equalTo(width);
            }];
            rowFirstView = tagLabel;
        }else {
            if ((width + rowMaxRight + 2 * _columnSpacing) <= self.width) {
                //与之前的在一行
                [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastView.mas_right).offset(weakSelf.columnSpacing);
                    make.top.height.equalTo(lastView);
                    make.width.mas_equalTo(width);
                }];
            }else {
                //新的一行
                [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(weakSelf.columnSpacing);
                    make.height.equalTo(lastView);
                    make.top.equalTo(lastView.mas_bottom).offset(weakSelf.lineSpacing);
                    make.width.mas_equalTo(width);
                }];
                
                    //修正上一行的位置
                [rowFirstView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.offset((weakSelf.width - rowMaxRight + weakSelf.columnSpacing) / 2.0);
                }];
                
                rowFirstView = tagLabel;
                rowMaxRight = 0;
            }
        }
        
        lastView = tagLabel;
        rowMaxRight += (width + _columnSpacing);
        
        if (i == tags.count - 1) {
            [rowFirstView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.offset((weakSelf.width - rowMaxRight + weakSelf.columnSpacing) / 2.0);
                make.bottom.offset(weakSelf.lineSpacing);
            }];
        }
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
