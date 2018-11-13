//
//  JYSearchView.h
//  PXH
//
//  Created by LX on 2018/5/23.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYSearchView : UIView

@property (nonatomic, copy) void(^SearchCurrencyBlock)(JYSearchView *searchView, NSString *currencyStr);

@end
