//
//  JYPicturePicker.h
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^selImageBlock)(UIImage *selImage);

@interface JYPicturePicker : NSObject


+(instancetype)sharedPicturePicker;


/**
 保存图片

 @param img UIimge或urlString
 @param key 保存图片到沙盒的key值（若为nil则使用默认）
 */
-(void)saveImage:(id)img forKey:(NSString *)key;


/**
 读取图片
 
 @param key 读取图片到沙盒的key值（若为nil则使用默认）
 */
-(UIImage *)readImageForKey:(NSString *)key;


/**
  创建UIImagePickerController调取相机或相册

 在调用相机时，需在Info.plist文件中增加 Privacy - Camera Usage Description 以获取相机访问权限;

 @param currentVC 当前的VC
 @param selBlock 选择图片后的回调，”selImage“选择的image
 
 @return ImagePickerController
 */
-(UIImagePickerController *)pickUpCameraOrPhotoAlbum:(UIViewController *)currentVC selImageBlock:(selImageBlock)selBlock;

@end
