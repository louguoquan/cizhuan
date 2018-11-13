//
//  JYWithdrawalView.h
//  PXH
//
//  Created by louguoquan on 2018/5/25.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYWithdrawalMessageView.h"
#import "JYWithdrawalTransferView.h"
#import "IQKeyboardManager.h"
#import "JYC2CRecordListCell.h"


@interface JYWithdrawalView : UIView

@property (nonatomic,strong)JYWithdrawalMessageView  *messageView;  //法币交易说明
@property (nonatomic,strong)JYWithdrawalTransferView *transferView;  //平台内转账

@end
