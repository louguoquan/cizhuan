//
//  YSTagListView.h
//  PXH
//
//  Created by yu on 2017/8/17.
//  Copyright © 2017年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YSProductDetail.h"

@interface YSTagListView : UIView

- (instancetype)initWithStandardArray:(NSArray *)standardArray changeHandler:(YSCompleteHandler)block;

@end
