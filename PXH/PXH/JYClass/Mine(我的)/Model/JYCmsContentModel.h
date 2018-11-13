//
//  JYCmsContentModel.h
//  PXH
//
//  Created by LX on 2018/6/16.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCmsContentModel : NSObject

@property (nonatomic, copy) NSString        *appImg;
@property (nonatomic, copy) NSString        *collectionCount;
@property (nonatomic, copy) NSString        *commentCount;
@property (nonatomic, copy) NSString        *content;
@property (nonatomic, copy) NSString        *ct;

@property (nonatomic, copy) NSString        *deleted;
@property (nonatomic, copy) NSString        *desc;
@property (nonatomic, copy) NSString        *goodCount;
@property (nonatomic, copy) NSString        *ID;
@property (nonatomic, copy) NSString        *image;

@property (nonatomic, copy) NSString        *isRecommend;
@property (nonatomic, copy) NSString        *itemId;
@property (nonatomic, copy) NSString        *title;
@property (nonatomic, copy) NSString        *url;
@property (nonatomic, copy) NSString        *ut;

@property (nonatomic, copy) NSString        *viewCount;

@end

/*
 {
 "appImg": "",
 "collectionCount": 0,
 "commentCount": 0,
 "content": "测试测试测试测试测试测试测试测试测试测试测试测试测试",
 "ct": 1527594549913,
 "deleted": false,
 "desc": "",
 "goodCount": 0,
 "id": 1,
 "image": "http://admin.jinshengjiankang.com/upload/",
 "isRecommend": 0,
 "itemId": 1,
 "title": "新手操作（测试）",
 "url": "",
 "ut": 1527594549913,
 "viewCount": 0
 }
 */
