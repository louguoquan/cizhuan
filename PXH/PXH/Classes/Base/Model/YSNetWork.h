//
//  YSNetWork.h
//  PXH
//
//  Created by futurearn on 2017/12/5.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSAccount.h"

@interface YSNetWork : NSObject

+ (void)uploadClientID:(NSString *)CID;

+ (void)clearCID;

@end
