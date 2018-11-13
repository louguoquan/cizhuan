//
//  SDError.m
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//

#import "SDError.h"

@implementation SDError

+ (id)errorWithCode:(NSInteger)errorCode Msg:(NSString *)errorMessage
{
    SDError *error = [[[self class] alloc] init];
    error.errorCode = errorCode;
    error.errorMessage = errorMessage;
    return error;
}

@end
