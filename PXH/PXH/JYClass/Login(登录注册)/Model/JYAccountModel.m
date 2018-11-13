//
//  JYAccountModel.m
//  PXH
//
//  Created by LX on 2018/5/31.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYAccountModel.h"

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JJaccount.archive"]

@implementation JYAccountModel

static JYAccountModel *_account = nil;

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             };
}

//空值处理
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
//{
//    if (oldValue == nil) {
//        return @"";
//    }
//    return oldValue;
//}


+ (JYAccountModel *)sharedAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    });
    return _account;
}

+ (void)saveAccount:(JYAccountModel *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}

+ (void)deleteAccount
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:AccountPath]) {
        NSError *error;
        [fileManager removeItemAtPath:AccountPath error:&error];
       
        if (!error) _account = nil;
    }
}

MJExtensionCodingImplementation

@end
