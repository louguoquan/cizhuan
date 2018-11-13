//
//  JYDisRecordController.h
//  PXH
//
//  Created by LX on 2018/6/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "YSPlainTableViewController.h"

typedef NS_ENUM(NSInteger, RecordType){
    ///提币记录
    RecordType_coin = 0,
    ///充币记录
    RecordType_Recharge = 1,
    /// 充值提现记录
    RecordType_Withdraw = 2,
};

@interface JYRecordController : YSPlainTableViewController

@property (nonatomic, assign) RecordType    type;

@property (nonatomic, copy)   NSString      *coinId;

@property (nonatomic, copy)   NSString      *coinCode;

@property (nonatomic, assign) BOOL           isPopRootVC;

@end
