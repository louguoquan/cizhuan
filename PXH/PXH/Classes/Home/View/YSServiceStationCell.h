//
//  YSServiceStationCell.h
//  PXH
//
//  Created by yu on 2017/8/21.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSServiceStation.h"

@interface YSServiceStationCell : UITableViewCell

@property (nonatomic, strong) YSServiceStation  *station;

@property (nonatomic, strong) UIButton  *checkButton;

@end
