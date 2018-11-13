//
//  YSProductDetail.h
//  PXH
//
//  Created by yu on 2017/8/15.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSProduct.h"
#import "YSProductComment.h"
#import "YSStandard.h"


@interface YSProductImage : NSObject

@property (nonatomic, strong) NSString      *image;

@property (nonatomic, strong) NSString      *url;

@property (nonatomic, assign) NSInteger     type;

//image = "http://ol-quan2017.oss-cn-shanghai.aliyuncs.com/imgs/51bc77ea8389e60be69b096129810771ff7fc1a4";
//productId = 14;
// = 1;
//url = "";

@end

@interface YSProductDetail : NSObject

@property (nonatomic, strong) NSString  *memberId;

@property (nonatomic, copy)   NSArray   *banners;

@property (nonatomic, strong) NSString  *couponId;

@property (nonatomic, strong) NSString  *area;

@property (nonatomic, strong) NSString  *address;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *catId;

/**
 1普通产品  2限量秒杀产品  3限时购产品
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) NSString  *image;

@property (nonatomic, copy)   NSArray<YSProductImage *>   *images;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, strong) NSString  *summary;

@property (nonatomic, assign) CGFloat   salePrice;

@property (nonatomic, assign) CGFloat   vipPrice;

@property (nonatomic, assign) CGFloat   costPrice;

@property (nonatomic, strong) NSString  *score;

@property (nonatomic, strong) NSString  *rateFee;

@property (nonatomic, copy)   NSArray   *tags;

@property (nonatomic, assign) NSInteger percent;

@property (nonatomic, assign) NSInteger isGroup;   //是否为组合产品

@property (nonatomic, strong) NSString  *expressFee;

@property (nonatomic, strong) NSString  *soldCount;

@property (nonatomic, strong) NSString  *detail;

@property (nonatomic, strong) NSString  *detailUrl;

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, strong) NSString  *store;

@property (nonatomic, assign) NSInteger isCollect;

@property (nonatomic, strong) NSString  *codeImageUrl;

@property (nonatomic, strong) NSString  *saleCount;

@property (nonatomic, strong) NSString *goodComment; //好评率

@property (nonatomic, copy)   NSArray<YSStandard *>   *normals;

@property (nonatomic, copy)   NSArray<YSProductComment *>   *comments;

@property (nonatomic, copy)   NSArray<YSProduct *>   *products;

@end
