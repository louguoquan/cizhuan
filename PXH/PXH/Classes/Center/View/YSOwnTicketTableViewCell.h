//
//  YSOwnTicketTableViewCell.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSCoupons.h"

@interface YSOwnTicketTableViewCell : UITableViewCell

@property (nonatomic, strong) YSCoupons     *coupons;

@property (nonatomic, strong) UIButton  *commentButton;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, copy) void(^buttonAction)(NSDictionary *dic);

@end
