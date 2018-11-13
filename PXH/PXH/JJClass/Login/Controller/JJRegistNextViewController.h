//
//  JJRegistNextViewController.h
//  PXH
//
//  Created by louguoquan on 2018/7/23.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import "YSBaseScrollViewController.h"

@interface JJRegistNextViewController : YSBaseScrollViewController


@property (nonatomic,assign)BOOL isResetPwd;

@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *mobileOrEmail;


@end
