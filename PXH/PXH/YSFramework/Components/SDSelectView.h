//
//  SDSelectView.h
//  SundayFramework
//
//  Created by 管振东 on 16/4/20.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^SDSelectHandler)(NSInteger index);

@interface SDSelectView : MMPopupView

@property (nonatomic, copy) SDSelectHandler selectHandler;

- (instancetype)initWithTitle:(NSString *)title array:(NSArray *)array handler:(SDSelectHandler)selectHandler;

@end
