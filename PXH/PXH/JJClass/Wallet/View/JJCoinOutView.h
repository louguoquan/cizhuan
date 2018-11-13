//
//  JJCoinOutView.h
//  PXH
//
//  Created by louguoquan on 2018/7/26.
//  Copyright © 2018年 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^JJTransformClick)();

@interface JJCoinOutView : UIView

@property (nonatomic,strong)JJTransformClick jjTransformClick;

@property (nonatomic,strong)YSCellView *countCell;
@property (nonatomic,strong)YSCellView *addressCell;
@property (nonatomic,strong)YSCellView *busPwd;
@property (nonatomic,strong)UILabel *padingLabel;


- (void)setUpModel:(id)model;

@end
