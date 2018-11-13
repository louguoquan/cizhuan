//
//  YSPagingListService.h
//  HouseDoctorMonitor
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSPagingListService : NSObject

@property (nonatomic, strong) NSMutableArray    *dataSource;


/**
 创建实例
 
 @param aclass 请求类
 @param action 请求方法   方法必须包含两个参数 1.参数(字典类型) 2.页数  3.block(YSCompleteHandler)
 @return 实例
 */
- (instancetype)initWithTargetClass:(Class)aclass action:(SEL)action;

- (void)loadDataWithParameters:(NSDictionary *)parameters isLoadMore:(BOOL)loadMore completion:(YSCompleteHandler)completion;

@end
