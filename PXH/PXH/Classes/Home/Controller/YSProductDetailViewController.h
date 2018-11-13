//
//  YSProductDetailViewController.h
//  PXH
//
//  Created by yu on 2017/8/8.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSGroupedTableViewController.h"

@interface YSProductDetailViewController : YSBaseScrollViewController

@property (nonatomic, strong) NSString     *productId;

- (void)scrollToTop;

- (void)scrollToBottom;

@end
