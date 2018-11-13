//
//  YSProductDescViewController.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGroupedTableViewController.h"
#import "YSProductDetailViewController.h"

#import "YSProductDetail.h"
#import "JJShopModel.h"

@interface YSProductDescViewController : YSGroupedTableViewController

@property (nonatomic, weak) YSProductDetailViewController *superViewController;

@property (nonatomic, strong) YSProductDetail   *detail;

@property (nonatomic, strong) JJShopModel   *detailJJ;


@property (nonatomic, strong) dispatch_block_t titleShow;

@property (nonatomic, strong) dispatch_block_t titleHidden;

@end

