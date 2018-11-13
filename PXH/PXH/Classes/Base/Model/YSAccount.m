
//
//  YSAccount.m
//  PXH
//
//  Created by yu on 2017/8/14.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSAccount.h"

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation YSAccount

static YSAccount *__account = nil;

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (YSAccount *)sharedAccount {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    });
    return __account;
}

+ (void)saveAccount:(YSAccount *)account {
    
    __account = account;
    
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}

+ (void)deleteAccount {
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:AccountPath]) {
        NSError *error;
        [fileMgr removeItemAtPath:AccountPath error:&error];
        if (!error) {
            __account = nil;
        }
    }
}

MJExtensionCodingImplementation


@end
