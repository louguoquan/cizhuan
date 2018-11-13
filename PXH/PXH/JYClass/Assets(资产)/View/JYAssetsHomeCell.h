//
//  JYAssetsHomeCell.h
//  PXH
//
//  Created by louguoquan on 2018/5/24.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAssetsModel.h"


typedef void (^C2CClick)();               //C2C
typedef void (^RollOutClick)();           //转币
typedef void (^TopUpClick)();             //充币
typedef void (^WithdrawalClick)();        //提现


@interface JYAssetsHomeCell : UITableViewCell

@property (nonatomic,assign)NSInteger row;
@property (nonatomic,strong)JYAssetsModel *model;

@property (nonatomic,strong)C2CClick C2CClick;
@property (nonatomic,strong)RollOutClick RollOutClick;
@property (nonatomic,strong)TopUpClick TopUpClick;
@property (nonatomic,strong)WithdrawalClick WithdrawalClick;


@end
