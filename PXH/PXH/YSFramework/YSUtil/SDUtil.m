
//
//  SDUtil.m
//  QingTao
//
//  Created by yu on 16/4/7.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import "SDUtil.h"
#import "NSDate+Sunday.h"

@implementation SDUtil

//验证金额
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //在textFiled中限制输入位数
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([self isPureFloat:text]) {
        //小数点后两位
        
        NSUInteger location = [text rangeOfString:@"."].location;
        
        if (location == NSNotFound || text.length <= location + 3) {
            return YES;
        }
    }
    return NO;
}

    //判断是否是double类型
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


@end
