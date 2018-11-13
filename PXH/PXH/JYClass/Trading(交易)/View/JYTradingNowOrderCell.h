//
//  JYTradingNowOrderCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/27.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTradingOrderModel.h"

typedef void (^MatchCancel)();
@interface JYTradingNowOrderCell : UITableViewCell


@property (nonatomic,strong)JYTradingOrderModel *model;
@property (nonatomic,strong)MatchCancel MatchCancel;

@end
