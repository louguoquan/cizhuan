//
//  MBProgressHUD+Sunday.h
//  haoyi
//
//  Created by 管振东 on 16/10/9.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Sunday)

+ (void)showLoadingToContainer:(id)container;

+ (void)showLoadingText:(NSString *)text toContainer:(id)container;

+ (void)showText:(NSString *)text toContainer:(id)container;

+ (void)showSuccessMessage:(NSString *)text toContainer:(id)container;

+ (void)showErrorMessage:(NSString *)text toContainer:(id)container;

+ (void)showInfoMessage:(NSString *)text toContainer:(id)container;

+ (void)showCustomHUDWithText:(NSString *)text image:(UIImage *)image toContainer:(id)container;

+ (void)setSuccessWithText:(NSString *)text forContainer:(id)container;

+ (void)setErrorWithText:(NSString *)text forContainer:(id)container;

+ (void)setInfoWithText:(NSString *)text forContainer:(id)container;

+ (void)setNewText:(NSString *)text image:(UIImage *)image forContainer:(id)container;

+ (void)dismissForContainer:(id)container;

+ (void)dismissForContainer:(id)container withDelay:(NSTimeInterval)delay;

@end
