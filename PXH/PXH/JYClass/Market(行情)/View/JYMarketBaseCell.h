//
//  JYMarketBaseCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/22.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYMarketModel.h"

@interface JYMarketBaseCell : UITableViewCell

@property (nonatomic,strong)JYMarketModel *product;
@property (nonatomic,strong)NSString  *type;

@end
