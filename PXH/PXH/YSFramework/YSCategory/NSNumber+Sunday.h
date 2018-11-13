//
//  NSNumber+Sunday.h
//  QingTao
//
//  Created by 管振东 on 16/2/23.
//  Copyright © 2016年 guanzd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Sunday)

/**
 Creates and returns an NSNumber object from a string.
 Valid format: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (NSNumber *)numberWithString:(NSString *)string;

@end
