//
//  JYC2CBuyNextView.h
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYBankModel.h"
#import "JYBuyTableView.h"


@interface JYC2CBuyNextView : UIView

@property (nonatomic,strong)JYBankModel *model;

@property (nonatomic,strong)JYBuyTableView *buyTableView;

@property (nonatomic,strong)UIView   *noteView;

@end
