//
//  JYWithdrawalTransferView.h
//  PXH
//
//  Created by louguoquan on 2018/5/26.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYWithdrawalTransferModel.h"
#import "JYTextField.h"

@interface JYWithdrawalTransferView : UIView

@property (nonatomic,strong)JYTextField *coinTypeTF;
@property (nonatomic,strong)UITextField *coinCountTF;
@property (nonatomic,strong)UILabel     *coinworthLabel;
@property (nonatomic,strong)JYTextField *bankNumTF;
@property (nonatomic,strong)UITextField *accountTF;
@property (nonatomic,strong)UITextField *passwordTF;
@property (nonatomic,strong)UITextField *codeTF;

@property (nonatomic,strong)JYWithdrawalTransferModel *model;

//MARK: -- 获取我的币种
- (void)gainCurrencyType:(BOOL)isMeunView;

@end
