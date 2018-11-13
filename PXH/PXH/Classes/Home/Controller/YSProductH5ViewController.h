//
//  YSProductH5ViewController.h
//  PXH
//
//  Created by yu on 2017/8/9.
//  Copyright © 2017年 yu. All rights reserved.
//

#import "YSBaseViewController.h"
#import "YSProductDetailViewController.h"

#import "YSProductDetail.h"
#import "JJShopModel.h"

@interface YSProductH5ViewController : YSBaseViewController

@property (nonatomic, weak)   YSProductDetailViewController *superViewController;

@property (nonatomic, strong) YSProductDetail   *detail;

@property (nonatomic, strong) JJShopModel   *detailJJ;


@end
