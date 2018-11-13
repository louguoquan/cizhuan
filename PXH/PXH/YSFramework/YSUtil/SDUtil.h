//
//  SDUtil.h
//  QingTao
//
//  Created by yu on 16/4/7.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDUtil : NSObject

    //验证金额
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
