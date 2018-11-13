//
//  YSImagePickerManager.m
//  YLFMember
//
//  Created by yu on 2017/3/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSImagePickerManager.h"

#import <UIViewController+YMSPhotoHelper.h>

@interface YSImagePickerManager ()<YMSPhotoPickerViewControllerDelegate>

@property (nonatomic, copy) ChoosePhotosHandle  block;

@property (nonatomic, assign) UIViewController  *delegate;

@end

@implementation YSImagePickerManager

+ (YSImagePickerManager *)shareManager
{
    static YSImagePickerManager *imagePickerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePickerManager = [[YSImagePickerManager alloc] init];
    });
    return imagePickerManager;
}

+ (void)ys_ChooseImagesWithMaxCount:(NSInteger)count delegate:(UIViewController *)delegate complateBlock:(ChoosePhotosHandle)block
{
    [self shareManager].block = block;
    [self shareManager].delegate = delegate;
    
    YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
    pickerViewController.theme.cameraVeilColor = MAIN_COLOR;
    //是否调用单张图片回调
    pickerViewController.shouldReturnImageForSingleSelection = NO;
    
    //    pickerViewController.theme.titleLabelTextColor = [UIColor whiteColor];
    //    pickerViewController.theme.navigationBarBackgroundColor = customColor;
    pickerViewController.theme.tintColor = [UIColor whiteColor];
    pickerViewController.theme.orderTintColor = MAIN_COLOR;
    pickerViewController.theme.cameraVeilColor = MAIN_COLOR;
    pickerViewController.theme.cameraIconColor = [UIColor whiteColor];
    //    pickerViewController.theme.statusBarStyle = UIStatusBarStyleLightContent;

    pickerViewController.numberOfPhotoToSelect = count;
    
    [delegate yms_presentCustomAlbumPhotoView:pickerViewController delegate:[self shareManager]];
}

#pragma mark - delegate  
    //相册授权
- (void)photoPickerViewControllerDidReceivePhotoAlbumAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"允许访问相册" message:@"需要你的许可来访问相册" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    [self.delegate presentViewController:alertController animated:YES completion:nil];
}
    //照相机授权
- (void)photoPickerViewControllerDidReceiveCameraAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"允许访问照相机?" message:@"需要你的许可来访问照相机" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    [self.delegate presentViewController:alertController animated:YES completion:nil];
}

    //选择多张图片
- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray<PHAsset*> *)photoAssets
{
    WS(weakSelf);
    [picker dismissViewControllerAnimated:YES completion:^() {
        // Remember images you get here is PHAsset array, you need to implement PHImageManager to get UIImage data by yourself
        PHImageManager *imageManager = [[PHImageManager alloc] init];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.networkAccessAllowed = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.synchronous = YES;
        
        NSMutableArray *mutableImages = [NSMutableArray array];
        
        for (PHAsset *asset in photoAssets) {
            CGSize targetSize = CGSizeMake(kScreenWidth * [UIScreen mainScreen].scale, kScreenHeight * [UIScreen mainScreen].scale);
            [imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *image, NSDictionary *info) {
                [mutableImages addObject:image];
            }];
        }
        
        if (weakSelf.block) {
            weakSelf.block(mutableImages);
        }
    }];
}

    //选择单张图片
- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImage:(UIImage *)image
{
    UIImage *targetImage = [self imageCompressWithImage:image];
    
    WS(weakSelf);
    [picker dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.block) {
            weakSelf.block(@[targetImage]);
        }
    }];
}

- (UIImage *)imageCompressWithImage:(UIImage *)image
{
    CGFloat value = MAX(image.size.height, image.size.width);
    if (value < (kScreenHeight * [UIScreen mainScreen].scale)) {
        return image;
    }
    CGFloat scaledValue = (kScreenHeight * [UIScreen mainScreen].scale) / value;
    
    CGSize newSize = CGSizeMake(image.size.width * scaledValue, image.size.height * scaledValue);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


//    //取消选择
//- (void)photoPickerViewControllerDidCancel:(YMSPhotoPickerViewController *)picker
//{
//    
//}

@end
