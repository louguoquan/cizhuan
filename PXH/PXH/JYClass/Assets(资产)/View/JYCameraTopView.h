//
//  JYCameraTopView.h
//  PXH
//
//  Created by LX on 2018/6/4.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCameraTopView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;

@end
