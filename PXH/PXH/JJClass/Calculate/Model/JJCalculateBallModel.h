//
//  JJCalculateBallModel.h
//  PXH
//
//  Created by louguoquan on 2018/7/30.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJCalculateBallModel : NSObject

@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *memberId;
@property (nonatomic,strong)NSString *reward;
@property (nonatomic,strong)NSString *staue;
@property (nonatomic,strong)NSString *updateTime;
@property (nonatomic,strong)NSString *ID;


@end


@interface JJCalculateBallBaseModel : NSObject

@property (nonatomic,strong)NSString *countDown;
@property (nonatomic,strong)NSArray <JJCalculateBallModel *> *dayReward;
@property (nonatomic,strong)NSString *myCount;
@property (nonatomic,strong)NSString *MACH;


@end

