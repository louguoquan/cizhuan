//
//  YSOrderProduct.h
//  PXH
//
//  Created by yu on 2017/8/20.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSOrderProduct : NSObject

@property (nonatomic, strong) NSString  *orderItemId;

@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *productName;

@property (nonatomic, strong) NSString  *productImage;

@property (nonatomic, strong) NSString  *normal;

@property (nonatomic, assign) CGFloat   price;

@property (nonatomic, strong) NSString  *num;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString  *status;

@property (nonatomic, strong) NSString  *commission;

@property (nonatomic, strong) NSString  *express;

@property (nonatomic, strong) NSString  *expressNo;

@property (nonatomic, strong) NSString  *sendTime;


#pragma mark - extension
@property (nonatomic, assign) CGFloat   extScore1;

@property (nonatomic, assign) CGFloat   extScore2;

@property (nonatomic, strong) NSString  *extContent;

@property (nonatomic, copy)   NSArray   *extImages;

@property (nonatomic, copy)   NSArray   *extImageUrls;

@end
