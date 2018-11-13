//
//  YSAllCommentViewController.h
//  PXH
//
//  Created by yu on 2017/8/23.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGroupedTableViewController.h"

@interface YSProductCommentViewController : YSGroupedTableViewController

@property (nonatomic, strong) NSString  *productId;

//评论类型 1 为产品评论 2为电子券评论
@property (nonatomic, assign) NSInteger type;

@end
