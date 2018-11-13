//
//  JJCoinInOrOutCell.h
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCoinInOrOutModel.h"

@interface JJCoinInOrOutCell : UITableViewCell


@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)JJCoinInOrOutModel *model;
@property (nonatomic,strong)JJWalletBussinessModel *bussinessModel;

@end
