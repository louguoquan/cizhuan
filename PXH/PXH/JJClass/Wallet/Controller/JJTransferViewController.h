//
//  JJTransferViewController.h
//  PXH
//
//  Created by louguoquan on 2018/7/25.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "YSBaseScrollViewController.h"
#import "JJTransformModel.h"
@interface JJTransferViewController : YSBaseScrollViewController

@property (nonatomic,strong)NSString *coinName;
@property (nonatomic,strong)JJTransformModel *model;

@end
