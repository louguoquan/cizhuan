//
//  JYDefaultDataModel.m
//  PXH
//
//  Created by louguoquan on 2018/6/12.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYDefaultDataModel.h"

#define DefaultDataArchive [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"defaultData.archive"]

static JYDefaultDataModel *_account = nil;

@implementation JYDefaultDataModel


//空值处理
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
//{
//    if (oldValue == nil) {
//        return @"";
//    }
//    return oldValue;
//}


+ (JYDefaultDataModel *)sharedDefaultData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:DefaultDataArchive];
    });
    return _account;
}

+ (void)saveDefaultData:(JYDefaultDataModel *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:DefaultDataArchive];
}

+ (void)deleteDefaultData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:DefaultDataArchive]) {
        NSError *error;
        [fileManager removeItemAtPath:DefaultDataArchive error:&error];
        
        if (!error) _account = nil;
    }
}

MJExtensionCodingImplementation


@end
