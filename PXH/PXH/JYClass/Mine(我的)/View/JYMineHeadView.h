//
//  JYMineHeadView.h
//  PXH
//
//  Created by LX on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYMineHeadView : UIView

@property (nonatomic, assign) id           headImg;
@property (nonatomic, copy) NSString       *nameStr;
@property (nonatomic, copy) NSString       *numStr;
@property (nonatomic, strong) UIImageView   *headImgView;
@property (nonatomic, copy) dispatch_block_t    selHeadPhotoBlock;

@property (nonatomic, copy) dispatch_block_t    selLoginBlock;

@end
