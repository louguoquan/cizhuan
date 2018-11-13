//
//  JYC2CBuyView.h
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYUSDTModel.h"

typedef void (^OrderCreateSuccess)();               //订单创建成功


@interface JYC2CBuyView : UIView

@property (nonatomic,strong)UIButton *buyBtn;
@property (nonatomic,strong)OrderCreateSuccess OrderCreateSuccess;
@property (nonatomic,strong)JYUSDTModel *model;
@property (nonatomic,strong)NSString *isStop;



@end
