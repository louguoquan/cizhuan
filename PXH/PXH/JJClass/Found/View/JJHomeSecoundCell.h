//
//  JJHomeSecoundCell.h
//  PXH
//
//  Created by louguoquan on 2018/9/4.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomeSecoundClick)(NSInteger index);

@interface JJHomeSecoundCell : UITableViewCell

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)HomeSecoundClick HomeSecoundClick;

@end
