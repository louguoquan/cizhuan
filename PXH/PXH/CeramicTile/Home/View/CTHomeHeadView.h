//
//  CTHomeHeadView.h
//  PXH
//
//  Created by louguoquan on 2018/11/12.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CTHomeHeadViewSetionSelect)(NSInteger index);

@interface CTHomeHeadView : UIView

@property (nonatomic,strong)CTHomeHeadViewSetionSelect CTHomeHeadViewSetionSelect;

@end

NS_ASSUME_NONNULL_END
