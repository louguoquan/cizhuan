//
//  YSDeliverTableViewCell.h
//  PXH
//
//  Created by futurearn on 2017/11/30.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSDeliver.h"
@interface YSDeliverTableViewCell : UITableViewCell

@property (nonatomic, strong) YSDeliver *deliver;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, copy) void(^refreshData)();

@end
