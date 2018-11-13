//
//  SDShareView.h
//  PXH
//
//  Created by 刘鹏程 on 2017/11/18.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShareView : UIView

@property (nonatomic, copy) void(^cancel)();
@property (nonatomic, copy) void(^selectPlatForm)(NSInteger plat);

@end
