//
//  YSEditImagesView.m
//  ZSMMember
//
//  Created by yu on 16/8/15.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSEditImagesView.h"
#import "AppDelegate.h"


#import "YSEditImageItem.h"

@interface YSEditImagesView ()

@property (nonatomic, assign) NSInteger     column;

@property (nonatomic, assign) NSInteger     maxCount;

@property (nonatomic, strong) UIImage       *lastImage;

@end

@implementation YSEditImagesView

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (instancetype)initWithColumn:(NSInteger)column maxCount:(NSInteger)maxCount addButtonImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _lastImage = image;
        _maxCount = maxCount;
        _column = column;
        [self initSubviews];
        
    }
    return self;
}

- (void)initSubviews
{
    WS(weakSelf);
    for (NSInteger i = 0; i < _maxCount; i ++) {
        YSEditImageItem *view = [YSEditImageItem new];
        [view setBlock:^(NSInteger index){
            [weakSelf.images removeObjectAtIndex:i];
            if (weakSelf.block) {
                weakSelf.block();
            }
            [weakSelf updateImagesView];
        }];
        [view addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view];
    }
    
    [self updateImagesView];
}

- (void)imageClick:(YSEditImageItem *)view
{
    if (view.tag == 100) {
        
        //加号
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [delegate.window endEditing:YES];
        
        if (self.images.count == _maxCount) {
            NSString *string = [NSString stringWithFormat:@"只能选择%zd张图片",_maxCount];
            [MBProgressHUD showText:string toContainer:nil];
            return;
        }
        
        WS(weakSelf);
        
        [YSImagePickerManager ys_ChooseImagesWithMaxCount:_maxCount - [self.images count] delegate:delegate.window.rootViewController complateBlock:^(NSArray *imageArray) {
            [weakSelf.images addObjectsFromArray:imageArray];
            if (weakSelf.block) {
                weakSelf.block();
            }
            [weakSelf updateImagesView];
        }];
    }
}

- (void)updateImagesView
{
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i ++) {
        YSEditImageItem *imageView = self.subviews[i];
        if (i < _images.count) { // 显示
            imageView.contentImage = _images[i];
            imageView.hidden = NO;
            imageView.tag = 10000 + i;
            
            imageView.editEnable = YES;
        } else { // 隐藏
            imageView.hidden = YES;
        }
    }
    
    if (_lastImage && (_images.count < _maxCount)) {
        YSEditImageItem *imageView = self.subviews[_images.count];
        imageView.contentImage = _lastImage;
        imageView.tag = 100;
        imageView.hidden = NO;
        imageView.editEnable = NO;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemWidth = (self.width - 10 * (_column - 1)) / _column;
    
    NSInteger count = 0;
    if (_lastImage) {
        count = _images.count < _maxCount ? _images.count + 1 : _images.count;
    }else {
        count = _images.count;
    }
    
    CGFloat height = 0;
    for (NSInteger i = 0; i < count; i ++) {
        
        NSInteger x = i % _column;
        NSInteger y = i / _column;
        
        YSEditImageItem *imageView = self.subviews[i];
        imageView.frame = CGRectMake(x * (itemWidth + 10), y * (itemWidth + 10), itemWidth, itemWidth);
        
        height = imageView.bottom;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
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
