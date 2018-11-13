//
//  JYPicturePicker.m
//  PXH
//
//  Created by LX on 2018/5/29.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYPicturePicker.h"

#define Image_Key @"default_PictureKey"


#define imagePath(imageKey) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:imageKey]


@interface JYPicturePicker ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@property (nonatomic, strong) UIViewController    *currentVC;
@property (nonatomic, copy)   selImageBlock       selBlock;

@end

@implementation JYPicturePicker

+(instancetype)sharedPicturePicker
{
    static JYPicturePicker *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] initPrivate];
    });
    return shared;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        //注册为低内存通知的观察者
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCaches:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    return self;
}

//MARK: --低内存清除图片
-(void)clearCaches:(NSNotification *)n
{
    NSLog(@"清除图片缓存 %ld", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}


//MARK: --保存图片
-(void)saveImage:(id)img forKey:(NSString *)key
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *image = nil;
        if (![img isKindOfClass:[UIImage class]]) {//urlString类型
            NSURL *url = [NSURL URLWithString:img];
            NSData *data = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:data];
        }
        else{
            image = img;
        }
        
        if (image) {
            [self.dictionary setObject:image forKey:imagePath(key)];
        }
        
        //从图片提取JPEG格式的数据,第二个参数为图片压缩参数
        //    NSData *data = UIImageJPEGRepresentation(image, 0.5);
        //以PNG格式提取图片数据
        NSData *data = UIImagePNGRepresentation(image);

        //将图片数据写入文件
        [data writeToFile:imagePath(key) atomically:YES];
    });
}

//MARK: --读取图片
-(UIImage *)readImageForKey:(NSString *)key
{
    NSString *fileName = key?key:Image_Key;
    UIImage *image = [self.dictionary objectForKey:fileName];
    
    if (!image) {
        image = [UIImage imageWithContentsOfFile:imagePath(key)];
        if (image) {
            [self.dictionary setObject:image forKey:fileName];
        }else{
            NSLog(@"无法找到图片文件%@", imagePath(key));
        }
    }
    
    return image;
}


// MARK: --调取相机或相册
-(UIImagePickerController *)pickUpCameraOrPhotoAlbum:(UIViewController *)currentVC selImageBlock:(selImageBlock)selBlock
{
    _currentVC = currentVC;
    _selBlock = selBlock;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.editing = YES;
    
    /*
     如果这里allowsEditing设置为NO，则delegate方法imagePickerController:中 didFinishPickingMediaWithInfo:的UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
     应该改为： UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
     也就是改为原图像，而不是编辑后的图像。
     */
    //允许编辑图片
    imagePicker.allowsEditing = YES;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
            NSLog(@"模拟器不能打开摄像头");
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [currentVC presentViewController:imagePicker animated:YES completion:nil];
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //解决iOS11打开系统相册列表向上偏移问题
        if (@available(iOS 11, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [currentVC presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }]];
    
    [currentVC presentViewController:alert animated:true completion:nil];
    
    return imagePicker;
}


#pragma mark ----- < UIImagePickerControllerDelegate > -----

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //解决iOS11打开系统相册列表向上偏移问题后，更改为原设置
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    /*获取选择的图片
    如果 picker.allowsEditing = NO,则key应设为原图“UIImagePickerControllerOriginalImage”
     */
    UIImage *images = [info valueForKey:UIImagePickerControllerEditedImage];
    
    //保存图片
//    [[JYPicturePicker sharedPicturePicker] saveImage:images forKey:nil];
    
    //把一张照片保存到图库中，此时无论是这张照片是照相机拍的还是本身从图库中取出的，都会保存到图库中；
    //    UIImageWriteToSavedPhotosAlbum(images, self, nil, nil);
    
    //压缩图片,如果图片要上传到服务器或者网络，则需要执行该步骤（压缩），第二个参数是压缩比例，转化为NSData类型；
    //    NSData *fileData = UIImageJPEGRepresentation(images, 0.5f);
    //    [self updateHeaderPicture:fileData];
    
    //关闭UIImagePickerController
    [_currentVC dismissViewControllerAnimated:YES completion:^{
        //传递选择的image
        !_selBlock?:_selBlock(images);
    }];
}


@end
