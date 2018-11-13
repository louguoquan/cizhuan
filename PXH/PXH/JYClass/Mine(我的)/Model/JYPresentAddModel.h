//
//  JYPresentAddModel.h
//  PXH
//
//  Created by LX on 2018/6/14.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYPresentAddModel : NSObject

@property (nonatomic, copy) NSString        *address;
@property (nonatomic, copy) NSString        *coinCode;
@property (nonatomic, copy) NSString        *coinId;
@property (nonatomic, copy) NSString        *coinName;
@property (nonatomic, copy) NSString        *createTime;

@property (nonatomic, copy) NSString        *ID;
@property (nonatomic, copy) NSString        *isDelete;
@property (nonatomic, copy) NSString        *remark;
@property (nonatomic, copy) NSString        *updateTime;
@property (nonatomic, copy) NSString        *userId;

@end
/*
 {
 "address": "详细地址啊  详细地址",
 "coinCode": "bcd",
 "coinId": 2,
 "coinName": "bcd",
 "createTime": "2018-06-14 16:13:57",
 "id": 19,
 "isDelete": 0,
 "remark": "备注   ",
 "updateTime": "2018-06-14 16:13:57",
 "userId": 19
 }
 */
