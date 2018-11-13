//
//  YSOrderSectionFooterView.h
//  PXH
//
//  Created by yu on 2017/8/10.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YSOrder.h"

@interface YSOrderActionView : UIView

@property (nonatomic, assign) NSInteger sendMethod;

- (void)setButtonWith:(NSInteger)status sendMethod:(NSInteger)sendMethod expressStatus:(NSInteger)expressStatus;

@end

@interface YSOrderSectionFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) YSOrder   *order;

@end
