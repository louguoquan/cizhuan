//
//  YSEditImagesView.h
//  ZSMMember
//
//  Created by yu on 16/8/15.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateImagesHandler)();

@interface YSEditImagesView : UIView

@property (nonatomic, strong) NSMutableArray  *images;

@property (nonatomic, copy) UpdateImagesHandler block;

- (instancetype)initWithColumn:(NSInteger)column maxCount:(NSInteger)maxCount addButtonImage:(UIImage *)image;

- (void)updateImagesView;

@end
