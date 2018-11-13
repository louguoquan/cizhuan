//
//  JJTaskModel.h
//  PXH
//
//  Created by louguoquan on 2018/8/13.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJTaskModel : NSObject

@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *time;
/*
 "content": "每日登陆算力+0.1",
 "id": 6,
 "img": "http://mobile.machdary.org/tp/denglu.png",
 "number": 0,
 "title": "每日登陆",
 "type": ""
 */

@end
