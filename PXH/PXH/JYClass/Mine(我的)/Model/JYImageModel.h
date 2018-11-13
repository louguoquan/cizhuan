//
//  JYImageModel.h
//  PXH
//
//  Created by LX on 2018/6/3.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYImageModel : NSObject

@property (nonatomic, copy) NSString *savePath;

@property (nonatomic, copy) NSString *viewPath;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger width;

@end
