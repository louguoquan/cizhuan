//
//  YSBaseTableViewController.h
//  PXH
//
//  Created by yu on 16/6/6.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "YSBaseViewController.h"

#import "UIScrollView+EmptyDataSet.h"

@interface YSBaseTableViewController : YSBaseViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, copy) NSString *emptyDesc;

@property (nonatomic, strong) UIImage *emptyImage;

@property (nonatomic, assign) CGFloat verticalOffset;


/**
 *  由子类实现   空白页点击回调
 */
- (void)emptyViewDidTap;

@end
