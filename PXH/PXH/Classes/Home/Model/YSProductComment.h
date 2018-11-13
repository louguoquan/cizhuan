//
//  YSProductComment.h
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSProductComment : NSObject

@property (nonatomic, strong) NSString  *ID;    //评论本身的id

@property (nonatomic, strong) NSString  *orderId;   //订单id

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString  *title; //标题

@property (nonatomic, strong) NSString  *productId; //产品id

@property (nonatomic, strong) NSString  *productName;   //产品名称

@property (nonatomic, strong) NSString  *productImage;  //产品图片

@property (nonatomic, strong) NSString  *productPrice;  //产品价格

@property (nonatomic, strong) NSString  *memberName;    //评论人名称

@property (nonatomic, strong) NSString  *memberId;  //评论人id

@property (nonatomic, strong) NSString  *memberLogo;    //评论人头像

@property (nonatomic, strong) NSString  *content;   //评论内容

@property (nonatomic, strong) NSString  *time;  //评论时间

@property (nonatomic, assign) CGFloat   score;

@property (nonatomic, strong) NSString  *commentCount;  //评论数

@property (nonatomic, copy)   NSArray   *images;    //评论图片

@end
