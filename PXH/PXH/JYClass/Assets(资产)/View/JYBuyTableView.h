//
//  JYBuyTableView.h
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ClickBtnWithStatus)(NSInteger index);               //

@interface JYBuyTableView : UIView

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ClickBtnWithStatus ClickBtnWithStatus;

@end
