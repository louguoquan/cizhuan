//
//  CTWordOfMouthHeadView.h
//  PXH
//
//  Created by louguoquan on 2018/11/13.
//  Copyright © 2018 LouGuoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CTWordOfMouthHeadViewClick)(NSInteger index);



@interface CTWordOfMouthHeadView : UIView

@property (nonatomic,strong)CTWordOfMouthHeadViewClick CTWordOfMouthHeadViewClick;

@end

NS_ASSUME_NONNULL_END
