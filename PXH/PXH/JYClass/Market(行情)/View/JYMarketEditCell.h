//
//  JYMarketEditCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYMarketModel.h"


typedef void (^MarketEditDelectCell)();

@interface JYMarketEditCell : UITableViewCell

@property (nonatomic,strong)JYMarketModel *product;

@property (nonatomic,strong)MarketEditDelectCell MarketEditDelectCell;

@end
