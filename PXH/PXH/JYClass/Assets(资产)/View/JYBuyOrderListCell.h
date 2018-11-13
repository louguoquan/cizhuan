//
//  JYBuyOrderListCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBuyOrderListModel.h"


typedef void (^OrderPaySuccess)();               //订单标记支付成功
typedef void (^OrderPayCancel)();               //订单取消


@interface JYBuyOrderListCell : UITableViewCell

@property (nonatomic,strong)JYBuyOrderListModel *model;
@property (nonatomic,strong)OrderPayCancel OrderPayCancel;
@property (nonatomic,strong)OrderPaySuccess OrderPaySuccess;

@end
