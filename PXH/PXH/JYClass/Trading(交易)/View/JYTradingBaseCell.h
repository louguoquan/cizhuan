//
//  JYTradingBaseCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTradingModel.h"


@interface JYTradingBaseCell : UITableViewCell

@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,strong)JYTradingBuyOreSellModel *model;

@end
