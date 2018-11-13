//
//  YSPagingListService.m
//  HouseDoctorMonitor
//
//  Created by yu on 2017/7/19.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSPagingListService.h"

#import <objc/runtime.h>

typedef void (*YSIMP)(id, SEL, NSDictionary *dict, NSInteger pageNo, YSCompleteHandler block);

@interface YSPagingListService ()

@property (nonatomic, assign) NSInteger     currentPage;

@property (nonatomic, strong) Class     aclass;

@property (nonatomic, assign) SEL       action;

@end

@implementation YSPagingListService

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (instancetype)initWithTargetClass:(Class)aclass action:(SEL)action {
    self = [super init];
    if (self) {
        _currentPage = 0;
        
        self.aclass = aclass;
        self.action = action;
        
    }
    return self;
}

- (void)loadDataWithParameters:(NSDictionary *)parameters isLoadMore:(BOOL)loadMore completion:(YSCompleteHandler)completion {
    
    YSIMP imp = (YSIMP)[self.aclass methodForSelector:self.action];
    
    if (imp) {
        NSInteger page = loadMore ? _currentPage + 1 : 1;

        imp(self.aclass, self.action, parameters, page, ^(NSArray *result, id error){
            if (result) {
                if (page == 1) {
                    [_dataSource removeAllObjects];
                }
                [_dataSource addObjectsFromArray:result];
            }

            _currentPage = result.count > 0 ? page : _currentPage;
        
            if (completion) {
                completion(result, error);
            }
        });
    }else {
        SDError *error = [SDError errorWithCode:-10086 Msg:@"网络错误"];
        if (completion) {
            completion(nil, error);
        }
    }
}

@end
