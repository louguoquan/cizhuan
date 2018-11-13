//
//  YSRegionReformer.h
//  QingTao
//
//  Created by yu on 16/4/23.
//  Copyright © 2016年 com.sunday-mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSRegion.h"

typedef void(^successReformer)(id responseObject);
typedef void(^failureReformer)(SDError *error);

@interface YSRegionReformer : NSObject

+ (YSRegionReformer *)shareInstance;

- (void)fetchRegionListSuccess:(successReformer)success
                        failure:(failureReformer)failure;

- (void)fetchStreetListWithDistrictId:(NSString *)districtId success:(successReformer)success failure:(failureReformer)failure;

@end
