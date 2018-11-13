//
//  JYBuyOrSaleView.h
//  PXH
//
//  Created by louguoquan on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTextField.h"


typedef void (^BuyOrSaleCountHalf)(NSInteger index);
typedef void (^BuyOrSale)(BOOL isBuy);
typedef void (^priceChange)(NSString *price);
typedef void (^countChange)(NSString *count);

@interface JYBuyOrSaleView : UIView

@property (nonatomic,strong)JYTextField *priceTF;    //委托价格
@property (nonatomic,strong)JYTextField *countTF;    //委托数量
@property (nonatomic,strong)UILabel *pricelLabel;    //委托价格转换成人民币价格
@property (nonatomic,strong)UILabel *canBuyLabel;    //可买币数量
@property (nonatomic,strong)UILabel *payAccountLabel;//交易额
@property (nonatomic,strong)UILabel *poundageLabel;  //手续费
@property (nonatomic,strong)UILabel *canUseBTCCoin;  //可用比特币数量
@property (nonatomic,strong)UILabel *freeBTCCoin;    //冻结的比特币数量
@property (nonatomic,strong)UILabel *canUseETHCoin;  //可用以太坊数量
@property (nonatomic,strong)UILabel *freeETHCoin;    //冻结的以太坊数量
@property (nonatomic,strong)UIButton *buyOrSaleBtn;  //买卖按钮

@property (nonatomic,assign) NSInteger type;   //1:买入 2:卖出
@property (nonatomic,strong) NSString * baseCoin;   //比价币类型 （名称）
@property (nonatomic,strong) NSString * buyCoin;   //买入币类型 （名称）


@property (nonatomic,strong)BuyOrSaleCountHalf BuyOrSaleCountHalf;   //委托数量25%，50%，75%，100%点击block

@property (nonatomic,strong)BuyOrSale BuyOrSale;
@property (nonatomic,strong)priceChange priceChange;
@property (nonatomic,strong)countChange countChange;


@end
