//
//  SDError.h
//  QingTao
//
//  Created by yu on 16/2/24.
//  Copyright © 2016年 Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDError : NSObject

@property (nonatomic, assign) NSInteger  errorCode;                       //错误码
@property (nonatomic, strong) NSString   *errorMessage;                     //服务器返回的错误信息

+ (id)errorWithCode:(NSInteger)errorCode Msg:(NSString *)errorMessage;


@end
