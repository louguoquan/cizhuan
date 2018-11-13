//
//  JYBusinessDetailView.h
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BusinessIsLoadMore)(BOOL isMore);
@interface JYBusinessDetailView : UIView

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)BusinessIsLoadMore BusinessIsLoadMore;
@property (nonatomic,strong)UITableView *tableView;
@end
