//
//  YSRegion.m
//  YLFMember
//
//  Created by yu on 2017/2/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSRegion.h"

@implementation YSRegion

- (instancetype)initWithId:(NSString *)regionId name:(NSString *)name {
    self = [super init];
    if (self) {
        self.ID = regionId;
        self.name = name;
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"childreList" : [YSRegion class]};
}


MJExtensionCodingImplementation

@end
