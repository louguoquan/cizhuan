//
//  YSRegion.h
//  YLFMember
//
//  Created by yu on 2017/2/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRegion : NSObject

@property (nonatomic, strong) NSString  *ID;

@property (nonatomic, strong) NSString  *name;

@property (nonatomic, strong) NSArray   *childreList;

- (instancetype)initWithId:(NSString *)regionId name:(NSString *)name;

@end
