//
//  PaopaoButton.h
//  YiLink
//
//  Created by CygMac on 2018/6/2.
//  Copyright © 2018年 xunku_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaopaoButton : UIView

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
- (void)setPaopaoImage:(UIImage *)image;
- (void)setTitle:(NSString *)title;

@end
