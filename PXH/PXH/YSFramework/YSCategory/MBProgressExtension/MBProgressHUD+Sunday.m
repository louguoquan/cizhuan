//
//  MBProgressHUD+Sunday.m
//  haoyi
//
//  Created by 管振东 on 16/10/9.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import "MBProgressHUD+Sunday.h"

#define MB_BackgroundColor  [[UIColor blackColor] colorWithAlphaComponent:0.8]

#define MB_ContentColor  [UIColor whiteColor]

@implementation MBProgressHUD (Sunday)

+ (UIImage *)defaultImageByImageName:(NSString *)imageName
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"YSMBProgress.bundle/%@",imageName]];
}

+ (UIView *)viewForContainer:(id)container
{
    if ([container isKindOfClass:[UIView class]]) {
        return container;
    }else if ([container isKindOfClass:[UIViewController class]]) {
        return ((UIViewController *)container).view;
    }else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

    /*加载*/
+ (void)showLoadingToContainer:(id)container {
    [self showLoadingText:@"" toContainer:container];
}

+ (void)showLoadingText:(NSString *)text toContainer:(id)container
{
    UIView *view = [self viewForContainer:container];
    [MBProgressHUD dismissForContainer:view];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = text;
    hud.bezelView.color = MB_BackgroundColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.contentColor = MB_ContentColor;
    hud.minSize = CGSizeMake(100, 100);
    hud.offset = CGPointMake(0, -20);
    if (text.length > 5) {
        hud.margin = 15;
        hud.square = NO;
    } else {
        hud.square = YES;
    }
}

    /*纯文本*/
+ (void)showText:(NSString *)text toContainer:(id)container {

    UIView *view = [self viewForContainer:container];
    [MBProgressHUD dismissForContainer:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.color = MB_BackgroundColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.contentColor = MB_ContentColor;
    
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = text;
    hud.offset = CGPointMake(0, -20);
    
    [hud hideAnimated:YES afterDelay:1.2f];
}

    /*自定义View*/
+ (void)showSuccessMessage:(NSString *)text toContainer:(id)container {

    [self showCustomHUDWithText:text image:[self defaultImageByImageName:@"Checkmark"] toContainer:container];
}

+ (void)showErrorMessage:(NSString *)text toContainer:(id)container {
    
    [self showCustomHUDWithText:text image:[self defaultImageByImageName:@"hint_error"] toContainer:container];
}

+ (void)showInfoMessage:(NSString *)text toContainer:(id)container {
    [self showCustomHUDWithText:text image:[self defaultImageByImageName:@"hint_warning"] toContainer:container];
}

+ (void)showCustomHUDWithText:(NSString *)text image:(UIImage *)image toContainer:(id)container {
    
    UIView *view = [self viewForContainer:container];
    [MBProgressHUD dismissForContainer:view];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = text;
    hud.bezelView.color = MB_BackgroundColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.contentColor = [UIColor whiteColor];
    hud.minSize = CGSizeMake(100, 100);
    hud.offset = CGPointMake(0, -20);
    
    if (text.length > 5) {
        hud.margin = 15;
        hud.square = NO;
    } else {
        hud.square = YES;
    }
    
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)setSuccessWithText:(NSString *)text forContainer:(id)container {
    
    [self setNewText:text image:[UIImage imageNamed:@"Checkmark"] forContainer:container];
}

+ (void)setErrorWithText:(NSString *)text forContainer:(id)container {
    
    [self setNewText:text image:[UIImage imageNamed:@"hint_error"] forContainer:container];
}

+ (void)setInfoWithText:(NSString *)text forContainer:(id)container {
    
    [self setNewText:text image:[UIImage imageNamed:@"hint_warning"] forContainer:container];
}

+ (void)setNewText:(NSString *)text image:(UIImage *)image forContainer:(id)container {
    
    UIView *view = [self viewForContainer:container];

    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    hud.customView = imageView;
    hud.bezelView.color = MB_BackgroundColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.contentColor = MB_ContentColor;
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = text;
    hud.minSize = CGSizeMake(100, 100);
    
    if (text.length > 5) {
        hud.margin = 15;
        hud.square = NO;
    } else {
        hud.square = YES;
    }
    
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)dismissForContainer:(id)container {
    
    [self dismissForContainer:container withDelay:0];
}

+ (void)dismissForContainer:(id)container withDelay:(NSTimeInterval)delay {
    
    UIView *view = [self viewForContainer:container];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hideAnimated:YES afterDelay:delay];
}

@end
