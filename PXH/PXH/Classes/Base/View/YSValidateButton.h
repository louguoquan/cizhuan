//
//  YSValidateButton.h
//  ZSMStores
//
//  Created by yu on 16/8/5.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSValidateButton : UIButton

- (instancetype)initWithSeconds:(NSInteger)seconds;

- (void)sendCodeToPhoneNumber:(NSString *)number type:(NSInteger)type;


@end
