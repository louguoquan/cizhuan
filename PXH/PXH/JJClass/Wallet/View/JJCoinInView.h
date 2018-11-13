//
//  JJCoinInView.h
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JJRefreshAccount)();

@interface JJCoinInView : UIView

@property (nonatomic,strong)JJRefreshAccount jjRefreshAccount;

- (void)setUpModel:(JJWalletModel *)model;

@end
