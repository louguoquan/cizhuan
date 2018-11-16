//
//  CTProductDetailBottomView.h
//  PXH
//
//  Created by louguoquan on 2018/11/14.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CTBottomAskClick)();


@interface CTProductDetailBottomView : UIView

@property (nonatomic,strong)CTBottomAskClick CTBottomAskClick;

@end

NS_ASSUME_NONNULL_END
