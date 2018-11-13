//
//  YSImagePickerManager.h
//  YLFMember
//
//  Created by yu on 2017/3/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChoosePhotosHandle)(NSArray *imageArray);

@interface YSImagePickerManager : NSObject

+ (void)ys_ChooseImagesWithMaxCount:(NSInteger)count delegate:(UIViewController *)delegate complateBlock:(ChoosePhotosHandle)block;

@end
