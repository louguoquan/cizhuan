//
//  JYGuideController.h
//  PXH
//
//  Created by LX on 2018/6/21.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 //获取当前版本号
 #define CURRENT_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
 
 static NSString *JYAppCurrentVersion = @"APP_CURRENT_VERSION";
 

- (void)setUpRootController
{
    NSString *lastSaveV = [[NSUserDefaults standardUserDefaults] stringForKey:JYAppCurrentVersion];
    
    if ([lastSaveV isEqualToString:CURRENT_VERSION]) {
        [YSAccountService switchToRootViewControler:YSSwitchRootVcTypeTabbar];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:CURRENT_VERSION forKey:JYAppCurrentVersion];
        
        JYGuideController *vc = [[JYGuideController alloc] init];
        [vc setUpAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selPageColor, BOOL *showSkip, BOOL *showPageCountrol) {
            *imageArray = @[@"guide_1", @"guide_2", @"guide_3", @"guide_4"];
            *showPageCountrol = YES;
            *showSkip = YES;
        }];
        self.window.rootViewController = vc;
    }
}

*/



@interface JYGuideController : UIViewController

/**
 基础设置
 
 @param imageArray          图片数组
 @param selPageColor        选中小圆点的颜色
 @param showSkip            是否显示跳过按钮，默认NO
 @param showPageCountrol    是否显示小圆点，默认NO
 
 使用：
 [vc setUpAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selPageColor, BOOL *showSkip, BOOL *showPageCountrol) {
     *imageArray = @[@"guide_1", @"guide_2", @"guide_3", @"guide_4"];
     *showPageCountrol = YES;
     *showSkip = YES;
 }];
 */
- (void)setUpAttribute:(void(^)(NSArray **imageArray, UIColor **selPageColor, BOOL *showSkip, BOOL *showPageCountrol))baseSettingBlock;

@end



@interface JYGuideCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView    *contentImgView;
/** 立即体验 */
@property (nonatomic, strong) UIButton       *beginSupBtn;

/* 立即体验按钮图片 */
@property (nonatomic, copy) id               beginSupBtnImage;
/** 立即体验点击回调 */
@property (nonatomic, copy) dispatch_block_t beginSupBlock;

@end
