//
//  SDNewsLabel.h
//  haoyi
//
//  Created by 管振东 on 16/10/8.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickHandler)(NSInteger index);

@interface SDNewsLabel : UIView

@property (nonatomic, strong) NSArray *newsArray;

@property (nonatomic, copy) clickHandler handler;

- (void)clickCallBack:(clickHandler)handler;

@end
