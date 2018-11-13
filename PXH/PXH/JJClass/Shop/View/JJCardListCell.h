//
//  JJCardListCell.h
//  PXH
//
//  Created by louguoquan on 2018/9/4.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCardListModel.h"
#import "JJGiftModel.h"

typedef void(^JJCardListCellClick)();


@interface JJCardListCell : UITableViewCell

@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)JJCardListModel *model;

@property (nonatomic,strong)JJGiftModel *giftModel;

@property (nonatomic,strong)JJCardListCellClick JJCardListCellClick;



@end
