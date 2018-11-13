//
//  JYDefaultDataModel.h
//  PXH
//
//  Created by louguoquan on 2018/6/12.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYDefaultDataModel : NSObject

//解挡
+ (JYDefaultDataModel *)sharedDefaultData;

//归档
+ (void)saveDefaultData:(JYDefaultDataModel *)defaultData;

//删除归档
+ (void)deleteDefaultData;


//购买的币种
@property (nonatomic,strong)NSString *coinBaseID;
//购买的币种名称
@property (nonatomic,strong)NSString *coinBaseName;

//交易对币种
@property (nonatomic,strong)NSString *coinPayID;
//交易对名称
@property (nonatomic,strong)NSString *coinPayName;

//是否收藏
@property (nonatomic,strong)NSString *status;

//币种页面是否是首页
@property (nonatomic,strong)NSString *isHomeCome;

//k线图是否绿涨红跌
@property (nonatomic,strong)NSString *isRose;

//实时服务器时间
@property (nonatomic,assign)long long systemTime;

//退出时服务器时间
@property (nonatomic,assign)long long systemTimeLast;


//是否可交易
@property (nonatomic,strong)NSString *tradeStatus;



@end
