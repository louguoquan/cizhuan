//
//  YSPswView.h
//  DingDou
//
//  Created by yu on 2017/5/31.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSPswView : UIView

@property (nonatomic, copy) YSCompleteHandler     block;

@property (nonatomic, strong, readonly) NSString    *password;

- (void)beginInput;

@end
