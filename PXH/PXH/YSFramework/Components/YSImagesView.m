//
//  YSImagesView.m
//  ZSMMember
//
//  Created by yu on 16/7/19.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSImagesView.h"

@implementation YSImagesView

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemMargin = 10;
        _itemWidth = (kScreenWidth - 4 * _itemMargin) / 3.0;
        _column = 3;
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = [images copy];
    NSUInteger imagesCount = images.count;
    
    while (self.subviews.count < imagesCount) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i ++) {
        UIImageView *imageView = self.subviews[i];
        imageView.userInteractionEnabled = YES;
        if (i < imagesCount) { // 显示
            [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:kPlaceholderImage];
            imageView.hidden = NO;
            imageView.tag = 10000 + i;
        } else { // 隐藏
            imageView.hidden = YES;
        }
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:imageTap];
    }
    
    NSInteger row = (images.count + _column - 1) / _column;
    CGFloat height = MAX(row * (_itemWidth + _itemMargin) - _itemMargin, 0);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

- (void)imageTapAction:(UITapGestureRecognizer *)tap
{
    UITapGestureRecognizer *selectTap = (UITapGestureRecognizer *)tap;
    NSInteger selectIndex = selectTap.view.tag;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"点击图片展开" object:@{@"images": _images, @"select":[NSString stringWithFormat:@"%ld", selectIndex]}];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger imagesCount = self.images.count;
    for (int i = 0; i < imagesCount; i++) {
        UIImageView *imageView = self.subviews[i];
        
        int col = i % _column;
        int row = i / _column;
        
        imageView.frame = (CGRect){
            .origin = CGPointMake(col * (_itemWidth + _itemMargin), row * (_itemWidth + _itemMargin)),
            .size = CGSizeMake(_itemWidth, _itemWidth)
        };
    }
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self initSubviews];
//    }
//    return self;
//}
//
//- (void)initSubviews
//{
//    for (NSInteger i = 0; i < 9; i ++) {
//        UIImageView *imageView = [UIImageView new];
//        imageView.userInteractionEnabled = YES;
//        [self addSubview:imageView];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick:)];
//        [imageView addGestureRecognizer:tap];
//    }
//}
//
//- (void)imageDidClick:(UITapGestureRecognizer *)tap
//{
//    
//}
//
//- (void)setImages:(NSArray *)images
//{
//    _images = images;
//    
//    // 遍历所有的图片控件，设置图片
//    for (int i = 0; i < self.subviews.count; i ++) {
//        UIImageView *imageView = self.subviews[i];
//        if (i < _images.count) { // 显示
//            [imageView sd_setImageWithURL:[NSURL URLWithString:_images[i]] placeholderImage:kPlaceholderImage];
//            imageView.hidden = NO;
//            imageView.tag = 10000 + i;
//        } else { // 隐藏
//            imageView.hidden = YES;
//        }
//    }
//    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGFloat itemWidth = (self.width - 20) / 3.0;
//    
//    CGFloat height = 0;
//    for (NSInteger i = 0; i < _images.count; i ++) {
//        
//        NSInteger x = i % 3;
//        NSInteger y = i / 3;
//        
//        UIView *imageView = self.subviews[i];
//        imageView.frame = CGRectMake(x * (itemWidth + 10), y * (itemWidth + 10), itemWidth, itemWidth);
//        
//        height = imageView.bottom;
//    }
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
