//
//  YSServiceStation.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSServiceStation : NSObject

@property (nonatomic, strong) NSString  *ID; //服务点id

@property (nonatomic, strong) NSString  *name ;//服务点名称

@property (nonatomic, strong) NSString  *person; //联系人

@property (nonatomic, strong) NSString  *mobile; //联系电话

@property (nonatomic, assign) CGFloat   distance; //距离

@property (nonatomic, assign) CGFloat   lng; //经度

@property (nonatomic, assign) CGFloat   lat; //纬度

@property (nonatomic, strong) NSString  *address; //服务点地址

@property (nonatomic, assign) BOOL      takeTheir;  //是否自提

@property (nonatomic, assign) BOOL      shortestDistance;  //是否最近

@end
